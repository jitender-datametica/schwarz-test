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


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_transport_plan_position_2 (inbound_transport_plan_pos_sid
OPTIONS(description='Unique identifier (surrogate key) of the transport plan position'), inbound_dispo_order_pos_sid
OPTIONS(description='The unique identifier (surrogate key) for the disposition position.'), transport_plan_pos_seq
OPTIONS(description='indicator for the sequence in which the activities are conducted'), transport_start_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), transport_end_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), plan_start_from_dt
OPTIONS(description='Point in time when the product delivery starts earliest'), plan_end_to_dt
OPTIONS(description='Point in time when the products need to be at the destination or the service needs to be finished latest'),
plan_end_from_dt
OPTIONS(description='Point in time when the products need to be at the destination or the service needs to be finished earliest'),
plan_start_to_dt OPTIONS(description='Point in time when the products delivery starts latest'))
OPTIONS(DESCRIPTION = `THE ENTITY CONTAINS INFORMATION REGARDING TRANSPORT FOR ALL PRODUCTS OF A DISPOSITION, I.E. WHICH TRAVEL ROUTE A PRODUCT TAKES.`)
AS SELECT inbound_transport_plan_pos_sid,
 inbound_dispo_order_pos_sid,
 transport_plan_pos_seq,
 transport_start_site_sid,
 transport_end_site_sid,
 plan_start_from_dt,
 plan_end_to_dt,
 plan_end_from_dt,
 plan_start_to_dt
FROM ldl_score_core.t_dim_transport_plan_position_2
WHERE CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;