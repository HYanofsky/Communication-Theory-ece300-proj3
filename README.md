# Communication-Theory-ece300-proj3
Project 3 for ECE300 Commnications Theory

1. We need to be able to perform matrix and vector multiplications over F2, and preferably
don’t want to download any MATLAB toolboxes and learn what on Earth they do. Instead,
write a function which takes an M × N matrix and an N × K matrix assumed to contain
only the matlab integer values 0 and 1, and returns the product over F2 as an M × K matrix
containing only MATLAB integer values 0 and 1. Test this on a few matrices to show it works
as desired. Hint: Do not use a for loop to do this – You can actually start by just taking the
regular matrix product.
2. Similarly, write a function which performs matrix addition over F2. This should use a similar
method – no loops.
3. Write a binary symmetric channel function which takes a string of bits and a bit error probability p, and outputs a corrupted string of bits. No loops.
For the rest of the assignment, I am going to ask you to consider two systematic codes
with different values of n and k = 4. They are described by the following generator matrices:
G1 =


1 0 0 0 0 1 1 1
0 1 0 0 1 1 1 0
0 0 1 0 1 0 1 1
0 0 0 1 1 1 1 1


, G2 =


1 0 0 0 1 1 1 1 0 1 1 0
0 1 0 0 1 0 0 1 1 1 1 0
0 0 1 0 1 1 0 1 1 0 1 1
0 0 0 1 1 0 1 0 1 1 1 1


4. It will be a small hassle, but enter these matrices into MATLAB, and make a matrix containing
all 4-bit data words as rows. You can use functions to do this but it will probably be quicker to
1
do it by hand. Come up with the two codebooks, each of which will have 16 rows (“elements”),
either 8 or 12 bits long. Using the relationship between minimum Hamming weight and
distance, what is the maximum number of errors that can be corrected with either code?
5. Using MATLAB, create the parity check matrices for either code. Ensure that GH = 0 in
either case.
6. For these two codes, we know the maximum number of errors we can correct for. Thus, we
know all possible error sequences we can correct for as well. In class, we learned to make
a massive array detailing every possible error – here, we will constrain ourselves to the case
in which the error is correctable. For each code, create an array which contains all of the
correctable error words (for example, if n = 15 and we can correct for 3 errors, every possible
binary sequence with 12 0s and 3 1s should appear in the array). Create the truncated
syndrome array corresponding to the correctable errors. How much smaller is this than the
real syndrome array?
7. Write a function that takes the error word set, the truncated syndrome array and a received
word as inputs. The function should return the corrected word in the case that the error
is correctable, or return a string of NaNs if the error is not correctable (easily determined
through the syndrome). Test your error correction scheme before moving to the next step.
8. Randomly generate 105 words, and encode them using both schemes. Simulate the transmission of the uncoded bits and the two sets of coded words through binary symmetric channels
with error probabilities ranging from 0.001 to 0.1. Find the bit error rate of the uncoded
signal and the bit error rates of the two codes, with the interpretation that an “uncorrectable
error” should count as a full word of errors. Plot these against p
