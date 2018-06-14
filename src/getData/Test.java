package getData;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class Test
{
   private String email;
    public Test(String email)
    {
        this.email=email;
    }



Test() {

}

public Boolean isvalid(String email)
{


String lastToken = null;
  Pattern p = Pattern.compile(".+@.+.[a-z]+");
   // Match the given string with the pattern
   Matcher m = p.matcher(email);
   // check whether match is found
   boolean matchFound = m.matches();
   StringTokenizer st = new StringTokenizer(email, ".");
   while (st.hasMoreTokens())
   {
      lastToken = st.nextToken();
   }



if (matchFound && lastToken.length() >= 2
      && email.length() - 1 != lastToken.length())
   {



  return true;


}
   else
       return false;



}


public String toString() {
    return email;
    }



}

