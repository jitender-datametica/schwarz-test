CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit_onprem.f_net2gross(
    net_val FLOAT64,
    vat_factor FLOAT64
)
RETURNS FLOAT64
LANGUAGE js
AS """

// ---------------------------------------------------------------------
// Function	:	f_net2gross(net_val double, vat_factor double)
// Input		:   net_val double
// 				vat_factor double FORMAT 0,10 or 0,20 
// Return		:	Double gross value
// Convert		:	None    
// Description	: 	Converts a net value into it''s coressponding gross value
// Example		:	SELECT 9.82 AS NET_VALUE, f_gross2net(try_to_douuble(9.82), 0.19) AS GROSS_VALUE
// ------------------------------------------------------------------------
//
// History:
// 1.0  2021-07-01 Andreas Kurz    Initial version
// 1.1  2021-07-26 Mike Davis      Some tweaks, extra not nulls and warehouse_mstr_sid.
// 1.1  2021-08-20 Mike Davis      Checks, formatting, FK support                

    // if gross_val is "" or NULL then return null
    if ((net_val === "") || (net_val === null) || Number.isNaN(net_val)) {
        return null;
    }
    
    // if ((VAT_FACTOR == null) || (Number.isNaN(VAT_FACTOR) == true)) { return null; }
    if (vat_factor === null || Number.isNaN(vat_factor)) {
        return null;
    }

    if (vat_factor > 1) {
        // treat VAT as percentage
        return net_val * (1 + vat_factor / 100);
    } else if (vat_factor === 0) {
        return net_val;
    } else {
        // treat VAT as decimal fraction
        return net_val * (1 + vat_factor);
    }

""";