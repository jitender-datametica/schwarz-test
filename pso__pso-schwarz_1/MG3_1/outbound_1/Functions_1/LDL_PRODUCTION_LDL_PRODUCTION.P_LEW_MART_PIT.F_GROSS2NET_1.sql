CREATE OR REPLACE FUNCTION ldl_production_p_lew_mart_pit.f_gross2net(
  gross_val FLOAT64,
  vat_factor FLOAT64
)  
RETURNS FLOAT64  
LANGUAGE js  
AS r"""
		// if gross_val is """" or NULL then return null
  if (gross_val === null || Number.isNaN(gross_val)) {
    return null;
  }
		// if ((VAT_FACTOR == null) || (Number.isNaN(VAT_FACTOR) == true)) { return null; }
  if (vat_factor === null || Number.isNaN(vat_factor)) {
    return null;
  }

  if (vat_factor > 1) {
    return gross_val / (vat_factor / 100);
  } else if (vat_factor === 0) {
    return gross_val;
  } else {
    return gross_val / (1 + vat_factor);
  }
""";