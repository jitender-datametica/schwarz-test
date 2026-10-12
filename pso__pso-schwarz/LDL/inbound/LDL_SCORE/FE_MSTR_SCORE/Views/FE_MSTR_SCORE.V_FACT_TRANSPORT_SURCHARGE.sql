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
CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_FACT_TRANSPORT_SURCHARGE(
   individual_logistics_agmt_elem_sid       COMMENT 'Surrogate identifier for agreement element'
  ,cal_dt                                   COMMENT 'Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'
  ,surcharge_type_cd                        COMMENT 'This is a code, which defines the services for which, a fee is charged.'
  ,pallet_type_cd                           COMMENT 'Pallet code of the fact row'
  ,pallet_exchange_fg                       COMMENT 'A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'
  ,logistic_temp_cd                         COMMENT 'The code for the type of the temperature zone, e.g. TK, TL.'
  ,departure_site_sid                       COMMENT 'The unique identifier (surrogate key) for the site.'
  ,destination_site_sid                     COMMENT 'The unique identifier (surrogate key) for the site.'
  ,logistics_tariff_sid                     COMMENT 'Surrogate identifier for Logistics Tariff'
  ,validity_period_from_tmsp                COMMENT 'Validity start of transport tariff'
  ,validity_period_to_tmsp                  COMMENT 'Validity end of transport tariff'
  ,executing_hauler_sid                     COMMENT 'The hauler who runs the crossdock.'
  ,price_billing_unit_cd                    COMMENT 'This is the Unit in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'
  ,graduated_scale_billing_unit_cd          COMMENT 'This is the Unit in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'
  ,unit_from_cnt                            COMMENT 'Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit record'
  ,unit_to_cnt                              COMMENT 'End of the range for  number of pallets or pallet spaces etc for this graduated scale unit record'
  ,curr_cd                                  COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …'
  ,surcharge_val                            COMMENT 'Amount of all surcharges'

)
COMMENT = 'This table decribes list of transport surcharge prices.'
AS SELECT
   individual_logistics_agmt_elem_sid
  ,cal_dt
  ,surcharge_type_cd
  ,pallet_type_cd
  ,pallet_exchange_fg
  ,logistic_temp_cd
  ,departure_site_sid
  ,destination_site_sid
  ,logistics_tariff_sid
  ,validity_period_from_tmsp
  ,validity_period_to_tmsp
  ,executing_hauler_sid
  ,price_billing_unit_cd
  ,graduated_scale_billing_unit_cd
  ,unit_from_cnt
  ,unit_to_cnt
  ,curr_cd
  ,surcharge_val

FROM CORE.T_FACT_TRANSPORT_SURCHARGE
;