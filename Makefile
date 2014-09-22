object: main.o f1.o f2.o g.o
	g++ -o main.exe $^

static: main.o libf.a libg.a
	g++ -o main.exe $^

static_rev: main.o libf.a libg.a
	g++ -o main.exe main.o libg.a libf.a

static_twice: main.o libf.a libg.a
	g++ -o main.exe main.o libf.a libg.a libf.a

shared: main.o libf.so libg.so
	g++ -o main.exe $^

libf.a: f1.o f2.o
	ar rc $@ $^

libg.a: g.o
	ar rc $@ $^

libf.so: f1.o f2.o
	ld -shared -o $@ $^

libg.so: g.o
	ld -shared -o $@ $^

%.o: %.cpp
	g++ -fPIC -o $@ -c $^

.PHONY: object static shared clean check-syntax

clean:
	-rm ./*.o
	-rm ./lib*.a
	-rm ./lib*.so
	-rm ./main.exe

check-syntax:
	$(COMPILE.cc) -fsyntax-only $(CHK_SOURCES)
