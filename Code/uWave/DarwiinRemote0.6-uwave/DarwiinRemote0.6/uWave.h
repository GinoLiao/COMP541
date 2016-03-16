/*
 *  uWave.h
 *  DarwiinRemote
 *
 *  Created by Guest on 6/23/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef UWAVE_H
#define UWAVE_H

#define NUM_TEMPLATES 4   // >>>>>>>>> number of gesture templates, change according to application
#define recordFlag 0 // >>>>>>>>> record gesture to file (1) or recognize the input gesture (0), change according to application 


#define DIMENSION 3
#define MAX_ACC_LEN 500
#define QUAN_WIN_SIZE 5
#define QUAN_MOV_STEP 3

struct GestureStruct {
	int** data;
	int length;
};
typedef struct GestureStruct Gesture;
// accBuffer[index][dimension]
int** accBuffer;  
extern int tempIndex;
int accIndex;

int** allocAccBuf(int len);
void releaseAccBuf(int** p, int len);
void beginGesture();
int endGesture();

int quantizeAcc(int** acc_data, int length);
int DTWdistance(int** sample1, int length1, int** sample2, int length2, int i, int j, int* table);
int DetectGesture(int** input, int length, Gesture* templates, int templateNum);
Gesture readFile(int index);
int writeFile(int** data, int len, int index);


#endif

