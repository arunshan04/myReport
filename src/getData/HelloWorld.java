package getData;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.gson.JsonParser;

public class HelloWorld {
	public static void main(String[] args) throws JSONException {
	      // Prints "Hello, World" in the terminal window.
			String table = "test123";
		   JSONObject jsonObj = new getoracledata().getData("test123", "");
			String ss= jsonObj.toString();
			ss=ss.replace("\\", "");
			com.google.gson.JsonObject obj = new JsonParser().parse(ss).getAsJsonObject();
			System.out.println(obj);
	   }
	}