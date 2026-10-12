CREATE TABLE IF NOT EXISTS ldl_score_core.t_fact_delivery_performance_2 (
inbound_dispo_order_pos_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the disposition position.'),
dispo_week BIGNUMERIC OPTIONS(description='The dispo week.'),
order_dt DATE OPTIONS(description='A date when the order was placed'),
dispo_nr STRING(20)
OPTIONS(description='A numeric or alphanumeric value which identifies the disposition for the business.'),
dispo_descr STRING(100)
OPTIONS(description='The description of the disposition.  It contains temperature, last mile crossdock and destination country.'),
order_reference_nr STRING(250)
OPTIONS(description='14 digit number containing info about log-type (digits 1-2), main cross-dock (digits 3-5), delivery date at the cross-dock (digits 6-11) and receiving regional subsidiary (digits 12-14)'),
purchase_order_nr STRING(20) OPTIONS(description='Purchase order number of Wawi'),
route_descr STRING(250) OPTIONS(description='Description of the planned route'),
departure_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
destination_site_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the site.'),
supplier_sid BIGNUMERIC OPTIONS(description='The unique identifier of the delivering party, e.g. the supplier.'),
hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The hauler who runs the crossdock.'),
logistic_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the logistic, e.g. SaL (Sammelladung / Sammellogistik) and KoL (Komplettladung / Direktlogistik)'),
logistic_temp_cd STRING(20) NOT NULL OPTIONS(description='The code for the type of the temperature zone, e.g. TK, TL.'),
transport_service_type_cd STRING(20) NOT NULL
OPTIONS(description='The code for the type of the transport service, e.g. "Vorlauf" or "Zwischenlauf"'),
bus_country_cd STRING(2)
OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
product_sid BIGNUMERIC OPTIONS(description='The unique identifier of the product.'),
product_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier of the product variant.'),
prod_variant_nan_nr STRING(50) OPTIONS(description='National product number of product variant'),
pallet_type_cd STRING(20) OPTIONS(description='Pallet code of the fact row'),
double_deck_fg BOOL
OPTIONS(description='Indicates whether two pallet units can be placed on top of each other. if so, then 2 order units with pallet storage space factor = 1 occupy one storage space'),
storage_space_qty BIGNUMERIC(38,5) OPTIONS(description='Needed storage space.'),
pallet_cnt BIGNUMERIC OPTIONS(description='The total number of pallets that have been ordered.'),
total_order_pallet_cnt BIGNUMERIC(38,5) OPTIONS(description='Total quantity of pallets per dispo order reference '),
missing_pallet_cnt BIGNUMERIC OPTIONS(description='Quantity of pallets which were not delivered'),
total_order_missing_pallet_cnt BIGNUMERIC(38,5)
OPTIONS(description='Total quantity of missing pallets per dispo order reference '),
equipment_type_cd STRING(20) OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'),
distance_km_meas BIGNUMERIC(38,5) OPTIONS(description='Distance of route segment in km'),
agmt_co2_emission_kg_meas BIGNUMERIC(38,5) OPTIONS(description='Emission amount  of Carbon Dioxide in Kg'),
supplier_price_validity_period_from_tmsp TIMESTAMP
OPTIONS(description='Validity_2 start of brutto price'),
supplier_price_validity_period_to_tmsp TIMESTAMP
OPTIONS(description='Validity_2 End of brutto price'),
supplier_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
supplier_price_per_vehicle_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Supplier_2 for a transport . Calculated Amout for a full vehicle'),
supplier_price_per_pallet_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Supplier_2 for a transport  Calculated Amout per EP Pallet'),
hauler_curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
hauler_price_validity_period_from_tmsp TIMESTAMP
OPTIONS(description='Validity_2 start of netto price'),
hauler_price_validity_period_to_tmsp TIMESTAMP OPTIONS(description='Validity_2 start of netto price'),
hauler_price_per_vehicle_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Hauler for a transport . Calculated Amout for a full vehicle'),
hauler_price_per_pallet_val BIGNUMERIC(38,5)
OPTIONS(description='Price asked by Hauler for a transport  Calculated Amout for EP Pallet'),
hauler_delivery_reference_nr STRING(20) OPTIONS(description='Delivery reference in hauler system'),
inbound_logistics_partner_name STRING(100) OPTIONS(description='A name of hauler transporting goods'),
logistics_partner_name STRING(100) OPTIONS(description='A name of hauler transporting goods'),
delivered_pallet_cnt BIGNUMERIC OPTIONS(description='Quantity of delivered pallets according to hauler'),
ontime_pallet_cnt BIGNUMERIC OPTIONS(description='Quantity of delivered pallets on time'),
hauler_missing_pallet_cnt BIGNUMERIC
OPTIONS(description='Quantity of pallets which were not delivered according to hauler'),
tgt_departure_dt DATE OPTIONS(description='Target departure date to destination'),
tgt_delivery_dt DATE OPTIONS(description='Target deliivery date  to destination'),
dept_departure_tmsp TIMESTAMP
OPTIONS(description='The time when the truck leaves the  departure premises after all tasks (unloading, paperwork, etc.) are finished.'),
dest_arrival_tmsp TIMESTAMP
OPTIONS(description='The exact time a truck (LKW) arrives at the destination premises delivering the goods from the previous location_2'),
dest_punctuality_cd STRING(20)
OPTIONS(description='Destination Punctuality defining if delivery to RDC  is late or on time'),
dest_punctuality_pct BIGNUMERIC(38,5)
OPTIONS(description='Destination Punctuality defining if delivery to RDC  is late or on time on order level'),
dest_order_punctuality_pct STRING(20) OPTIONS(description='Destination (RDC or XDOCK) punctuality percentage'),
rdc_delivery_dt DATE OPTIONS(description='Date of delivery to regional distribution center'),
rdc_punctuality_cd STRING(20) OPTIONS(description='RDC Punctuality defining if delivery to RDC  is late or on time'),
rdc_punctuality_pct STRING(20)
OPTIONS(description='RDC Punctuality percentage defining if delivery to RDC  is late or on time'),
delivery_progress_pct BIGNUMERIC(38,5) OPTIONS(description='A percentage of delivery'),
last_mile_punctuality_cd STRING(20) OPTIONS(description='Last Punctuality defining if delivery is late or on time'),
ready_for_collection_dt DATE
OPTIONS(description='This time when the carrier or a responsible party was notified that the goods were available to be collected.'),
latest_delivery_dt DATE OPTIONS(description='The planned reception time at ELM.'),
latest_loading_release_dt DATE
OPTIONS(description='The last possible time a truck can arrive and pick up goods to ensure they arrive on time. This is a target timestamp that\'s either set by the carrier or is a predefined timestamp.'),
advised_for_collection_dt DATE
OPTIONS(description='The initial planned timestamp for goods collection, as set by the hauler. This represents the first scheduled date and time for pickup.'),
collected_dt DATE OPTIONS(description='The actual time the goods are picked up.'),
unloaded_at_wh_dt DATE OPTIONS(description='The time the truck driver states they were at the warehouse.'),
order_availability_status_cd STRING(20) OPTIONS(description='Is order available for pick up'),
order_availability_punctuality_cd STRING(20) OPTIONS(description='Is pickup scheduled on time'),
pickup_notification_status_cd STRING(20) OPTIONS(description='Pickup Notification status_2'),
pickup_punctuality_cd STRING(20) OPTIONS(description='Pickup Punctuality status_2 code'),
hauler_delivery_punctuality_cd STRING(20) OPTIONS(description='Hauler delivery punctuality code'),
delivery_punctuality_cd STRING(20) OPTIONS(description='Delivery punctuality code'),
preparation_punctuality_status_cd STRING(20) OPTIONS(description='Delivery punctuality status_2'),
preparation_punctuality_pct BIGNUMERIC(38,5) OPTIONS(description='Delivery punctuality percentage'),
is_empty_stock_fg BOOL OPTIONS(description='Is empty stock'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (inbound_dispo_order_pos_sid, departure_site_sid, hauler_sid, logistic_type_cd, logistic_temp_cd)
NOT ENFORCED
)
OPTIONS(description='This table is a detailed transaction-level fact table designed to measure the end-to-end performance and accuracy of the Direct Collective Logistics (Direkt Sammellogistik) and Cross-Dock (X-Dock) process.');