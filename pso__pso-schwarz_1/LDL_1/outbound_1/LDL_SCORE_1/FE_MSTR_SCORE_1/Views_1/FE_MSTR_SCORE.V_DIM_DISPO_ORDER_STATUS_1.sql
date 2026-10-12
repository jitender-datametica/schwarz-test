/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_dispo_order_status_1
Description		| Shows the actual state of an order. Whether its initialized, approved, sent.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_dispo_order_status_1 (dispo_order_status_cd
OPTIONS(description='The code for the status_1 of the disposition (e.g. initialized, approved, sent)'),
dispo_order_status_descr
OPTIONS(description='A textual description for the dispo_order_status_cd wirtten out in group language (German).'))
OPTIONS(DESCRIPTION = `SHOWS THE ACTUAL STATE OF AN ORDER. WHETHER ITS INITIALIZED, APPROVED, SENT.`) AS SELECT
 dispo_order_status_cd,
 dispo_order_status_descr
FROM ldl_score_core.t_dim_dispo_order_status_1;