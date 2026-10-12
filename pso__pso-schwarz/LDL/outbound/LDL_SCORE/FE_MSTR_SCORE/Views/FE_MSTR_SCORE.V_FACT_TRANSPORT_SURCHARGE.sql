/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_fact_transport_surcharge
Description		  | List of transport surcharge price
Created on        |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_fact_transport_surcharge (individual_logistics_agmt_elem_sid
OPTIONS(description='Surrogate identifier for agreement element'), cal_dt
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
surcharge_type_cd OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
pallet_type_cd OPTIONS(description='Pallet code of the fact row'), pallet_exchange_fg
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'),
logistic_temp_cd OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'), departure_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), destination_site_sid
OPTIONS(description='The unique identifier (surrogate key) for the site.'), logistics_tariff_sid
OPTIONS(description='Surrogate identifier for Logistics Tariff'), validity_period_from_tmsp
OPTIONS(description='Validity start of transport tariff'), validity_period_to_tmsp
OPTIONS(description='Validity end of transport tariff'), executing_hauler_sid
OPTIONS(description='The hauler who runs the crossdock.'), price_billing_unit_cd
OPTIONS(description='This is the Unit in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
graduated_scale_billing_unit_cd
OPTIONS(description='This is the Unit in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
unit_from_cnt
OPTIONS(description='Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit record'),
unit_to_cnt
OPTIONS(description='End of the range for  number of pallets or pallet spaces etc for this graduated scale unit record'),
curr_cd
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
surcharge_val OPTIONS(description='Amount of all surcharges'))
OPTIONS(DESCRIPTION = `THIS TABLE DECRIBES LIST OF TRANSPORT SURCHARGE PRICES.`) AS SELECT
 individual_logistics_agmt_elem_sid,
 cal_dt,
 surcharge_type_cd,
 pallet_type_cd,
 pallet_exchange_fg,
 logistic_temp_cd,
 departure_site_sid,
 destination_site_sid,
 logistics_tariff_sid,
 validity_period_from_tmsp,
 validity_period_to_tmsp,
 executing_hauler_sid,
 price_billing_unit_cd,
 graduated_scale_billing_unit_cd,
 unit_from_cnt,
 unit_to_cnt,
 curr_cd,
 surcharge_val
FROM ldl_score_core.t_fact_transport_surcharge;