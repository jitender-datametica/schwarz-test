/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_inbound_dispo_order
Description		| The entity contains head information for all inbound logistics dispositions.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_INBOUND_DISPO_ORDER(
	INBOUND_DISPO_ORDER_SID COMMENT 'The unique identifier (surrogate key) for the disposition.',
	DISPO_NR COMMENT 'A numeric or alphanumeric value which identifies the disposition for the business.',
	BUS_COUNTRY_CD COMMENT 'A two-character code according to the business definition of Kaufland or Lidl.',
	IS_RECYCLED_FG COMMENT 'The flag sorts out a new DISPOID (ELM), which includes the same information as the old DISPOID. Therefore the old DISPOID is not included in the factual communication.',
	LOGISTIC_TYPE_ID COMMENT 'ID for logistic_temp_cd. e.g. KT has ID 24, TK 25. ',
	LOGISTIC_TEMP_CD COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
	DIRECT_DISPO_FG COMMENT 'Flag for a direct dispo. Whether its a direct delivery from the supplier to the Lidl regional distribution center (Direktlauf).',
	COMBINED_LOGISTICS_FG COMMENT 'The flag sorts out combi logistics, which are excluded in the factual communication.',
	LOGISTIC_TYPE_CD COMMENT 'The code for the type of the logistic, e.g. Direct- or Collective logistics.',
	DISPO_ORDER_STATUS_CD COMMENT 'The code for the status of the disposition (e.g. initialized, approved, sent)',
	DISPO_YEAR COMMENT 'The dispo year.',
	DISPO_WEEK COMMENT 'The dispo week.',
	DISPO_SCHEME_DESCR COMMENT 'LogType + shortcut for cross dock+ cross dock name + target country.',
	ORDER_DAY_SEQ COMMENT 'An indicator showing which order day within the dispo week.',
	VERSION_NR COMMENT 'A number showing the version of the disposition. It increases with each change.',
	MAIN_CROSSDOCK_SITE_SID COMMENT 'The unique identifier (surrogate key) for the cross-dock that is used in case of Collective-Logistics.',
	DELIVERY_FROM_DT COMMENT 'In case of Collective-Logistics it contains the minimum date of the delivery.',
	DELIVERY_TO_DT COMMENT 'In case of Collective-Logistics it contains the maximum date of the delivery.',
  PLANNED_ORDER_DT COMMENT 'A date when disposition supposed to be ordered, may differ from a date when disposition was really sent.'
) COMMENT='The entity contains head information for all inbound logistics dispositions.'
 AS 
SELECT
   inbound_dispo_order_sid
  ,dispo_nr
  ,bus_country_cd
  ,is_recycled_fg
  ,logistic_type_id
  ,logistic_temp_cd
  ,direct_dispo_fg
  ,combined_logistics_fg
  ,logistic_type_cd
  ,dispo_order_status_cd
  ,dispo_year
  ,dispo_week
  ,dispo_scheme_descr
  ,order_day_seq
  ,version_nr
  ,main_crossdock_site_sid
  ,delivery_from_dt
  ,delivery_to_dt
  ,planned_order_dt
FROM CORE.T_DIM_INBOUND_DISPO_ORDER
WHERE CURRENT_TIMESTAMP BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp;