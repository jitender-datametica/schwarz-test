/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_fact_transport_cost_vehicle
Description		| This table decribes actual costs that were charged per vehicle
Created on    |	11.09.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_transport_cost_vehicle (cal_dt
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
inbound_dispo_order_sid OPTIONS(description='The unique identifier (surrogate key) for the disposition.'),
departure_site_sid OPTIONS(description='The unique identifier (surrogate key) for the site.'), destination_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), executing_hauler_sid
OPTIONS(description='The hauler who runs the crossdock.'), logistic_temp_cd
OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'), logistic_type_cd
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
transport_service_type_cd
OPTIONS(description='The code for the type of the transport service, e.g.\"Vorlauf\" or\"Zwischenlauf\"'),
segment_agmt_elem_sid OPTIONS(description='Surrogate identifier for Agreement element'), logistics_tariff_sid
OPTIONS(description='Surrogate identifier for Logistics Tariff'), equipment_type_cd
OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'), transport_capacity_qty
OPTIONS(description='The capacity of the transport vehicle, e.g. 1EP --> 1 transport capacity / 1DD --> 0.5 transport capacity'),
ep_pallet_double_deck_cnt OPTIONS(description='Number of Double Deck EP Pallets.'), ep_pallet_no_double_deck_cnt
OPTIONS(description='Number of No Double Deck EP Pallets.'), dd_pallet_double_deck_cnt
OPTIONS(description='Number of Double Deck DD Pallets.'), dd_pallet_no_double_deck_cnt
OPTIONS(description='Number of No Double Deck DD Pallets.'), std_pallet_qty
OPTIONS(description='Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.'),
vehicle_count OPTIONS(description='Amount of vehicles which are used to deliver the goods'), supplier_curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
supplier_price_per_pallet_val
OPTIONS(description='Price asked by Supplier for a transport  Calculated Amout per EP Pallet'),
supplier_price_per_vehicle_val
OPTIONS(description='Price asked by Supplier for a transport . Calculated Amout for a full vehicle'),
supplier_cost_pallet_val
OPTIONS(description='Amount of money, which is paid from Supplier to Hauler for transport. Calculated Amout  for total EP Pallet transported'),
supplier_cost_vehicle_val
OPTIONS(description='Amount of money, which is paid from Supplier to Hauler for transport. Calculated Amout for a full vehicle'),
hauler_curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
hauler_price_per_pallet_val OPTIONS(description='Price asked by Hauler for a transport  Calculated Amout for EP Pallet'),
hauler_price_per_vehicle_val
OPTIONS(description='Price asked by Hauler for a transport . Calculated Amout for a full vehicle'),
hauler_cost_pallet_val
OPTIONS(description='Amount of money, which is paid from Hauler to a transport company for transport. Calculated Amout for total EP Pallet transported'),
hauler_cost_vehicle_val
OPTIONS(description='Amount of money, which is paid from Hauler to a transport company for transport. Calculated Amout for a full vehicle'),
commission_cost_pallet_val
OPTIONS(description='Difference between supplier transport cost value and hauler transport cost value.. Calculated Amout for total EP Pallet transported'),
commission_cost_vehicle_val
OPTIONS(description='Difference between supplier transport price value and hauler transport cost value.. Calculated Amout for a full vehicle'),
storage_space_qty OPTIONS(description='Needed storage space.'), weight_ton_meas
OPTIONS(description='Which weight does total amout of pallets have'), distance_km_meas
OPTIONS(description='Distance of route segment in km'), case_cnt
OPTIONS(description='The total number of cases in this position.'), pallet_exchange_fg
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers.'))
OPTIONS(DESCRIPTION = `THIS TABLE DECRIBES ACTUAL COSTS THAT WERE CHARGED PER VEHICLE`) AS SELECT cal_dt,
 inbound_dispo_order_sid,
 departure_site_sid,
 destination_site_sid,
 executing_hauler_sid,
 logistic_temp_cd,
 logistic_type_cd,
 transport_service_type_cd,
 segment_agmt_elem_sid,
 logistics_tariff_sid,
 equipment_type_cd,
 transport_capacity_qty,
 ep_pallet_double_deck_cnt,
 ep_pallet_no_double_deck_cnt,
 dd_pallet_double_deck_cnt,
 dd_pallet_no_double_deck_cnt,
 std_pallet_qty,
 vehicle_cnt AS vehicle_count,
 supplier_curr_cd,
 supplier_price_per_pallet_val,
 supplier_price_per_vehicle_val,
 supplier_cost_pallet_val,
 supplier_cost_vehicle_val,
 hauler_curr_cd,
 hauler_price_per_pallet_val,
 hauler_price_per_vehicle_val,
 hauler_cost_pallet_val,
 hauler_cost_vehicle_val,
 commission_cost_pallet_val,
 commission_cost_vehicle_val,
 storage_space_qty,
 weight_ton_meas,
 distance_km_meas,
 case_cnt,
 pallet_exchange_fg
FROM ldl_score_core.t_fact_transport_cost_vehicle;