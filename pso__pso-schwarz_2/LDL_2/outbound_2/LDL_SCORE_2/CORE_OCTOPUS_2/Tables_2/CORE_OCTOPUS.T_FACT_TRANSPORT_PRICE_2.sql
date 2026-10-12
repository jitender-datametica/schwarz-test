CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_fact_transport_price_2 (
individual_logistics_agmt_elem_sid BIGNUMERIC NOT NULL OPTIONS(description='Surrogate identifier for agreement element'),
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
transport_charge_type_cd STRING(20) NOT NULL
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
pallet_type_cd STRING(20) NOT NULL OPTIONS(description='Pallet code of the fact row'),
pallet_exchange_fg BOOL NOT NULL
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'),
departure_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
destination_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
transport_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"'),
validity_period_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Validity_2 start of transport tariff'),
validity_period_to_tmsp TIMESTAMP NOT NULL OPTIONS(description='Validity_2 end of transport tariff'),
logistic_temp_cd STRING(20) OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
executing_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
logistics_tariff_sid BIGNUMERIC OPTIONS(description='Surrogate identifier for Logistics Tariff'),
price_billing_unit_cd STRING(20)
OPTIONS(description='This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
graduated_scale_billing_unit_cd STRING(20) NOT NULL
OPTIONS(description='This is the Unit_2 in which Billing component are charged. For Example: Pallets or Pallet Spaces etc.'),
unit_from_cnt BIGNUMERIC NOT NULL
OPTIONS(description='Start of the range for number of pallets or pallet spaces etc. for this graduated scale unit_2 record'),
unit_to_cnt BIGNUMERIC NOT NULL
OPTIONS(description='End of the range for  number of pallets or pallet spaces etc for this graduated scale unit_2 record'),
supplier_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
supplier_transport_val BIGNUMERIC(38,5)
OPTIONS(description='Amount of money, which is paid from Supplier_2 to Hauler for transport. Calculated Amout for palett, palett type, strorage_space_qty'),
hauler_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
hauler_transport_val BIGNUMERIC(38,5) OPTIONS(description='Calculated Amount for each route, for each vehicle'),
transport_commission_val BIGNUMERIC(38,5)
OPTIONS(description='Difference between supplier_2 transport value and hauler transport value.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (individual_logistics_agmt_elem_sid, cal_dt, transport_charge_type_cd, pallet_type_cd, pallet_exchange_fg,
 departure_site_sid, destination_site_sid, transport_service_type_cd, unit_from_cnt) NOT ENFORCED
) OPTIONS(description='This table decribes list of transport prices valid for each day');