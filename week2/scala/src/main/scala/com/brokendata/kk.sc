import scalaz._
import Scalaz._

sealed trait Person
case class UserID(id: Long) extends Person
case class TeacherID(id: Int) extends Person

object Person{//
  //implicit val U: Equal[UserID] = Equal.equalBy(_.id) //
  implicit val T: Equal[TeacherID] = Equal.equalA
}

val x = UserID(3)
val c = TeacherID(3)
x === x
c === c


