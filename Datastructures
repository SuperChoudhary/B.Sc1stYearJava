/* Java code based on Commandline Arguments to calculate shortest path between airports based on UK country map and A* algorithm
 */

import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeMap;

public class Ass226150303639 {
	
	double [][] adj;
	static int N= 5000;
	static double [][] edges = new double[N][N];
	static TreeMap <Integer,String> airportNames = new TreeMap <Integer,String>();
		
	static ArrayList<String> convert (ArrayList<Integer> m)
	{
		ArrayList<String> z= new ArrayList<String>(); for (Integer i:m)
		z.add(airportNames.get(i));
	    return z;
	}
	
	static HashSet<ArrayList<String>> convert (HashSet<ArrayList<Integer>> paths)
	{
		HashSet <ArrayList <String>> k= new HashSet
		<ArrayList<String>>();
		for (ArrayList <Integer> p : paths)
		k.add(convert(p));
		return k;
	}
	
	Ass226150303639 (double [][] a)
	
	{
		adj = new double [a.length][a.length];
		for (int i=0;i < a.length;i++)
		for (int j=0 ; j<a.length ; j++) 
			adj[i][j] = a[i][j];
	}
		
	public HashSet <Integer> neighbours(int v)
	{
		HashSet <Integer> h = new HashSet <Integer> () ;
		for (int i=0 ; i<adj.length ; i++) 
			if (adj[v][i]!=0) h.add(i); 
		return h;
	}
	
	public HashSet <Integer> vertices()
	{
		HashSet <Integer> h = new HashSet <Integer>(); 
		for (int i=0 ; i<adj.length ; i++)
			h.add(i);
		return h;
	}
	
	ArrayList <Integer> addToEnd (int i, ArrayList <Integer> path) //returns a new path with i at the end of path
	{
		ArrayList <Integer> k; 
		k = (ArrayList<Integer>)path.clone(); 
		k.add(i);
		return k;
	}
	
	public HashSet <ArrayList <Integer>> shortestPaths1(HashSet <ArrayList<Integer>> sofar, HashSet <Integer> visited, int end)
	{
		HashSet <ArrayList <Integer>> more = new HashSet <ArrayList<Integer>>();
		HashSet <ArrayList <Integer>> result = new HashSet <ArrayList<Integer>>();
		HashSet <Integer> newVisited = (HashSet <Integer>) visited.clone();
		
		boolean done = false;
		boolean carryon = false;
		
		for (ArrayList <Integer> p: sofar)
		{
			for (Integer z: neighbours(p.get(p.size()-1)))
			{
				if (!visited.contains(z))
				{
					carryon=true; newVisited.add(z);
					if (z==end) {done=true; result.add(addToEnd(z,p));
				} 
				else
				more.add(addToEnd(z,p));
				}
			}
		}
		
		if (done) 
			return result; 
		else if (carryon) 
			return shortestPaths1(more,newVisited,end); 
		else 
			return new
				
		HashSet <ArrayList <Integer>>();
	}
	
	public HashSet <ArrayList <Integer>> shortestPaths (int first, int end)
	{
		HashSet <ArrayList <Integer>> sofar = new HashSet <ArrayList<Integer>>();
		HashSet <Integer> visited = new HashSet <Integer>(); 
		ArrayList <Integer> starting = new ArrayList<Integer>();
		starting.add(first);
		sofar.add(starting);
		if (first == end)
		return sofar; 
		visited.add(first);
		return shortestPaths1(sofar, visited, end);
	}
	
	int findSmallest(HashMap <Integer,Double> t)
	{
		Object [] things= t.keySet().toArray();
		double val = t.get(things[0]);
		
		//changed from int least = (int) things[0]
		int least = Integer.parseInt(things[0].toString()); 
		Set <Integer> k = t.keySet(); 
		for (Integer i : k)
		{
			if (t.get(i) < val)
			{
				 least=i;
				 val=t.get(i);}
			}
		return least;
	}


	public ArrayList <Integer> dijkstra (int start, int end)
	{
		//number of vertices
            
		int N = end*2;
		HashMap <Integer, Double> Q = new HashMap <Integer, Double>();
		ArrayList <Integer> [] paths = new ArrayList [N+1]; 
		
		for (int i=0 ; i<=N ; i++)
		{
			Q.put(i, Double.POSITIVE_INFINITY);
			paths[i] = new ArrayList <Integer>(); 
			paths[i].add(start);
		}
			
		HashSet <Integer> S = new HashSet();
      
		S.add(start);
			
                Q.put (start,0.0);
		
        
		while (!Q.isEmpty())
		{
			int v = findSmallest(Q);
			if (v == end && Q.get(v) != Double.POSITIVE_INFINITY)
				return paths[end];
			
			double w = Q.get(v);
			S.add(v);
//			for (int i=0 ; i<Q.size() ; i++)
//			System.out.println(Q.get(i));
			
			for(int u: neighbours(v)) 
				if (!S.contains(u))
                {
                if (u != v)
                    {
                            double w1 = adj[u][v] + w;
                            if (w1 < Q.get(u))
                            {
                                    Q.put(u, w1);
                                    paths[u]= addToEnd(u, paths[v]);
                            }	
                    }
                            
                }
			
			Q.remove(v);
		}
		
		return paths[start];
	}
	
	static double realDistance(double lat1, double lon1, double lat2, double lon2)
	{
		int R = 6371; // km (change this constant to get miles)
		double dLat = (lat2-lat1) * Math.PI / 180;
		double dLon = (lon2-lon1) * Math.PI / 180; double a =
		Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(lat1 * Math.PI / 180 ) * Math.cos(lat2 * Math.PI / 180 ) * Math.sin(dLon/2) * Math.sin(dLon/2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
		double d = R * c;
		return d;
	}
	
	public static void main(String [] args) throws Exception
	{
		//starting time
		long startTime = System.nanoTime();
		
		//test Djik
		int N=5000;
		double edges[][] = new double [N][N];
		

		//System.out.println("Test);
		//System.out.println("Test");
		
		for (int i = 0; i < N; i++) 
		{
			for (int j = 0; j < N; j++) 
			{
				edges[i][j] = 0.0;	
			}
		}
				
		Scanner s1 = new Scanner(new FileReader(args[2] + ".csv"));
		String z = s1.nextLine();
		while (s1.hasNext())
		{
			z = s1.nextLine();
			String[] results = z.split(",");
			edges[Integer.parseInt(results[0])][Integer.parseInt(results[1])] = Double.parseDouble(results[2]);
		}
		
		Scanner s2 = new Scanner(new FileReader(args[0] + ".csv"));
		z = s2.nextLine();
		while (s2.hasNext()) {
			z = s2.nextLine();
			String[] results = z.split(",");
			airportNames.put(Integer.parseInt(results[0]), results[1]);
		}
		Ass226150303639 G = new Ass226150303639(edges);
		
		//int st = Integer.parseInt("1"); //arg[0]
		//int fin = Integer.parseInt("101"); //arg[1]
		//System.out.println("Shortest path from" + airportNames.get(st) + "to " + airportNames.get(fin) + " is" + convert(G.shortestPaths(st, fin)));
		
		//Question 1
		System.out.print("\n" + "Question 1: ");
		//Total number of shortest paths
		System.out.println(G.shortestPaths(2862, 400).size());
		
		//Question 2
		System.out.print("Question 2: ");
		
		String z2 = "";
		int first = 0;
		int second = 0;
		int maxPaths = 0;
		int q4Count = 0;
		
		String[] split;
		
		HashSet<ArrayList<Integer>> question4 = new HashSet<ArrayList<Integer>>();
		ArrayList<Integer> codes = new ArrayList<Integer>();
		ArrayList<Integer> results = new ArrayList<Integer>();
		
		Scanner q2 = new Scanner (new FileReader (args[0] + ".csv"));
		
		while (q2.hasNext())
		{
			z2 = q2.nextLine();
			split = z2.split(",");
			
			codes.add(Integer.parseInt(split[0]));
			airportNames.put(Integer.parseInt(split[0]), split[1]);		
		}
		for (int i=0 ; i<codes.size() ; i++)
		{
			for (int j=0 ; j<i ; j++)
			{
				first = i;
				second = j;
				
				if (G.shortestPaths(codes.get(i), codes.get(j)).size() > maxPaths)
				{
					question4 = G.shortestPaths(codes.get(i), codes.get(j));
					
					maxPaths = question4.size();
					first = i;
					second = j;
				}
				
				//System.out.println(G.shortestPaths(codes.get(i), codes.get(j)).size());
			}
			
		}
		
		System.out.println(codes.get(first)+" "+codes.get(second));
		
		//question 3
		System.out.print("Question 3: ");
		System.out.println(maxPaths);
		
		//question 4
		System.out.print("Question 4: ");
		
		Object[] q4=question4.toArray();
		
		for (int i=0 ; i<q4.length; i++)
		{
			q4Count = ((ArrayList<Integer>) q4[i]).size();
		}
		System.out.println(q4Count);
		
		
		System.out.print("Question 5: ");
		System.out.print("[");
		int paths = 0;
		
		for (int i=0 ; i<codes.size() ; i++)
		{
			paths = G.shortestPaths(2435, codes.get(i)).size();
			if (paths != 0 && codes.get(i) != 2435)
			{
				System.out.print(codes.get(i) + ", ");
				//uncomment to find out codes AND shortest paths
				//System.out.print("[Code: " + codes.get(i) + ", Shortest Paths: " + G.shortestPaths(2435, codes.get(i)).size() + "] ");
			}
			
		}
		System.out.println("]");
		System.out.print("Question 6: ");
		try
		{
			System.out.println(G.dijkstra(2638, 997));
		}
		catch (Exception e)
		{
			//System.out.println("NOT DONE.");
		}
		
		//
		
		System.out.print("Question 7: ");

		String z7 = "";
		String[] question7 = null;
		double[][] newCoords = new double[N][N];
		
		ArrayList<Double> lon = new ArrayList<Double>();
		ArrayList<Double> lat = new ArrayList<Double>();
		ArrayList<Integer> airportCodes = new ArrayList<Integer>();
		
		HashMap<Integer,Double[]> newCoordsMap = new HashMap<Integer,Double[]>();
		
		Scanner q7 = new Scanner (new FileReader (args[1] + ".csv"));
		
		while (q7.hasNext())
		{
			z7 = q7.nextLine();
			question7 = z7.split(",");
			
			lon.add(Double.parseDouble(question7[1]));
			lat.add(Double.parseDouble(question7[2]));
			airportCodes.add(Integer.parseInt(question7[0]));
		}
		
		for (int i=0 ; i<lat.size() ; i++)
		{
			for (int j=0 ; j<lat.size() ; j++)
			{
				if(i!=j)
					newCoords[airportCodes.get(i)][airportCodes.get(j)] = realDistance(lat.get(i), lon.get(i), lat.get(j), lon.get(j));
			}
		}

		Ass226150303639 G2 = new Ass226150303639 (newCoords);
		
		try
		{
			System.out.println(G2.dijkstra(2281, 1110));
		}
		catch (Exception e)
		{
			System.out.println("NOT DONE.");
		}
		
	
		long endTime = System.nanoTime();
		System.out.println("\n" + (endTime - startTime)/1000000 + " Milliseconds");
	}
}
