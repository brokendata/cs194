package com.brokendata
import scalaz._
import Scalaz._

object Week4 {
  /*
  Reimplement the functions fun1 and fun2 in a `wholemeal` manner, using higher order functions
   */

  def fun1(li: List[Int]): Int = li match {
    case x ::xs if (x %2 ==0) => (x-2) * fun1(xs)
    case x :: xs => fun1(xs)
  }

  def fun2(i: Int): Int = i match {
    case 1 => 0
    case n if (n % 2 == 0) => n + fun2(n / 2)
    case n => fun2(3 * n +1)
  }

  def f1(ls:List[Int]): Int = ls.filter(_ % 2 ==0).map(_ -2).sum
  def f2 (x:Int): Int = iterate(f,x).takeWhile(_ > 0).sum

   // Helper functions for wholemeal f2
  def iterate[A](f: A => A, n:A): Stream[A] = Stream.cons(n, iterate(f,f(n)))
  def f(x:Int): Int = if (x % 2 ==0) x / 2 else (x*3) + 1

  //................................
  //Exercise 2: Fun with Balanced Trees
  //................................

  sealed trait Tree[+A]
  final case class Node[+A](i: Int, l: Tree[A], v: A, r: Tree[A]) extends Tree[A]
  final case object  Leaf extends Tree[Nothing]

  def insert[A <:Ordered[A]](v: A, t: Tree[A]): Tree[A] = t match {
    case Leaf => Node(0,Leaf,v,Leaf)
    case Node(i,l,a,r) => if (v >=a) Node(i+1,l,v,insert(a,r))
    else Node(i+1,insert(a,l),v,r)
  }

  List("a","b","c","d").foldRight(Leaf: Tree[String])((a,z) => insert(a,z))

  //................................
  //Exercise 3: More Folds!
  //................................

  def xor(lb: List[Boolean]): Boolean= ???

  def map_[A,B](la: List[A])(f: A => B): List[B] =
    la.foldRight(List.empty[B])(f(_) :: _)

  def myFoldL()

}
