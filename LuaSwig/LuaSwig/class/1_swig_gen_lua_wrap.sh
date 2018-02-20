
chmod +x swig
swig -Ilib -Ilib/lua -c++ -lua -o wrap_example.cpp example.i
