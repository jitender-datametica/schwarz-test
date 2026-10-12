CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_fact_transport_cost_pallet_2 (
inbound_transport_plan_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='new - unique identifier (surrogate key) of the transport plan position'),
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
departure_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
destination_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
executing_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
logistic_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
transport_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"'),
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
pallet_type_cd STRING(20) NOT NULL
OPTIONS(description='A code for the pallet that indicates the storage occupation for transportation.'),
double_deck_fg BOOL
OPTIONS(description='indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space'),
segment_agmt_elem_sid BIGNUMERIC OPTIONS(description='Surrogate identifier for Agreement element'),
logistics_tariff_sid BIGNUMERIC OPTIONS(description='Surrogate identifier for Logistics Tariff'),
supplier_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
supplier_transport_val BIGNUMERIC(38,5)
OPTIONS(description='Amount of money, which is paid from Supplier_2 to Hauler for transport. Calculated Amout for palett, palett type, strorage_space_qty'),
hauler_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
hauler_transport_val BIGNUMERIC(38,5) OPTIONS(description='Calculated Amount for each route, for each vehicle'),
transport_commission_val BIGNUMERIC(38,5)
OPTIONS(description='Difference between supplier_2 transport value and hauler transport value.'),
storage_space_qty BIGNUMERIC(38,5) OPTIONS(description='Needed storage space.'),
weight_ton_meas BIGNUMERIC(38,5) OPTIONS(description='which weight does total amout of pallets have'),
distance_km_meas BIGNUMERIC(38,5) OPTIONS(description='Distance of route segment in km'),
std_pallet_qty BIGNUMERIC(38,5)
OPTIONS(description='Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.'),
case_cnt BIGNUMERIC NOT NULL OPTIONS(description='The total number of cases in this position.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (inbound_transport_plan_pos_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='This table decribes actual costs that were charged per pallet');