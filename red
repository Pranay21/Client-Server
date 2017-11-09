
//Define Correlate() Function

_Bool Correlate (int size, float arrayOne[], float arrayTwo[], float * spearmanCoefficient, float * correlationFlag)
{
    
    // Function Input:
    // The function input is comprised of the the first three parameters in the Correlate()argument list :
    //    1. size  equals the number of elements in the input array (arrayOne and arrayTwo).
    //    2. arrayOne[]  and arrayTwo[] are arrays of real numbers of type float. The numbers may be positive or negative.
    //       There is no limit on the size of the numbers.  The values may be as large or as small as is allowed by
    //       the float type on the particular computer that executes the function.
    //       The input data will be stored in range 0 to size-1.
    
    // Function Output:
    
    
    // The function will produce two outputs consisting of the latter two parameters in the Correlate() argument list
    // plus the Correlate() _Bool return parameter:
    //    1. spearmanCoefficient (type float) contains the result of the formulation. 
    //       It is a real number ranging from -1 to +1.  
    //    2. correlationFlag (type float) which is the flag to indicate whether the arrays are positively correlated (+1),
    //       negatively correlated (-1), or not related at all (0). Thus it can have any one of the three values:-1,0,+1.
	//		 The three cases precisely are as follows:
	//		 Flag will be +1 when the Pearson coefficient is in the range from 0.9 to 1.0
	//		 Flag will be -1 when the Pearson coefficient is in the range from -0.9 to -1.0
	//		 Flag will be 0 otherwise.
	
    //    3. Correlate()(type _Bool) returns 1 if size > 0 and returns 0 if size <= 0.


    //   HINT:  for the Spearman Coefficient use the formula given on Module 15 Slide 28 and also see later slides for how the Spearman coefficient is calculated (you must sort the data and such). Also see the requirements in Appendix A of the SOW

 //1
    float temp;
    int i,j;
    float ArrayOneDash[size];
    float ArrayTwoDash[size];
    //2a2b2c
    for(i=0;i<size;i++)
    {
        ArrayOneDash[i]=ArrayOne[i]; //2d
        ArrayTwoDash[i]=ArrayTwo[i]; //2d
    }
  
  //Sorting the Arrays  
    for(i=0;i<size-1;i++) //3a3b3c
    {
        for(j=0;j<size-i-1;j++) //4a4b4c
        {
            if(ArrayOneDash[j]>ArrayOneDash[j+1]) //4d
            {
                temp = ArrayOneDash[j];           //5
                ArrayOneDash[j]=ArrayOneDash[j+1];//5
                ArrayOneDash[j+1]=temp;             //5
            }
            if(ArrayTwoDash[j]>ArrayTwoDash[j+1]) //6
            {
                temp = ArrayTwoDash[j];             //7
                ArrayTwoDash[j]=ArrayTwoDash[j+1];  //7
                ArrayTwoDash[j+1]=temp;             //7
            }//8
        }//9
    }
  //Assigning Ranks  //10
    float ArrayRank1[size];
    float ArrayRank2[size];
    float count = 0;
    //11a11b11c
    for(int i=0;i<size;i++)
    {
        ArrayRank1[i]= count+1; //11d
        ArrayRank2[i]= count+1; //11d
        count++;                //11d
    }
 
    float ArrayTripleX[size]; //12
    float ArrayTripleY[size]; //12
 
 //For Array One 
    float initrank=0;         //12
    count=1;                //12    
  
  for(i=0;i<size;i++)  //13a13b13c
  {
      for(j=i+1;j<size;j++)  //14a14b14c
      {
          if(ArrayOneDash[i]==ArrayOneDash[j]) //14d
          {
              count++;   //15
              initrank=i; //15
              
          } //16
          
  } //17
       float avg=0; //18
       //19a19b19c
       for(int k=initrank;k<initrank+count;k++){
           avg+=ArrayRank1[k]; //19d
       }
       avg/=(count); ///20
       //21a21b21c
       for(int k=initrank;k<initrank+count;k++){
          ArrayRank1[k]=avg; //21d
       }
       if(count>1) //22
            i=i+count-1; //23
       count=1; //24
       initrank=0; //24

  }
    //25a25b25c
  for(i=0;i<size;i++)
  {
      for(j=0;j<size;j++) //26a26b26c
      {
          if(ArrayOne[i]==ArrayOneDash[j]) //26d
          {
              ArrayTripleX[i]=ArrayRank1[j]; //27
          }//28
      }//29
  }
  //For Array Two
  count = 1; //30
  initrank=0; //30
  //31a31b31c
  for(i=0;i<size;i++)
  {
      for(j=i+1;j<size;j++) //32abc
      {
          if(ArrayTwoDash[i]==ArrayTwoDash[j]) //32d
          {
              count++;  //33
              initrank=i;
              
          } //34
          
  }
        float avg=0; //35
       for(int k=initrank;k<initrank+count;k++){ //36abc
           avg+=ArrayRank2[k]; //36d
       }
       avg/=(count); //37
       for(int k=initrank;k<initrank+count;k++){ //38abc
          ArrayRank2[k]=avg; //38d
       }
       if(count>1) //39
            i=i+count-1; //40
       count=1; //41
       initrank=0; //41

  }
  //42abc
  for(i=0;i<size;i++)
  {
      for(j=0;j<size;j++) //43abc
      {
          if(ArrayTwo[i]==ArrayTwoDash[j]) //43d
          {
              ArrayTripleY[i]=ArrayRank2[j]; //44
          } //45
      }//46
  }
    
    float ArrayoneAverage=0; //47
    float ArraytwoAverage=0; //47
    
    for(i=0;i<size;i++){ //48abc
     ArrayoneAverage+=ArrayTripleX[i];  //48d
     ArraytwoAverage+=ArrayTripleY[i];  //48d
    } 
    ArrayoneAverage/=size; //49
    ArraytwoAverage/=size; //49
    
   //50
    float varX = 0.0;  
    float varfX = 0.0;
    float vary = 0.0;
    float varfy = 0.0;
    for(i=0;i<size;i++){  //51abc
        varX+=((ArrayTripleX[i] - ArrayoneAverage)*(ArrayTripleX[i] - ArrayoneAverage)); //51d
        
        vary+=((ArrayTripleY[i] - ArraytwoAverage)*(ArrayTripleY[i] - ArraytwoAverage));
        
    }
    //52
    varfX=varX/size;
    varfy=vary/size;
    float num = 0.0;
    float dn = 0.0;
    dn = size*sqrt(varfX*varfy); //53
    for(i=0;i<size;i++){ //54abc
     num += (ArrayTripleX[i]-ArrayoneAverage)*(ArrayTripleY[i]-ArraytwoAverage); //54d
     
    } 
    *spearmanCoefficient = num/dn; //55
    
    if (*spearmanCoefficient >= 0.9 && *spearmanCoefficient <= 1.0) //56
		*correlationFlag = 1; //57
	else if (*spearmanCoefficient <= -0.9 && *spearmanCoefficient >= -1.0) //58
		*correlationFlag = -1; //59
	else
		*correlationFlag = 0; //60
	if (size > 1) //61
		return true; //62
	else
		return false; //63
    
    

 
}
