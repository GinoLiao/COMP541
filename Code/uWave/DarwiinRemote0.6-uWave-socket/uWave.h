/*
 *  uWave.h
 *  DarwiinRemote
 *
 *  Created by Guest on 6/23/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */
 
 /*
 1. connect Wiimote:
 run DarwiinRemote.exe; press '1' and '2' button on Wiimote at the same time, and select "find Wiimote" on the program interface; 
 if it fails, do the previous step again.
 2. record templates
 when connection established, press '1' button to record templates. Hold 'A' button in course of a gesture. The templates will be indexed 
 according to the input order, like '0.uwv', '1.uwv'...
 3. recognition
 press '2' button to enable recognition. Hold 'A' button in course of a gesture. The recognition result is the index of the recognized 
 template and will be sent to the TCP socket on port "50101"
 */
 
#ifndef UWAVE_H
#define UWAVE_H

#define NUM_TEMPLATES 9   // >>>>>>>>> max number of gesture templates, change according to application
extern int recordFlag;// >>>>>>>>> record gesture to file as template (1) or recognize the input gesture (0), change according to application 
//socket related, need to change
#define SOCKPORT 50101


#define DIMENSION 3
#define MAX_ACC_LEN 500
#define QUAN_WIN_SIZE 5
#define QUAN_MOV_STEP 3

struct GestureStruct {
	int** data;
	int length;
};
typedef struct GestureStruct Gesture;

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

