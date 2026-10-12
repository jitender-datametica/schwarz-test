/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_transport_plan_position_2
Description		| The entity contains information regarding transport for all products of a disposition, i.e. which travel route a product takes.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_TRANSPORT_PLAN_POSITION_2 (
	INBOUND_TRANSPORT_PLAN_POS_SID COMMENT 'Unique identifier (surrogate key) of the transport plan position',
	INBOUND_DISPO_ORDER_POS_SID COMMENT 'The unique identifier (surrogate key) for the disposition position.',
	TRANSPORT_PLAN_POS_SEQ COMMENT 'indicator for the sequence in which the activities are conducted',
	TRANSPORT_START_SITE_SID COMMENT 'The unique identifier (surrogate key) for the site.',
	TRANSPORT_END_SITE_SID COMMENT 'The unique identifier (surrogate key) for the site.',
	PLAN_START_FROM_DT COMMENT 'Point in time when the product delivery starts earliest',
	PLAN_END_TO_DT COMMENT 'Point in time when the products need to be at the destination or the service needs to be finished latest',
	PLAN_END_FROM_DT COMMENT 'Point in time when the products need to be at the destination or the service needs to be finished earliest',
	PLAN_START_TO_DT COMMENT 'Point in time when the products delivery starts latest'
) COMMENT='The entity contains information regarding transport for all products of a disposition, i.e. which travel route a product takes.'
 AS 
SELECT
   inbound_transport_plan_pos_sid
  ,inbound_dispo_order_pos_sid
  ,transport_plan_pos_seq
  ,transport_start_site_sid
  ,transport_end_site_sid
  ,plan_start_from_dt
  ,plan_end_to_dt
  ,plan_end_from_dt
  ,plan_start_to_dt
FROM CORE.T_DIM_TRANSPORT_PLAN_POSITION_2
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;