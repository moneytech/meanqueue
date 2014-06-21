GCOV_OUTPUT = *.gcda *.gcno *.gcov 
GCOV_CCFLAGS = -fprofile-arcs -ftest-coverage
CC     = gcc
CCFLAGS = -I. -Itests -g -O2 -Wall -Werror -W -fno-omit-frame-pointer -fno-common -fsigned-char $(GCOV_CCFLAGS)


all: test

main.c:
	sh tests/make-tests.sh tests/test_*.c > main.c

test: main.c meanqueue.o tests/test_meanqueue.c tests/CuTest.c main.c
	$(CC) $(CCFLAGS) -o $@ $^
	./test
	gcov main.c tests/test_meanqueue.c meanqueue.c

meanqueue.o: meanqueue.c
	$(CC) $(CCFLAGS) -c -o $@ $^

clean:
	rm -f main.c meanqueue.o test $(GCOV_OUTPUT)
