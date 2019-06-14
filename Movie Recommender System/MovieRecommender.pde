//Recommender System using MovieLens small dataset 

String userInput;
int counter;
//tags.csv
ArrayList<Integer> userList = new ArrayList<Integer>();
ArrayList<Integer> movieList = new ArrayList<Integer>();
ArrayList<String> tagList = new ArrayList<String>();
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
  ArrayList<Integer> newTags = new ArrayList<Integer>();
  ArrayList<String> results = new ArrayList<String>();
  
  for (int i=0; i<tagList.size(); i++)
  {
    if(tagList.get(i).toString().toLowerCase().contains(userInput.toLowerCase()))
    {
      newTags.add(movieList.get(i));
    }
  }
  
  for (int i=0 ; i<movieNames.size() ; i++)
  {
    for (int k=0 ; k<newTags.size() ; k++)
    {
       if (newTags.get(k).equals(movieIDList.get(i)))
       {
         results.add(movieNames.get(i));
       }
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
 
    //Loading Animation not needed
    //fill(230);
    //stroke(230);
    //strokeWeight(18);
    //line(100, 250, 100+counter/10, 250);
  
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
  println("Tag: " + userInput);
}
