//Recommender System using MovieLens Dataset 

String userInput;
int counter;
//tags.csv
ArrayList<Integer> userList = new ArrayList<Integer>();
ArrayList<Integer> movieList = new ArrayList<Integer>();
ArrayList<String> tagList = new ArrayList<String>();
ArrayList<String> timeStampList = new ArrayList<String>();
//movies.csv
ArrayList<Integer> movieIDList = new ArrayList<Integer>();
ArrayList<String> movieNames = new ArrayList<String>();
ArrayList<String> movieGenre =  new ArrayList<String>();

void setup() 
{
  userInput = "";
  counter = 0;
  
  size(100, 100);
  tagReader();
  movieReader();
  println("Enter a search word to get started.");
  println();
}

//reads tags and stores in arrayList
void tagReader() 
{
  
  BufferedReader tagReader = createReader("tags.csv");
  String tagLine = null;
  
  try 
  {
    while ((tagLine = tagReader.readLine()) != null) 
    {
      String[] tagLines = split(tagLine, ",");
      userList.add(int(tagLines[0]));
      movieList.add(int(tagLines[1]));
      tagList.add(tagLines[2]);
      timeStampList.add(tagLines[3]);
  
    }
    tagReader.close();
  } 
  catch (IOException e) 
  {
    e.printStackTrace();
  }
  
}

//reads movie names and stores in arrayList
void movieReader()
{
  BufferedReader movieReader = createReader("movies.csv");
  String movieLine = null;
  
   try 
  {
    while ((movieLine = movieReader.readLine()) != null) 
    {
      String[] ratingLines = split(movieLine, ",");
      movieIDList.add(int(ratingLines[0]));
      movieNames.add(ratingLines[1]);
      movieGenre.add(ratingLines[2]);
  
    }
     movieReader.close();
  } 
  catch (IOException e) 
  {
    e.printStackTrace();
  }
  
  
}

void getShow(String userInput)
{
  ArrayList<String> results = new ArrayList<String>();
  
  //Use tags[2] with userInput and get tags[1] then find movies[1] 
  //by comparing tags[2] with movies[0]
  
  for (int i=0; i<tagList.size(); i++)
  {
    if(tagList.get(i).toString().toLowerCase().contains(userInput.toLowerCase()))
    {
      results.add(movieNames.get(i).toString());
    }
  }
  
  for (int i=0 ; i<results.size(); i++)
  {
    println(results.get(i).toString());
    println();
  }
   
    
}


void draw()
{
}

void keyPressed()
{
  if (keyCode == DOWN)
  {
    println();
    getShow(userInput);
    println("Showing recommendations for '" + userInput + "'.");
  }
  
  userInput += key;
  println("Searching category: " + userInput);
}
