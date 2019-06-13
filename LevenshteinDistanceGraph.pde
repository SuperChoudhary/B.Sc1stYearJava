//Calculate Levenshtein Distance in plotted graphical form

//list of main cities in pakistan (4 provincial capitals + 1 federal capital)
String[] list = {"Islamabad", "Peshawar", "Lahore", "Quetta", "Karachi"};
//input string from user
String s;
//array to store lev of input string with each of main city
int[] levOfCities = new int[5];
int minLev;
int counter;
String cityName = "none";
static int lev;


void setup()
{
  s = "";
  size(600, 500);
  background (255);
  fill(0);
}

void draw()
{
  textSize (20);
  text ("Islamabad", 250, 250);
  text ("Peshawar", 30, 30);
  text ("Lahore", 500, 30);
  text ("Quetta", 30, 450);
  text ("Karachi", 500, 450);  
}

void keyPressed()
{
  if (keyCode==UP)//calculate lev
  {
    
    //leving
    for (int i=0; i<5; i++)
    {
      calculate_lev (s, list[i]);       
      levOfCities[i] = lev;
    }
    //get min lev
    minLev = min(levOfCities);
    //deduce city
    if (minLev <= 6)
    {
      int index = indexOf (levOfCities, minLev);
      
      if (index != -1)
      {
        cityName = list[index];
      }
    }
    //output and draw circle
    if (cityName == "none")
    { 
      print ("\n Could not recognize city.");
    }
    else
    {  
      print ("\n Did you mean " + cityName + "? \n");
      int[] coords = new int[2];
      coords = get_coords(cityName);
      draw_circle(coords[0],coords[1],minLev);
    }
    //reset the word
    print("\n");
    println ("Word has been reset.");
    s = "";
  }
  else
  {
    s += key;
    println("Word is " + s);
  }
}

//returns fill with different fill values on eery input
void random_color()
{
  //3 different random float values for fill
  float r1 = random(255);
  float r2 = random(255);
  float r3 = random(255);
  
  fill(r1, r2, r3, 300/minLev);
}

void draw_circle(int x, int y, int sw)
{
  stroke(255, 20, 0, 300/minLev);
  strokeWeight(sw);
  noFill();
  println ("Drawing circle.");
  
  random_color();
  ellipse (x, y, minLev* 60, minLev* 60);
  smooth();
  fill(0);
  
}

int[] get_coords(String cityName)
{
  int[] coords = new int[2];
  // {"Islamabad", "Peshawar", "Lahore", "Quetta", "Karachi"};
  switch (cityName) 
  {
    case "Islamabad": 
      coords[0]=300;
      coords[1]=250;
      break;
    case "Peshawar": 
      coords[0]=0;
      coords[1]=0;
      break;
    case "Lahore": 
      coords[0]=600;
      coords[1]=0;
      break;
    case "Quetta": 
      coords[0]=0;
      coords[1]=500;
      break;
    case "Karachi": 
      coords[0]=600;
      coords[1]=500;
      break;
    default:            
      coords[0]=-999;
      coords[1]=-999;
      break;
  }
  return coords;
}

/*
LEV FUNCTIONS
*/

//calculating lev
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

/**
 * Uses recursion to find minimum edits
 */
public int recEditDistance (char[]  str1, char str2[], int len1, int len2)
{

  if (len1 == str1.length)
  {
    return str2.length - len2;
  }
  if (len2 == str2.length)
  {
    return str1.length - len1;
  }
  return min (recEditDistance(str1, str2, len1 + 1, len2 + 1) + str1[len1] == str2[len2] ? 0 : 1, recEditDistance(str1, str2, len1, len2 + 1) + 1, recEditDistance(str1, str2, len1 + 1, len2) + 1);
}

/**
 * Uses bottom up DP to find the edit distance
 */
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

/**
 * Prints the actual edits which needs to be done.
 */
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
    } else if (T[i][j] == T[i-1][j-1] + 1)
    {
      println("Edited '" +  str2[j-1] + "' in Word 2, to '" + str1[i-1] + "' in Word 1.");
      i = i-1;
      j = j-1;
    } else if (T[i][j] == T[i-1][j] + 1)
    {
      println("Deleted '" + str1[i-1] + "' in Word 1.");
      i = i-1;
    } else if (T[i][j] == T[i][j-1] + 1)
    {
      println("Deleted '" + str2[j-1] + "' in Word 2.");
      j = j -1;
    } else
    {
      throw new IllegalArgumentException("Some thing wrong with given data.");
    }
  }
}
