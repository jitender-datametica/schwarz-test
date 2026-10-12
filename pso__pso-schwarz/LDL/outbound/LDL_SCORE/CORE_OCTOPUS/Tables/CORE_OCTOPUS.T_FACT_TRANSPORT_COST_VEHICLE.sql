CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_fact_transport_cost_vehicle (
inbound_dispo_order_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the disposition.'),
cal_dt DATE NOT NULL
OPTIONS(description='Assigned date, in this case the last date where the good has to be delivered at the receiving warehouse'),
departure_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
destination_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
executing_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
pallet_exchange_fg BOOL NOT NULL
OPTIONS(description='A pallet exchange program is a collective agreement between pallet shippers and receivers that tries to ensure that each party maintains the same number of pallets. When loaded pallets are brought to a warehouse or another receiver, they are exchanged for an equal number of empty pallets.'),
logistic_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
transport_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"'),
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
equipment_type_cd STRING(20) OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'),
segment_agmt_elem_sid BIGNUMERIC OPTIONS(description='Surrogate identifier for Agreement element'),
logistics_tariff_sid BIGNUMERIC OPTIONS(description='Surrogate identifier for Logistics Tariff'),
supplier_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
supplier_price_per_vehicle_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Supplier for a transport . Calculated Amout for a full vehicle'),
supplier_price_per_pallet_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Supplier for a transport  Calculated Amout per EP Pallet'),
supplier_cost_vehicle_val BIGNUMERIC(38,5)
OPTIONS(description='Amount of money, which is paid from Supplier to Hauler for transport. Calculated Amout for a full vehicle'),
supplier_cost_pallet_val BIGNUMERIC(38,5)
OPTIONS(description='Amount of money, which is paid from Supplier to Hauler for transport. Calculated Amout  for total EP Pallet transported'),
hauler_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
hauler_price_per_vehicle_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Hauler for a transport . Calculated Amout for a full vehicle'),
hauler_price_per_pallet_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Hauler for a transport  Calculated Amout for EP Pallet'),
hauler_cost_vehicle_val BIGNUMERIC(38,5)
OPTIONS(description='Amount of money, which is paid from Hauler to a transport company for transport. Calculated Amout for a full vehicle'),
hauler_cost_pallet_val BIGNUMERIC(38,5)
OPTIONS(description='Amount of money, which is paid from Hauler to a transport company for transport. Calculated Amout for total EP Pallet transported'),
commission_cost_vehicle_val BIGNUMERIC(38,5)
OPTIONS(description='Difference between supplier transport price value and hauler transport cost value.. Calculated Amout for a full vehicle'),
commission_cost_pallet_val BIGNUMERIC(38,5)
OPTIONS(description='Difference between supplier transport cost value and hauler transport cost value.. Calculated Amout for total EP Pallet transported'),
weight_ton_meas BIGNUMERIC(38,5) OPTIONS(description='Which weight does total amout of pallets have'),
distance_km_meas BIGNUMERIC(38,5) OPTIONS(description='Distance of route segment in km'),
transport_capacity_qty BIGNUMERIC(38,5)
OPTIONS(description='The capacity of the transport vehicle, e.g. 1EP --> 1 transport capacity / 1DD --> 0.5 transport capacity'),
ep_pallet_double_deck_cnt BIGNUMERIC OPTIONS(description='Number of Double Deck EP Pallets.'),
ep_pallet_no_double_deck_cnt BIGNUMERIC OPTIONS(description='Number of No Double Deck EP Pallets.'),
dd_pallet_double_deck_cnt BIGNUMERIC OPTIONS(description='Number of Double Deck DD Pallets.'),
dd_pallet_no_double_deck_cnt BIGNUMERIC OPTIONS(description='Number of No Double Deck DD Pallets.'),
std_pallet_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Quantity of pallets, standardised as Euro pallet. For Example one DD pallet  is 0,5. Double deck factor does not have an impact.'),
storage_space_qty BIGNUMERIC(38,5) OPTIONS(description='Needed storage space.'),
vehicle_cnt BIGNUMERIC OPTIONS(description='Amount of vehicles which are used to deliver the goods'),
case_cnt BIGNUMERIC NOT NULL OPTIONS(description='The total number of cases in this position.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (inbound_dispo_order_sid, cal_dt, departure_site_sid, destination_site_sid) NOT ENFORCED
) OPTIONS(description='This table decribes actual costs that were charged per vehicle');