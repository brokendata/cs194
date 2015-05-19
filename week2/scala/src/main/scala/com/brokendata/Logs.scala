package com.brokendata
import scalaz._
import Scalaz._
import effect._
import IO._

object Data {

  sealed trait MessageType
  case object Info extends MessageType
  case object Warning extends MessageType
  case class Error(n: Int) extends MessageType

  type TimeStamp = Int

  sealed trait LogMessage
  case class LMessage(mtype: MessageType, timestamp: TimeStamp, misc: String) extends LogMessage
  case class Unknown(s: String) extends LogMessage

}

object Functions{
  import Data._

  type parseResult = List[LogMessage]

  def parseMessage(s: String): LogMessage = s.split("\\s").toList match {
    case "E" :: _code :: _timestamp :: xs => LMessage(Error(_code.toInt),_timestamp.toInt,xs.mkString(" "))
    case "I" :: _timestamp :: xs          => LMessage(Info,_timestamp.toInt,xs.mkString(" "))
    case x::xs                            => Unknown((x::xs).mkString(" "))
    }

  def readFile(fname: String): IO[Stream[String]]= IO{
    val source = scala.io.Source.fromFile(fname)
    source.getLines.toStream
  }

  def testParse(fname: String,numLines: Int)(parser: String => LogMessage) =
    readFile(fname).map{lines =>
      lines.map(parser).take(numLines).toList
    }.unsafePerformIO

}

object Tree{
  import Data._

  sealed trait MessageTree[+A]
  case object Leaf extends MessageTree[Nothing]
  case class Node[+A](l: MessageTree[A], v: LMessage, r: MessageTree[A]) extends MessageTree[A]

  def insert(lm: LogMessage, mt: MessageTree[LogMessage]): MessageTree[LogMessage] =  (lm,mt) match {
    case (Unknown(_), mt) => mt
    case (lm: LMessage ,Leaf) => Node(Leaf, lm, Leaf)
    case (lm: LMessage, Node(left,current:LMessage,right)) if lm.timestamp < current.timestamp => Node(insert(lm,left),current,right)
    case (lm: LMessage, Node(left,current:LMessage,right)) if lm.timestamp >= current.timestamp => Node(left,current,insert(lm,right))
  }

  def build(llm: List[LogMessage]):MessageTree[LogMessage]  = llm match {
    case Nil => Leaf
    case x :: xs => insert(x,build(xs))
  }

  def inOrder(mt: MessageTree[LogMessage]): List[LogMessage] = mt match {
    case Leaf => Nil
    case Node(l, v, r) => inOrder(l) ++ List(v) ++ inOrder(r)
  }

  val whatWentWrong = build _ andThen inOrder _ andThen {(_: List[LogMessage]).collect{
    case l @ LMessage(Error(v),t,m) if v > 50 => l
  }}

}