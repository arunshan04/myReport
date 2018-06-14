package getData;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;





public class getoracledata2 {
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    JSONArray t;
    
    
    public JSONObject getData(String table,String where1) throws JSONException {
  	  	JSONObject jsonObj = new JSONObject();
        int page = 10; //Integer.valueOf(req.getParameter("page")).intValue();
    	int pageSize =10; // Integer.valueOf(req.getParameter("rows")).intValue();
    	int startIndex = page == 1 ? 0 : (pageSize * (page - 1));
    	int endIndex = page == 1 ? pageSize : pageSize * page;
    	int total = -1;
		String tableName=table;
		String where=where1; 
		if (where == null){where=" ";};
		System.out.println(tableName+where);
		
		if (tableName =="dummy") {};
    	
    	try {
            // registers Oracle JDBC driver - though this is no longer required
            // since JDBC 4.0, but added here for backward compatibility
            Class.forName("oracle.jdbc.OracleDriver");
 
            // METHOD #1
            String dbURL="jdbc:oracle:thin:@(DESCRIPTION =(ADDRESS_LIST =(ADDRESS =(PROTOCOL=TCP)(HOST=localhost)(PORT=49161)))(CONNECT_DATA=(SID=xe)(SERVER=DEDICATED)))";
            String username="system";
            String password="oracle";

            Connection conn = DriverManager.getConnection(dbURL,username,password);
            
            ps=conn.prepareStatement("select * from "+tableName+" "+where);
            rs=ps.executeQuery();
            ResultSetMetaData rsmd = rs.getMetaData();
      	  	int columnsNumber = rsmd.getColumnCount();
      	  	
      	  	JSONArray jsonArray = new JSONArray();
      	  while (rs.next()) {
      		JSONObject obj = new JSONObject();
              for (int i = 0; i < columnsNumber; i++) {
                  String columnName = rs.getMetaData().getColumnLabel(i + 1);
                  Object columnValue = rs.getObject(i + 1);
                  // if value in DB is null, then we set it to default value
                  if (columnValue == null){
                      columnValue = "null";
                  }
                  /*
                  Next if block is a hack. In case when in db we have values like price and price1 there's a bug in jdbc - 
                  both this names are getting stored as price in ResulSet. Therefore when we store second column value,
                  we overwrite original value of price. To avoid that, i simply add 1 to be consistent with DB.
                   */
                  if (obj.has(columnName)){
                      columnName += "1";
                  }
                  obj.put(columnName, columnValue);
                  //System.out.println(columnName+"    :"+columnValue);
              }
              jsonArray.put(obj);
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
