CREATE OR REPLACE FUNCTION LDL_PRODUCTION.P_LEW_MART_PIT.F_GROSS2NET(""GROSS_VAL"" FLOAT, ""VAT_FACTOR"" FLOAT)
RETURNS FLOAT
LANGUAGE JAVASCRIPT
STRICT
AS '
		// if gross_val is """" or NULL then return null
		if ((GROSS_VAL == """") || (GROSS_VAL == null) || (Number.isNaN(GROSS_VAL) == true)) { return null; }
		
		// if ((VAT_FACTOR == null) || (Number.isNaN(VAT_FACTOR) == true)) { return null; }
		if ((Number.isNaN(VAT_FACTOR) == true)) { return null; }
		
		
		if (VAT_FACTOR > 1) {
						return GROSS_VAL / (VAT_FACTOR / 100) ;
		} else if (VAT_FACTOR == 0) {
						return GROSS_VAL ;
		}
		else {
						return GROSS_VAL / (1 + VAT_FACTOR ) ;
		}
		
		
	';