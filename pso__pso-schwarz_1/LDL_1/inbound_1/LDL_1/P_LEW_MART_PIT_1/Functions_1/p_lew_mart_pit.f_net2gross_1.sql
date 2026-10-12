/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for SF Functions Net2Gross
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Region_1 Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-07-26 Mike Davis      Some tweaks, extra not nulls and warehouse_mstr_sid.
#  1.1  2021-08-20 Mike Davis      Checks, formatting, FK support
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Function	:	f_net2gross(net_val double, vat_factor double)
Input		:   net_val double
				vat_factor double FORMAT 0,10 or 0,20 
Return		:	Double gross value
Convert		:	None    
Description	: 	Converts a net value into it''s coressponding gross value
Example		:	SELECT 9.82 AS NET_VALUE, f_gross2net(try_to_douuble(9.82), 0.19) AS GROSS_VALUE
------------------------------------------------------------------------
*/


CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_net2gross(
    net_val FLOAT64,
    vat_factor FLOAT64
)
RETURNS FLOAT64
LANGUAGE js
AS """
    // if gross_val is "" or NULL then return null
    if ((net_val === "") || (net_val === null) || (Number.isNaN(net_val) == true)) { 
        return null; 
    }
    
    // if ((VAT_FACTOR == null) || (Number.isNaN(VAT_FACTOR) == true)) { return null; }
    if ((Number.isNaN(vat_factor) == true) || (vat_factor === null)) { 
        return null; 
    }

    if (vat_factor > 1) {
        return net_val * (1 + vat_factor / 100);
    } else if (vat_factor == 0) {
        return net_val;
    } else {
        return net_val * (1 + vat_factor);
    }
"""; -- End of f_net2gross


/* 
---------------------------------------------------------------------
999. Testing / DQ
---------------------------------------------------------------------
*/

/* Test_1 Rule 1: Testing table functionality */

/*
SELECT '>>> ${EXEC_PIT_TIMESTAMP} | Testing / DQ-Checks of [T_SF Functions general use on PITonCloud]' AS ""
;

SELECT 
--	  f_gross2net(try_to_double('1000'), 0.19) AS NET_VALUE
	  inp.net_val
	, inp.vat_factor
	, f_net2gross(inp.net_val, inp.vat_factor) 			   AS GROSS_VALUE 
FROM 
(
SELECT
	  SEQ4() + 1 AS CLIENT_ID
	, UNIFORM(100.25, 800.3, RANDOM()) AS net_val
	, UNIFORM(5, 21, RANDOM(1))/100 AS vat_factor
FROM 
	TABLE(generator(rowcount => 10)) V
) inp
;

SELECT 'Test_1 Rule 2 on f_gross2net and f_net2gross:' || to_char(&__rowcount) AS "";     

     

SELECT '>>> ${EXEC_PIT_TIMESTAMP} | EOF [T_SF Functions general use on PITonCloud]' AS ""
;
*/

/* --- EOF - END OF FILE --- */
