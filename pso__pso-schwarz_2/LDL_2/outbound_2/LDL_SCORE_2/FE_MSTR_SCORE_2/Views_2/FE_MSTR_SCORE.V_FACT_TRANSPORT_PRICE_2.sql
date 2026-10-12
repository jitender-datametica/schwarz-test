/*
====================================================================================================
Division		    |	Lidl
Solution		    |	SCORE
DB schema		    |	fe_mstr_score
DB table/view	  |	v_fact_transport_price_2
Description		  | List of transport prices
Created on      |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_transport_price_2 (individual_logistics_agmt_elem_sid
OPTIONS(description='Surrogate identifier for agreement element'), cal_dt
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
transport_charge_type_cd OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
pallet_type_cd OPTIONS(description='Pallet code of the fact row'), pallet_exchange_fg
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'),
departure_site_sid OPTIONS(description='The unique identifier (surrogate key) for the site.'), destination_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), validity_period_from_tmsp
OPTIONS(description='Validity_2 start of transport tariff'), validity_period_to_tmsp
OPTIONS(description='Validity_2 end of transport tariff'), logistic_temp_cd
OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'), executing_hauler_sid
OPTIONS(description='The hauler who runs the crossdock.'), logistics_tariff_sid
OPTIONS(description='Surrogate identifier for Logistics Tariff'), price_billing_unit_cd
OPTIONS(description='This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
graduated_scale_billing_unit_cd
OPTIONS(description='This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
unit_from_cnt
OPTIONS(description='Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit_2 record'),
unit_to_cnt
OPTIONS(description='End of the range for  number of pallets or pallet spaces etc for this graduated scale unit_2 record'),
supplier_curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
supplier_transport_val
OPTIONS(description='Amount of money, which is paid from Supplier_2 to Hauler for transport. Calculated Amout for palett, palett type, strorage_space_qty'),
hauler_curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
hauler_transport_val OPTIONS(description='Calculated Amount for each route, for each vehicle'), transport_commission_val
OPTIONS(description='Difference between supplier_2 transport value and hauler transport value.'),
transport_service_type_cd
OPTIONS(description='The code for the type of the transport service, e.g.\"Vorlauf\" or\"Zwischenlauf\"'))
OPTIONS(DESCRIPTION = `THIS TABLE DECRIBES LIST OF TRANSPORT PRICES.`) AS SELECT individual_logistics_agmt_elem_sid,
 cal_dt,
 transport_charge_type_cd,
 pallet_type_cd,
 pallet_exchange_fg,
 departure_site_sid,
 destination_site_sid,
 DATE(validity_period_from_tmsp) AS validity_period_from_tmsp,
 DATE(validity_period_to_tmsp) AS validity_period_to_tmsp,
 logistic_temp_cd,
 executing_hauler_sid,
 logistics_tariff_sid,
 price_billing_unit_cd,
 graduated_scale_billing_unit_cd,
 unit_from_cnt,
 unit_to_cnt,
 supplier_curr_cd,
 supplier_transport_val,
 hauler_curr_cd,
 hauler_transport_val,
 transport_commission_val,
 transport_service_type_cd
FROM ldl_score_core.t_fact_transport_price_2;