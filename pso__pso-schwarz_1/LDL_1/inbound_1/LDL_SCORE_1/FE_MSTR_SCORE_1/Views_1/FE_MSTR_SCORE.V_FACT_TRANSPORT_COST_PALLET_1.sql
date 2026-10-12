/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_fact_transport_cost_pallet_1
Description		| Actual costs that were charged per pallet
Created on    |	15.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_FACT_TRANSPORT_COST_PALLET_1(
	INBOUND_TRANSPORT_PLAN_POS_SID COMMENT 'new - unique identifier (surrogate key) of the transport plan position',
	CAL_DT COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
	DEPARTURE_SITE_SID COMMENT 'The unique identifier (surrogate key) for the site.',
	DESTINATION_SITE_SID COMMENT 'The unique identifier (surrogate key) for the site.',
	EXECUTING_HAULER_SID COMMENT 'The hauler who runs the crossdock.',
	LOGISTIC_TYPE_CD COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
	TRANSPORT_SERVICE_TYPE_CD COMMENT 'The code for the type of the transport service, e.g. \"Vorlauf\" or \"Zwischenlauf\"',
	LOGISTIC_TEMP_CD COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
	PALLET_TYPE_CD COMMENT 'A code for the pallet that indicates the storage occupation for transportation.',
	DOUBLE_DECK_FG COMMENT 'indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space',
	SEGMENT_AGMT_ELEM_SID COMMENT 'Surrogate identifier for Agreement element',
	LOGISTICS_TARIFF_SID COMMENT 'Surrogate identifier for Logistics Tariff',
	SUPPLIER_CURR_CD COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
	SUPPLIER_TRANSPORT_VAL COMMENT 'Amount of money, which is paid from Supplier_1 to Hauler for transport. Calculated Amout for palett, palett type, strorage_space_qty',
	HAULER_CURR_CD COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
	HAULER_TRANSPORT_VAL COMMENT 'Calculated Amount for each route, for each vehicle',
	TRANSPORT_COMMISSION_VAL COMMENT 'Difference between supplier_1 transport value and hauler transport value.',
	STORAGE_SPACE_QTY COMMENT 'Needed storage space.',
	WEIGHT_TON_MEAS COMMENT 'which weight does total amout of pallets have',
	DISTANCE_KM_MEAS COMMENT 'Distance of route segment in km',
	STD_PALLET_QTY COMMENT 'Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.',
	CASE_CNT COMMENT 'The total number of cases in this position.'
) COMMENT='This table decribes actual costs that were charged per pallet'
 AS 
SELECT
   inbound_transport_plan_pos_sid
  ,cal_dt
  ,departure_site_sid
  ,destination_site_sid
  ,executing_hauler_sid
  ,logistic_type_cd
  ,transport_service_type_cd
  ,logistic_temp_cd
  ,pallet_type_cd
  ,double_deck_fg
  ,segment_agmt_elem_sid
  ,logistics_tariff_sid
  ,supplier_curr_cd
  ,supplier_transport_val
  ,hauler_curr_cd
  ,hauler_transport_val
  ,transport_commission_val
  ,storage_space_qty
  ,weight_ton_meas
  ,distance_km_meas
  ,std_pallet_qty
  ,case_cnt
FROM CORE.T_FACT_TRANSPORT_COST_PALLET_1;