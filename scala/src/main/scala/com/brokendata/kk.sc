

val x = Stream.from(1)
x zip x.map(_+1).take(3).force