//Calculate Minimum Edit distance between user entered String s and custom word from local dictionary
//Levenshtein Distance Algorithm 

String[] s = new String[1];

//Replace with own custom words
String[] list = {"Rawalpindi", "Islamabad", "Lahore", "Karachi", "Multan", "Peshawar", "Quetta"};

int[] levOfCities = new int[7];

int counter;

int minLev;

static int lev;

void setup()
{

  s[0] = "";

  size(500, 350);
  background (0);
  print ("Word 1 is \n");
}

// prints instructions on canvas
void draw()
{

  textSize (25);
  textAlign (LEFT);
  text ("Enter Two Words!", 80, 80);
  textSize(16);
  textAlign (LEFT);
  text ("Press 'UP' to calculate levenshtein distance.", 150, 210);
  textAlign (LEFT);
  text ("Press 'DOWN' to reset word.", 150, 240);
  textSize(12);
  textAlign (LEFT);
  text ("Output will display on console.", 150, 330);
}

// Uses recursion to find minimum edits
public int recEditDistance(char[]  str1, char str2[], int len1, int len2)
{

  if (len1 == str1.length)
  {
    return str2.length - len2;
  }
  if (len2 == str2.length)
  {
    return str1.length - len1;
  }
  return min(recEditDistance(str1, str2, len1 + 1, len2 + 1) + str1[len1] == str2[len2] ? 0 : 1, recEditDistance(str1, str2, len1, len2 + 1) + 1, recEditDistance(str1, str2, len1 + 1, len2) + 1);
}

// Uses bottom up DP to find the edit distance
public static int dynamicEditDistance(char[] str1, char[] str2)
{
  int temp[][] = new int[str1.length+1][str2.length+1];

  for (int i=0; i < temp[0].length; i++)
  {
    temp[0][i] = i;
  }

  for (int i=0; i < temp.length; i++)
  {
    temp[i][0] = i;
  }

  for (int i=1; i <=str1.length; i++) {
    for (int j=1; j <= str2.length; j++)
    {
      if (str1[i-1] == str2[j-1])
      {
        temp[i][j] = temp[i-1][j-1];
      } else
      {
        temp[i][j] = 1 + min(temp[i-1][j-1], temp[i-1][j], temp[i][j-1]);
      }
    }
  }
  printActualEdits(temp, str1, str2);
  return temp[str1.length][str2.length];
}

// Prints the actual edits which needs to be done.
public static void printActualEdits (int T[][], char[] str1, char[] str2)
{
  int i = T.length - 1;
  int j = T[0].length - 1;

  while (true)
  {
    if (i == 0 || j == 0) 
    {
      break;
    }
    if (str1[i-1] == str2[j-1])
    {
      i = i-1;
      j = j-1;
    } 
    else if (T[i][j] == T[i-1][j-1] + 1)
    {
      println("Edited '" +  str2[j-1] + "' in Word 2, to '" + str1[i-1] + "' in Word 1.");
      i = i-1;
      j = j-1;
    } 
    else if (T[i][j] == T[i-1][j] + 1)
    {
      println("Deleted '" + str1[i-1] + "' in Word 1.");
      i = i-1;
    } 
    else if (T[i][j] == T[i][j-1] + 1)
    {
      println("Deleted '" + str2[j-1] + "' in Word 2.");
      j = j -1;
    } 
    else
    {
      throw new IllegalArgumentException("Some thing wrong with given data.");
    }
  }
}

//calculates levenshtein distance between two strings and returns value
public static void calculate_lev(String str1, String str2)
{

  int result = dynamicEditDistance (str1.toCharArray(), str2.toCharArray());
  print("The Levenshtein distance between '" + str1 + "' and '" + str2 + "' is " + result + ".");

  lev = result;
}

//calculates index of levOfCities array
int indexOf (int[] array, int min)
{
  int pos = -1;
  for (int i=0; i<array.length; i++)
  {
    if (array[i] == min)
    {
      pos = i;
    }
  }

  return pos;
}

void keyPressed()
{

  fill(0);

  // calculates levenshtein distance with 'UP' key once user is done entering word
  if (keyCode==UP)
  {
    for (int i=0; i<7; i++)
    {
      calculate_lev (s[0], list[i]);       
      levOfCities[i] = lev;
    }

    // stores city with minimum levenshtein distance in minLev
    minLev = min(levOfCities);
       
    String cityName = "none";

    // if minimum levenshtein distance between user input (word 1) and city in list of cities is less than or equal to 3, returns value of that city
    if (minLev <= 3)
    {
      int index = indexOf (levOfCities, minLev);
      
      if (index != -1)
      {
        cityName = list[index];
      }
    }
  
    background(0);
    fill(255);
    textAlign (LEFT);
    textSize(30);
    
    // print name of city with minimum levenshtein distance
    if (cityName == "none")
    { 
      text ("\n Could not recognize city.", 100, 80);
    }
    else
    {  
      text ("\n Did you mean " + cityName + "? \n", 100, 80);
    }
    
    
  }
  
  //resets user input (word 1) 
  else if (keyCode == DOWN)
  {
    print("\n");
    println ("Word 1 has been reset.");
    s[0] = "";
  } 
  
  //updates user input on console
  else
  {
    s[counter] += key;
    println("Word " + (counter+1) + " is " + s[counter]);
  }
}
