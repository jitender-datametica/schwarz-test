/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_currency
Description		| Currency codes
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_currency(
	CURR_CD COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
	CURR_NAME COMMENT 'The full name of the currency'
) COMMENT='This minor dimension defines the currency codes according to ISO-4217. (E.g. EUR, USD, GBP, ...)'
 AS 
SELECT
   curr_cd
  ,curr_name
FROM core.t_dim_currency;