CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_fact_transport_surcharge_1 (
individual_logistics_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for agreement element'),
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
surcharge_type_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
pallet_type_cd STRING(20) NOT NULL OPTIONS(description='Pallet code of the fact row'),
pallet_exchange_fg BOOL NOT NULL
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'),
logistic_temp_cd STRING(20) OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
departure_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
destination_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
logistics_tariff_sid BIGNUMERIC OPTIONS(description='Surrogate identifier for Logistics Tariff'),
validity_period_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Validity_1 start of transport tariff'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_1 end of transport tariff'),
executing_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
price_billing_unit_cd STRING(20)
OPTIONS(description='This is the Unit_1 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
graduated_scale_billing_unit_cd STRING(20) NOT NULL
OPTIONS(description='This is the Unit_1 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
unit_from_cnt BIGNUMERIC NOT NULL
OPTIONS(description='Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit_1 record'),
unit_to_cnt BIGNUMERIC NOT NULL
OPTIONS(description='End of the range for  number of pallets or pallet spaces etc for this graduated scale unit_1 record'),
curr_cd STRING(3) NOT NULL
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
surcharge_val BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Amount of all surcharges'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (individual_logistics_agmt_elem_sid, cal_dt, pallet_type_cd, pallet_exchange_fg, surcharge_type_cd,
 departure_site_sid) NOT ENFORCED
) OPTIONS(description='This table decribes list of transport surcharge prices.');