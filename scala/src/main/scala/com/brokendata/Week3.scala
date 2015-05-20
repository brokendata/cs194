package com.brokendata

object Week3 {
  def skips[A](la: List[A], n:Int): List[A] =
    for {x <- la.zip(Stream.from(1)) if x._2  % n == 0} yield x._1

  def localMax(ls:List[Int]): List[Int] = ls match {
    case x :: y :: z :: xs if (y > x && y > z) => y ::  localMax(y::z::xs)
    case x :: xs => localMax(xs)
    case Nil => Nil
  }

}
