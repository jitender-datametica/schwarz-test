/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_fact_transport_cost_vehicle_1
Description		| This table decribes actual costs that were charged per vehicle
Created on    |	11.09.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_FACT_TRANSPORT_COST_VEHICLE_1(
	CAL_DT COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse',
	INBOUND_DISPO_ORDER_SID COMMENT 'The unique identifier (surrogate key) for the disposition.',
	DEPARTURE_SITE_SID COMMENT 'The unique identifier (surrogate key) for the site.',
	DESTINATION_SITE_SID COMMENT 'The unique identifier (surrogate key) for the site.',
	EXECUTING_HAULER_SID COMMENT 'The hauler who runs the crossdock.',
	LOGISTIC_TEMP_CD COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.',
	LOGISTIC_TYPE_CD COMMENT 'The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)',
	TRANSPORT_SERVICE_TYPE_CD COMMENT 'The code for the type of the transport service, e.g. \"Vorlauf\" or \"Zwischenlauf\"',
	SEGMENT_AGMT_ELEM_SID COMMENT 'Surrogate identifier for Agreement element',
	LOGISTICS_TARIFF_SID COMMENT 'Surrogate identifier for Logistics Tariff',
	EQUIPMENT_TYPE_CD COMMENT 'The type discriminator for this equipment, i.e. vehicle(truck)',
	TRANSPORT_CAPACITY_QTY COMMENT 'The capacity of the transport vehicle, e.g. 1EP --> 1 transport capacity / 1DD --> 0.5 transport capacity',
	EP_PALLET_DOUBLE_DECK_CNT COMMENT 'Number of Double Deck EP Pallets.',
	EP_PALLET_NO_DOUBLE_DECK_CNT COMMENT 'Number of No Double Deck EP Pallets.',
	DD_PALLET_DOUBLE_DECK_CNT COMMENT 'Number of Double Deck DD Pallets.',
	DD_PALLET_NO_DOUBLE_DECK_CNT COMMENT 'Number of No Double Deck DD Pallets.',
	STD_PALLET_QTY COMMENT 'Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.',
	VEHICLE_COUNT COMMENT 'Amount of vehicles which are used to deliver the goods',
	SUPPLIER_CURR_CD COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
	SUPPLIER_PRICE_PER_PALLET_VAL COMMENT 'Price asked by Supplier_1 for a transport  Calculated Amout per EP Pallet',
	SUPPLIER_PRICE_PER_VEHICLE_VAL COMMENT 'Price asked by Supplier_1 for a transport . Calculated Amout for a full vehicle',
	SUPPLIER_COST_PALLET_VAL COMMENT 'Amount of money, which is paid from Supplier_1 to Hauler for transport. Calculated Amout  for total EP Pallet transported',
	SUPPLIER_COST_VEHICLE_VAL COMMENT 'Amount of money, which is paid from Supplier_1 to Hauler for transport. Calculated Amout for a full vehicle',
	HAULER_CURR_CD COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
	HAULER_PRICE_PER_PALLET_VAL COMMENT 'Price asked by Hauler for a transport  Calculated Amout for EP Pallet',
	HAULER_PRICE_PER_VEHICLE_VAL COMMENT 'Price asked by Hauler for a transport . Calculated Amout for a full vehicle',
	HAULER_COST_PALLET_VAL COMMENT 'Amount of money, which is paid from Hauler to a transport company for transport. Calculated Amout for total EP Pallet transported',
	HAULER_COST_VEHICLE_VAL COMMENT 'Amount of money, which is paid from Hauler to a transport company for transport. Calculated Amout for a full vehicle',
	COMMISSION_COST_PALLET_VAL COMMENT 'Difference between supplier_1 transport cost value and hauler transport cost value.. Calculated Amout for total EP Pallet transported',
	COMMISSION_COST_VEHICLE_VAL COMMENT 'Difference between supplier_1 transport price value and hauler transport cost value.. Calculated Amout for a full vehicle',
	STORAGE_SPACE_QTY COMMENT 'Needed storage space.',
	WEIGHT_TON_MEAS COMMENT 'Which weight does total amout of pallets have',
	DISTANCE_KM_MEAS COMMENT 'Distance of route segment in km',
	CASE_CNT COMMENT 'The total number of cases in this position.',
	PALLET_EXCHANGE_FG COMMENT 'A pallet exchange program is a collective agreement between pallet shippers and receivers.'
) COMMENT='This table decribes actual costs that were charged per vehicle'
 AS 
SELECT
   cal_dt
  ,inbound_dispo_order_sid
  ,departure_site_sid
  ,destination_site_sid
  ,executing_hauler_sid
  ,logistic_temp_cd
  ,logistic_type_cd
  ,transport_service_type_cd
  ,segment_agmt_elem_sid
  ,logistics_tariff_sid
  ,equipment_type_cd
  ,transport_capacity_qty
  ,ep_pallet_double_deck_cnt
  ,ep_pallet_no_double_deck_cnt
  ,dd_pallet_double_deck_cnt
  ,dd_pallet_no_double_deck_cnt
  ,std_pallet_qty
  ,vehicle_cnt AS vehicle_count
  ,supplier_curr_cd
  ,supplier_price_per_pallet_val
  ,supplier_price_per_vehicle_val
  ,supplier_cost_pallet_val
  ,supplier_cost_vehicle_val
  ,hauler_curr_cd
  ,hauler_price_per_pallet_val
  ,hauler_price_per_vehicle_val
  ,hauler_cost_pallet_val
  ,hauler_cost_vehicle_val
  ,commission_cost_pallet_val
  ,commission_cost_vehicle_val
  ,storage_space_qty
  ,weight_ton_meas
  ,distance_km_meas
  ,case_cnt
  ,pallet_exchange_fg
FROM CORE.T_FACT_TRANSPORT_COST_VEHICLE_1
;