/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_exchange_rate_type_2
Description		| Type of exchange rate
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_exchange_rate_type_2(
	exchange_rate_type_cd COMMENT 'The code identifying the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
	exchange_rate_type_descr COMMENT 'A textual description for the way in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...',
	fixed_rate_fg COMMENT 'An indicator showing, if the exchange rate does not change over a longer period of time, e.g. during a business year.'
) COMMENT='This minor dimension defines the ways in which one currency can be converted into another. E.g. Lidl''s reporting exchange rate, ECB rate, ...'
 AS 
SELECT
   exchange_rate_type_cd
  ,exchange_rate_type_descr
  ,fixed_rate_fg
FROM core.t_dim_exchange_rate_type_2;