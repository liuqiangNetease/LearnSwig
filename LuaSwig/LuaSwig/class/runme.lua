


a=example.Square(10)
--b=example.LQEngine.base.Circle(1)
print(a.x)

print("Currently there are",example.Shape.nshapes,"shapes (there should be 2)")

o=example.LQEngine.base.ShapeOwner()
c=example.createCircle(2)
print(c:area())
o:add(c)

--print("Currently there are",example.LQEngine.base.Shape.nshapes,"shapes (there should be 3)")
