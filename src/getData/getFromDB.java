package getData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;





public class getFromDB {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    JSONArray t;
    
    
    public JSONObject getData(final HttpServletRequest req) throws JSONException {
  	  	JSONObject jsonObj = new JSONObject();
        int page = 10; //Integer.valueOf(req.getParameter("page")).intValue();
    	int pageSize =10; // Integer.valueOf(req.getParameter("rows")).intValue();
    	int startIndex = page == 1 ? 0 : (pageSize * (page - 1));
    	int endIndex = page == 1 ? pageSize : pageSize * page;
    	int total = -1;
		String tableName=req.getParameter("table");
		String where=req.getParameter("where"); 
		if (where == null){where=" ";};
		System.out.println("Table Name :"+tableName);
		System.out.println("WhereCondition :"+where);
		System.out.println("Query :"+"select * from "+tableName+" "+where);
		
		if (tableName =="dummy") {};
    	
    	try {
            // registers Oracle JDBC driver - though this is no longer required
            // since JDBC 4.0, but added here for backward compatibility
            Class.forName("oracle.jdbc.OracleDriver");
 
            // METHOD #1
            String username="system";
            String password="oracle";
            String dbURL="jdbc:oracle:thin:@(DESCRIPTION =(ADDRESS_LIST =(ADDRESS =(PROTOCOL=TCP)(HOST=localhost)(PORT=49161)))(CONNECT_DATA=(SID=xe)(SERVER=DEDICATED)))";


            Connection conn = DriverManager.getConnection(dbURL,username,password);
            
            ps=conn.prepareStatement("select * from "+tableName+" "+where);
      	  	JSONArray jsonArray = new JSONArray();
            ResultSetAdapter test= new ResultSetAdapter(ps.executeQuery());
            Iterator<Map<String, Object>> t1 = test.iterator();
            while(t1.hasNext()) {
            	jsonArray.put(t1.next());
            }

      	total = jsonArray.length();
      	String Pageheader="page\":1"+",\"total\":\""+String.valueOf(Math.ceil((double) total / pageSize))+"\",\"records\":\""+String.valueOf(total)+"\",\"rows";
      	jsonObj.put(Pageheader, jsonArray);
        return jsonObj;
      	

      	  	
      	  
    	} catch (ClassNotFoundException ex) {ex.printStackTrace();
        } catch (SQLException ex) {ex.printStackTrace();
        } finally {}
		return null;
    	
    }
    
  
    

}
