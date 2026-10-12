CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit_onprem.f_cleanstring(p_string STRING)
RETURNS STRING
LANGUAGE js
AS """
// ---------------------------------------------------------------------
// Function_    :  P_LEW_MART_PIT_ONPREM.f_CleanString(STRING)
// Input       :   p_string STRING                 
// Return      :   STRING
// Convert     :   None    
// Description :   Clean the input string by Special charachters
// Example     :   SELECT f_CleanString('\\taZ1234.()–') AS CLEAN_STRING
// 
// See also https://regexr.com
// https://www.fileformat.info/info/unicode/char/200b/index.htm
//
// ------------------------------------------------------------------------
// History:
//  1.0  2021-07-01 Andreas Kurz    Initial version
//  1.1  2021-07-26 Mike Davis      Some tweaks, extra not nulls and warehouse_mstr_sid.
//  1.1  2021-08-20 Mike Davis      Checks, formatting, FK support

    // Falls P_STRING is "" or NULL then return null
    if (typeof p_string !== "string" || p_string.length === 0) {
        return null;
    }

    try {
        // removes special empty, whitespace characters
        // replaces long and short dashes by a normal dash (minus)
        // replaces right single quotation mark (u2019) with apostrophe (u0027) 
        var newStr = p_string
            .replace(/[\u1A20\u00C2\u003F\u0092\u180E\u200B\u200C\u200D\u2060\uFEFF]/g, "")
            .replace(/[\u0096\u0097\u2013]/g, "-")
            .replace(/[\u2019]/g, "\u0027");
    } catch (ERROR) {
        var msg = "f_CleanString: [" + p_string + "|" + newStr + "] " + ERROR.code + " SQLSTATE:" + ERROR.state + " MESSAGE: " + ERROR.message;
        throw new Error(msg);
    }

    return newStr;
""";