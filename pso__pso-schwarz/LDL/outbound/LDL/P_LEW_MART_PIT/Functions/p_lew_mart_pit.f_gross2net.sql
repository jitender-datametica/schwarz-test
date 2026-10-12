/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : DDL for SF Functions Gross2Net PITonCloud
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Region Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Function	:	f_gross2net(gross_val double, vat_factor double)
Input		:	gross_val double
                vat_factor double FORMAT 0,10 or 0,20 
Return		:   Double net Value
Convert		: 	None 
Description	:	Converts a gross value into it's coressponding net value           
Example		:	SELECT 52.00 AS GROSS_VALUE , f_gross2net(52.00, 0.05) AS NET_VALUE , GROSS_VALUE - NET_VALUE AS VAT_VALUE;
------------------------------------------------------------------------
*/
CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_gross2net(
    gross_val FLOAT64,
    vat_factor FLOAT64
)
RETURNS FLOAT64
LANGUAGE js
AS """
    // if gross_val is "" or NULL then return null
    if ((gross_val === "") || (gross_val === null) || (Number.isNaN(gross_val) == true)) { 
        return null; 
    }
    
    // if ((VAT_FACTOR == null) || (Number.isNaN(VAT_FACTOR) == true)) { return null; }
    if ((Number.isNaN(vat_factor) == true) || (vat_factor === null)) { 
        return null; 
    }

    if (vat_factor > 1) {
        // treat VAT as percentage
        return gross_val / (1 + vat_factor / 100);
    } else if (vat_factor == 0) {
        return gross_val;
    } else {
        // treat VAT as decimal fraction
        return gross_val / (1 + vat_factor);
    }
"""; -- End of f_gross2net


/* 
---------------------------------------------------------------------
999. Testing / DQ
---------------------------------------------------------------------
*/

/* Test Rule 1: Testing table functionality */

/*
SELECT '>>> ${EXEC_PIT_TIMESTAMP} | Testing / DQ-Checks of [T_SF Functions general use on PITonCloud]' AS ""
;

SELECT 
	f_gross2net(ejr.SALES_GROSS_VAL, 0.19)          AS NET_VALUE
FROM
    ( 
		SELECT 
			--  uniform(1, 10, RANDOM(12))          AS RECEIPT_SID 
			--, uniform(100, 800, RANDOM(10))       AS TRANSACTION_TYPE_CD
			NORMAL(-100, +100, RANDOM())            AS SALES_GROSS_VAL
		FROM TABLE(GENERATOR(ROWCOUNT => 10)) v
    ) ejr
;

SELECT 'Test Rule 2 on f_gross2net and f_net2gross:' || to_char(&__rowcount) AS "";     

     
SELECT '>>> ${EXEC_PIT_TIMESTAMP} | EOF [T_SF Functions general use on PITonCloud]' AS ""
;
*/

/* --- EOF - END OF FILE --- */
