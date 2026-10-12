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
#  1.0  2025-05-23 Andreas Kurz    	Initial version
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Function    :   p_lew_mart_pit.f_FormatString_ASCII(STRING)
Input       :   p_string STRING
                 
Return      :   STRING
Convert     :   None    
Description :   Replaces #(tab) by Tab Charachter
						 #(lf) by LF Charachter
Example     :   SELECT p_lew_mart_pit.f_FormatString_ASCII('4#(tab)SpecialPrice#(tab)PLATS  PO LER#(tab)2.79CHF') AS CLEAN_STRING
				-- 4	SpecialPrice	PLATS  PO LER	2.79CHF

See also https://regexr.com
https://www.fileformat.info/info/unicode/char/200b/index.htm

------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_formatstring_html(p_string STRING)
RETURNS STRING
LANGUAGE js
AS """
    // Falls P_STRING is "" or NULL then return null

    if (typeof p_string != "string" || p_string.length <= 0)  { return null; }

    try {
	
        // removes special empty, whitespace characters
        // replaces long and short dashes by a normal dash (minus)
        // replaces right single quotation mark (u2019) with apostrophe (u0027) 
		// replace #(tab) by tab character 
		// replace #(lf) by linefeed charachter
        var newStr = p_string.replace(/[ ]+$/g,'').replace(/^[ ]+/g,'').replace(/[\\u1A20\\u00C2\\u003F\\u0092\\u180E\\u200B\\u200C\\u200D\\u2060\\uFEFF]/g, '').replace(/[\\u0096\\u0097\\u2013]/g, '-').replace(/[\\u2019]/g, '\\u0027');
		
    
		newStr = newStr.replace(/#\\(tab\\)/g, '</td><td>').replace(/#\\(lf\\)/g, '</td></tr><tr><td>');
		//newStr = newStr.replace(/#\\\\(tab\\\\)/g, '</td><td>').replace(/\\\\#\\\\(lf\\\\)/g, '</td></tr><tr><td>');

		var HTMLStr = '<tr><td>' + newStr + '</td></tr>';
		
    } catch (ERROR) 
	{
			var msg = "f_FormatString_HTML: [" + p_string + "|" + HTMLStr + "] MESSAGE: " + ERROR.message;
				
			throw new Error(msg);
			return msg ;  
    }

    return HTMLStr;
""";

--4#(tab)SpecialPrice#(tab)PLATS  PO LER#(tab)2.79CHF