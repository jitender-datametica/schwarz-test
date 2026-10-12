CREATE OR REPLACE FUNCTION LDL_PRODUCTION.P_LEW_MART_PIT.F_CLEANSTRING(""P_STRING"" VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
STRICT
AS '
    // Falls P_STRING is """" or NULL then return null

    if (typeof P_STRING != ""string"" || P_STRING.length <= 0)  { return null; }

    try {
        // removes special empty, whitespace characters
        // replaces long and short dashes by a normal dash (minus)
        // replaces right single quotation mark (u2019) with apostrophe (u0027) 
        var newStr = P_STRING.replace(/[ ]+$/g,'''').replace(/^[ ]+/g,'''').replace(/[\\u1A20\\u00C2\\u003F\\u0092\\u180E\\u200B\\u200C\\u200D\\u2060\\uFEFF]/g, '''').replace(/[\\u0096\\u0097\\u2013]/g, ''-'').replace(/[\\u2019]/g, ''\\u0027'');
    } catch (ERROR) 
	{
			var msg = ""f_CleanString: ["" + P_STRING + ""|"" + newStr + ""]"" + ERROR.code + ""SQLSTATE:"" + ERROR.state + "" MESSAGE: "" + ERROR.message;
				
			throw new Error(msg);
			return msg ;  
    }

    return newStr;
   ';