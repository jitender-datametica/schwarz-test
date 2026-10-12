/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_currency_2
Description		| Currency codes
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_currency_2 (curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
curr_name OPTIONS(description='The full name of the currency'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE CURRENCY CODES ACCORDING TO ISO-4217. (E.G. EUR, USD, GBP, ...)`)
AS SELECT curr_cd,
 curr_name
FROM ldl_score_core.t_dim_currency_2;