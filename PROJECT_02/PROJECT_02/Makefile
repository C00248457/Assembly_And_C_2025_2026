# --------------------------------------------------------
# Makefile - x86_64 Assembly Port Project
# --------------------------------------------------------

EXECUTABLE = adder_program
TEST       = test_runner

all: $(EXECUTABLE)

adder.o: adder.asm
	nasm -f elf64 adder.asm -o adder.o

main.o: main.c
	gcc -c main.c -o main.o

$(EXECUTABLE): adder.o main.o
	gcc -no-pie adder.o main.o -o $(EXECUTABLE)
	@echo "Build successful - run with: ./$(EXECUTABLE)"

test: adder.o test_runner.c
	gcc -no-pie test_runner.c adder.o -o $(TEST)
	./$(TEST)

run: $(EXECUTABLE)
	./$(EXECUTABLE)

clean:
	rm -rf *.o *.lst $(EXECUTABLE) $(TEST)
