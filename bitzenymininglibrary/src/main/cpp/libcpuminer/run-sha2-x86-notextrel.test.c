gcc -o original sha2-x86-notextrel-test.c sha2-x86.S
gcc -o notextrel sha2-x86-notextrel-test.c sha2-x86-notextrel.S

./original > original.log
./notextrel > notextrel.log
diff original.log notextrel.log
