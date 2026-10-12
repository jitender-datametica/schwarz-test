CREATE OR REPLACE FUNCTION LDL_DATA_PRODUCTION.EVAL.MD5_DECODE("INPUT" VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVA
RUNTIME_VERSION = '11'
HANDLER = 'HashUDF.md5Hash'
AS '
  import java.security.MessageDigest;
  import java.security.NoSuchAlgorithmException;

  class HashUDF {
    public static String md5Hash(String input) {
      if (input == null) return null;
      try {
        byte[] bytes = input.getBytes("UTF-16LE");
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] digest = md.digest(bytes);

        // Convert to hex string
        StringBuilder sb = new StringBuilder();
        for (byte b : digest) {
          sb.append(String.format("%02x", b));
        }
        return sb.toString();
      } catch (Exception e) {
        return "Error: " + e.getMessage();
      }
    }
  }
';