/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_exchange_rate_type_1
Description		| Type of exchange rate
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_exchange_rate_type_1 (exchange_rate_type_cd
OPTIONS(description='The code identifying the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
exchange_rate_type_descr
OPTIONS(description='A textual description for the way in which one currency can be converted into another. E.g. Lidl\'s reporting exchange rate, ECB rate, ...'),
fixed_rate_fg
OPTIONS(description='An indicator showing, if the exchange rate does not change over a longer period of time, e.g. during a business year.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE WAYS IN WHICH ONE CURRENCY CAN BE CONVERTED INTO ANOTHER. E.G. LIDL''S REPORTING EXCHANGE RATE, ECB RATE, ...`)
AS SELECT exchange_rate_type_cd,
 exchange_rate_type_descr,
 fixed_rate_fg
FROM ldl_score_core.t_dim_exchange_rate_type_1;