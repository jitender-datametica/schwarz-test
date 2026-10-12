/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for SF Functions general use on PITonCloud
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Region_2 Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-07-26 Mike Davis      	Some tweaks, extra not nulls and warehouse_mstr_sid.
#  1.2  2021-08-20 Mike Davis      	Checks, formatting, FK support
#  1.3  2022-03-01 Andreas Kurz		Added Removal of all Whitespaces (Trim All)
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Function    :   f_CleanString(STRING)
Input       :   p_string STRING
                 
Return      :   STRING
Convert     :   None    
Description :   Clean the input string by Special charachters
			:	Also Removing all Whitespaces - similar to left right Trim
Example     :   SELECT f_CleanString('\taZ1234.()–') AS CLEAN_STRING

See also https://regexr.com
https://www.fileformat.info/info/unicode/char/200b/index.htm

------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_cleanstring(p_string STRING)
RETURNS STRING
LANGUAGE js AS r"""

// If NULL or empty → return NULL
if (p_string === null || typeof p_string !== "string" || p_string.length === 0) {
  return null;
}

try {
  // Remove trailing and leading spaces
  // Remove special invisible characters
  // Replace long/short dashes with normal dash
  // Replace right single quote with apostrophe
  
  var newStr = p_string
    .replace(/[ ]+$/g, '')                      // trailing spaces
    .replace(/^[ ]+/g, '')                      // leading spaces
    .replace(/[\u1A20\u00C2\u003F\u0092\u180E\u200B\u200C\u200D\u2060\uFEFF]/g, '')
    .replace(/[\u0096\u0097\u2013]/g, '-')      // normalize dashes
    .replace(/[\u2019]/g, '\u0027');            // normalize apostrophe

  return newStr;

} catch (err) {
  throw new Error("f_CleanString error: " + err.message);
}

""";
/* 
---------------------------------------------------------------------
999. Testing / DQ
---------------------------------------------------------------------

SELECT 
       to_char(f_CleanString(a.TEST_STRING)) AS CLEAN_STRING
     , TRIM(LENGTH(a.TEST_STRING)) AS LEN_CLEAN_STRING
FROM
(
select collate('1023456 (test_2) הצ789Ww12AZ \t_12 -–34 5''().-' || listagg(chr(column1)),'utf16') AS TEST_STRING
from (values(8204), (39), (13), (8205), (8288), (6158), (8203), (8288), (65279))
) a
;
*/