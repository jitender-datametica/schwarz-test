CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit_onprem.f_gross2net(
    gross_val FLOAT64,
    vat_factor FLOAT64
)
RETURNS FLOAT64
LANGUAGE js
AS """

// ---------------------------------------------------------------------
// Function	:	f_gross2net(gross_val double, vat_factor double)
// Input		:	gross_val double
//                 vat_factor double FORMAT 0,10 or 0,20 
// Return		:   Double net Value
// Convert		: 	None 
// Description	:	Converts a gross value into it''s coressponding net value           
// Example		:	SELECT 52.00 AS GROSS_VALUE , f_gross2net(52.00, 0.05) AS NET_VALUE , GROSS_VALUE - NET_VALUE AS VAT_VALUE;
// ------------------------------------------------------------------------
// 
// History:
// 1.0  2021-07-01 Andreas Kurz    Initial version
// 1.1  2021-07-26 Mike Davis      Some tweaks, extra not nulls and warehouse_mstr_sid.
// 1.1  2021-08-20 Mike Davis      Checks, formatting, FK support

    // if gross_val is "" or NULL then return null
    if ((gross_val === "") || (gross_val === null) || Number.isNaN(gross_val)) { 
        return null; 
    }
    
    // if ((VAT_FACTOR == null) || (Number.isNaN(VAT_FACTOR) == true)) { return null; }
    if (vat_factor === null || Number.isNaN(vat_factor)) { 
        return null; 
    }

    if (vat_factor > 1) {
        // treat VAT as percentage
        return gross_val / (1 + vat_factor / 100);
    } else if (vat_factor === 0) {
        return gross_val;
    } else {
        // treat VAT as decimal fraction
        return gross_val / (1 + vat_factor);
    }

""";