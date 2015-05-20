import scalaz._
import Scalaz._
import com.brokendata.Tree._
import com.brokendata.Data._
import com.brokendata.Functions._


val l1 = LMessage(Info,10,"adsf" )
val l2 = LMessage(Info,12,"adsf" )
val l3 = LMessage(Info,9,"adsf" )
val l4 = LMessage(Error(55),9, "aaa")

val llist = List(l1,l2,l3,l4)

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



val g

llist.collect{
  case l @ LMessage(Error(v),t,m) if v > 50 => l
}
