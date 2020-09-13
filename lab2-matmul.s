;
; CS1022 Introduction to Computing II 2018/2019
; Lab 2 - Matrix Multiplication
;

N	EQU	4		

	AREA	globals, DATA, READWRITE

; result array
ARR_R	SPACE	N*N*4		; N*N words (4 bytes each)


	AREA	RESET, CODE, READONLY
	ENTRY

	; initialize system stack pointer (SP)
	LDR	SP, =0x40010000

	;
	; write your matrix multiplication program here
	;
	
	LDR R8, =N
	LDR R1, =ARR_A
	LDR R2, =ARR_B

	LDR R3, =ARR_R
	LDR R4, =0 			; for (i = 0; i < N;) {
for_i	CMP R4, R8 			; 	
	BHS endF_i 			; 
	LDR R5, =0 			; 	
for_j 	CMP R5, R8 			; 	for(j = 0; j < N;) {
	BHS endF_j 			; 
	LDR R7, =0 			;		r = 0;
	LDR R6, =0 			; 		
for_k 	CMP R6, R8 			; 		for (k = 0; k < N;) {
	BHS endF_k 			; 
	MUL R0, R4, R8 			;			index = i*N;
	ADD R0, R0, R6 			; 			index += k;
	LDR R9, [R1, R0, LSL #2] 	; 			Avalue = A[ARR_A + index*4];
	MUL R0, R6, R8 			; 			index = k*N;
	ADD R0, R0, R5 			; 			index += j;
	LDR R10, [R2, R0, LSL #2] 	; 			Bvalue = B[ARR_B + index*4];
	MUL R9, R10, R9 		; 			Avalue = Avalue * Bvalue;
	ADD R7, R7, R9 			; 			r = r + (A[i,k] * B[k,j]);
	ADD R6, R6, #1 			; 		        k++;
	B for_k				;		}
endF_k 	MUL R0, R4, R8			; 			index = i*N;
	ADD R0, R0, R5 			; 			index += j;
	STR R7, [R3, R0, LSL #2] 	; 			R[i,j] = r;
	ADD R5, R5, #1 			; 			j++;
	B for_j				;	}
endF_j 	ADD R4, R4, #1 			; 			i++;
	B for_i				; }
endF_i


STOP	B	STOP


;
; test data
;

ARR_A	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

ARR_B	DCD	 1,  2,  3,  4
	DCD	 5,  6,  7,  8
	DCD	 9, 10, 11, 12
	DCD	13, 14, 15, 16

	END
