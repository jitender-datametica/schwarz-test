/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_dispo_order_status
Description		| Shows the actual state of an order. Whether its initialized, approved, sent.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_DISPO_ORDER_STATUS(
	DISPO_ORDER_STATUS_CD COMMENT 'The code for the status of the disposition (e.g. initialized, approved, sent)',
	DISPO_ORDER_STATUS_DESCR COMMENT 'A textual description for the dispo_order_status_cd wirtten out in group language (German).'
) COMMENT='Shows the actual state of an order. Whether its initialized, approved, sent.'
 AS 
SELECT
   dispo_order_status_cd
  ,dispo_order_status_descr
FROM CORE.T_DIM_DISPO_ORDER_STATUS;