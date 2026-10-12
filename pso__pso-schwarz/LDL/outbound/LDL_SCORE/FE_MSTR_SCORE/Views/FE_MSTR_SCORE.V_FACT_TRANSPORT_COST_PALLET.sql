/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_fact_transport_cost_pallet
Description		| Actual costs that were charged per pallet
Created on    |	15.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_transport_cost_pallet (inbound_transport_plan_pos_sid
OPTIONS(description='new - unique identifier (surrogate key) of the transport plan position'), cal_dt
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
departure_site_sid OPTIONS(description='The unique identifier (surrogate key) for the site.'), destination_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), executing_hauler_sid
OPTIONS(description='The hauler who runs the crossdock.'), logistic_type_cd
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
transport_service_type_cd
OPTIONS(description='The code for the type of the transport service, e.g.\"Vorlauf\" or\"Zwischenlauf\"'),
logistic_temp_cd OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'), pallet_type_cd
OPTIONS(description='A code for the pallet that indicates the storage occupation for transportation.'), double_deck_fg
OPTIONS(description='indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space'),
segment_agmt_elem_sid OPTIONS(description='Surrogate identifier for Agreement element'), logistics_tariff_sid
OPTIONS(description='Surrogate identifier for Logistics Tariff'), supplier_curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
supplier_transport_val
OPTIONS(description='Amount of money, which is paid from Supplier to Hauler for transport. Calculated Amout for palett, palett type, strorage_space_qty'),
hauler_curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
hauler_transport_val OPTIONS(description='Calculated Amount for each route, for each vehicle'), transport_commission_val
OPTIONS(description='Difference between supplier transport value and hauler transport value.'), storage_space_qty
OPTIONS(description='Needed storage space.'), weight_ton_meas
OPTIONS(description='which weight does total amout of pallets have'), distance_km_meas
OPTIONS(description='Distance of route segment in km'), std_pallet_qty
OPTIONS(description='Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.'),
case_cnt OPTIONS(description='The total number of cases in this position.'))
OPTIONS(DESCRIPTION = `THIS TABLE DECRIBES ACTUAL COSTS THAT WERE CHARGED PER PALLET`) AS SELECT
 inbound_transport_plan_pos_sid,
 cal_dt,
 departure_site_sid,
 destination_site_sid,
 executing_hauler_sid,
 logistic_type_cd,
 transport_service_type_cd,
 logistic_temp_cd,
 pallet_type_cd,
 double_deck_fg,
 segment_agmt_elem_sid,
 logistics_tariff_sid,
 supplier_curr_cd,
 supplier_transport_val,
 hauler_curr_cd,
 hauler_transport_val,
 transport_commission_val,
 storage_space_qty,
 weight_ton_meas,
 distance_km_meas,
 std_pallet_qty,
 case_cnt
FROM ldl_score_core.t_fact_transport_cost_pallet;