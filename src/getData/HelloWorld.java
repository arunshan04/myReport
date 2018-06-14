package getData;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.JSONArray;

import com.google.gson.JsonParser;

public class HelloWorld {
	public static void main(String[] args) throws JSONException {
	      // Prints "Hello, World" in the terminal window.
			String table = "test123";
			org.json.JSONArray test=new  getoracledata().getData("sys.dummy", "");
			System.out.println("Output: "+test);
	   }
	}