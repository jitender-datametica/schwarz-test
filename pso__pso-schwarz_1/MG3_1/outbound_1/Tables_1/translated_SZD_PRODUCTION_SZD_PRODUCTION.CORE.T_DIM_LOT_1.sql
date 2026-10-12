CREATE OR REPLACE TABLE szd_production_core.t_dim_lot_1 (
product_instance_group_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
lot_nr STRING(50) NOT NULL OPTIONS(description='Natural Key/Business Key - The number which identifies the lot.'),
booked_lpod_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the last port of destination that will be used'),
booked_fpol_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the actual booked first port of loading'),
nominated_lpod_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the last port of discharge VMT Software has recommended in the prenomination process'),
nominated_fpol_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the first port of loading VMT Software has recommended in the prenomination process'),
booked_hauler_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the carrier acutally shipping the lot'),
nominated_hauler_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the carrier VMT Software has recommended in the prenomination process'),
destination_external_warehouse_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for for the Destination / Target  Import Warehouse'),
origin_handling_agent_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the original handling agent'),
destination_handling_agent_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the destination Handling Agent'),
booker_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party that performs the booking of the sea passage for a lot'),
vendor_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the vendor'),
producer_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the producer'),
supplier_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the supplier_1'),
qci_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the qcc institute'),
departure_vessel_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the name of the vessel that will arrive (for example after transshipments) at the destination port.'),
arrival_vessel_resource_item_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the first oversea vessel'),
destination_custom_agent_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the destination custom agent '),
product_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
lot_status_cd STRING(50) NOT NULL OPTIONS(description='The status_1 code for the lot'),
booked_final_destination_cd STRING(50) NOT NULL
OPTIONS(description='Location_1 to where the shipment was booked to. Might be oversea port Rotterdam or inland terminal Moerdijk for example, NLRTM or\tUSORF (Combination of country_1 code and port short name)'),
target_delivery_week_start_dt DATE
OPTIONS(description='Contractual  week where goods need to arrive in the country_1 distribution center'),
last_warehouse_arrive_week_start_dt DATE
OPTIONS(description='LDD - Calendar_1 week when the goods need to arrive at the inbound warehouse at the latest'),
target_owim_delivery_week_start_dt DATE
OPTIONS(description='Calendar_1 week when the goods need to arrive at the OWIM warehouse'),
origin_country_name STRING(100) NOT NULL
OPTIONS(description='The name of the country_1 of origin. Not the official country_1 name.'),
booked_etd_dt DATE OPTIONS(description='The ETD which was valid at the time the booking took place'),
booked_eta_dt DATE OPTIONS(description='The ETA which was valid at the time the booking took place'),
latest_estimated_arrival_dt DATE
OPTIONS(description='Date of estimated time of arrival at port of discharge for lot milestone\"eta_in_lot\"'),
in_longstay_terminal_fg BOOL
OPTIONS(description='Inicator if the containers of a lot have been relocated to a longstay terminal'),
closed_fg BOOL NOT NULL
OPTIONS(description='A lot can be closed if the goods are decided to be sent via plane instead for example or the shipment gets stolen, ship accident etc'),
dangerous_good_fg BOOL NOT NULL OPTIONS(description='Information if a goods is shipped a dangerous goods'),
consumable_lot_fg BOOL NOT NULL
OPTIONS(description='Indicates if lont contains conusmables  - special articles with longer article numbers (9 digits)'),
sent_to_inspection_center_fg BOOL NOT NULL
OPTIONS(description='Inspection center flag, if true, goods are sent to an inspection center'),
customs_clearance_country_pol_cd STRING(3) NOT NULL
OPTIONS(description='The code identifying  for the country_1 of customs clearance'),
customs_clearance_city_name STRING(100)
OPTIONS(description='Descriptive attribute - The city where customs check is done'),
dangerous_good_type_cd STRING(50) NOT NULL
OPTIONS(description='The classification of transported good as Dangerous Goods (SDB (Gefahrgut), Kein SDB )'),
book_refer_nr STRING(50)
OPTIONS(description='Descriptive Attribute - A name/primary key of a booking, stays equal over different systems '),
bill_of_lading_nr_txt STRING(1000) OPTIONS(description='Descriptive Attribute - Official loading document title'),
product_batch_nr STRING(50) NOT NULL OPTIONS(description='Descriptive Attribute - Relevant selection of the article'),
lot_transport_status_cd STRING(50) NOT NULL
OPTIONS(description='Status_1 of lot transport name (e.g. could be also delayed)'),
container_packing_place_cd STRING(50) NOT NULL
OPTIONS(description='Information where the container stuffing is taken place '),
lot_process_mode_cd STRING(50) NOT NULL
OPTIONS(description='Processing mode defines who handles the unloading and the transport to the country_1 distribution center. '),
domestic_transport_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse'),
domestic_transport_route_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse'),
domestic_wholesale_label_descr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - Description text for the type of transportation after import into a country_1'),
international_transport_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse'),
international_transport_route_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse'),
international_wholesale_label_descr STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - Description text for the type of transportation before import into a country_1'),
consignee_name STRING(100)
OPTIONS(description='Descriptive Attribute - Recipient of a shipment /owner of shipped goods'),
inland_terminal_name STRING(100)
OPTIONS(description='Descriptive Attribute - Name of the inland terminal ( inland intermodal terminal directly connected by road or rail to a seaport, operating as a centre for the transshipment of sea cargo to inland destinations)'),
predecessor_product_ian_nr STRING(50)
OPTIONS(description='Descriptive Attribute - Predecessor article of the current article'),
order_nr_txt STRING(1000) OPTIONS(description='Descriptive Attribute - SAP Order number'),
nominated_total_carton_qty NUMERIC(29,5)
OPTIONS(description='Fact - additive - Ordered amount of cartons as stated in the contract'),
booked_total_carton_qty NUMERIC(29,5)
OPTIONS(description='Fact - additive - Amount of cartons that were actually produced are be considered in booking'),
nominated_teu_meas NUMERIC(29,5)
OPTIONS(description='Measure - The nomination defines, how many TEU are expected for shipping the article (estimation)'),
booked_teu_meas NUMERIC(29,5) OPTIONS(description='Measure - Actually booked TEU (usually similar/same to shipped TEU)'),
shipped_teu_meas NUMERIC(29,5) OPTIONS(description='Measure - Actually shipped TEU'),
consolidated_lot_nr_txt STRING(1000) OPTIONS(description='Derived field : All lots that are consolidated with this one'),
shipping_destination_cnt INTEGER OPTIONS(description='Derived field : Count of destination present in the same lot'),
destination_customs_agent_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - Name of the customs handling agent at the destination'),
supplier_name STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - Name of the supplier_1'),
producer_name STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - Name of the producer'),
vendor_name STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - Name of the vendor'),
booker_name STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - Name of the booker'),
destination_handling_agent_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - Name of the handling agent at the destination'),
origin_handling_agent_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - Name of the handling agent at the origin'),
destination_warehouse_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - Name of the warehouse at the destination'),
nominated_hauler_name STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - Name of the nominated hauler'),
booked_hauler_name STRING(100) NOT NULL OPTIONS(description='Denormalized Attribute - Name of the booked hauler'),
departure_vessel_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - Name of the vessel the lot departes from origin'),
arrival_vessel_name STRING(100) NOT NULL
OPTIONS(description='Denormalized Attribute - Name of the vessel the lot arrives at destination'),
nominated_fpol_short_name_business_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - Country_1 code and Name of the nominated first port of loading'),
nominated_lpod_short_name_business_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - Country_1 code and Name of the nominated last port of discharge'),
booked_fpol_short_name_business_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - Country_1 code and  Name of the booked first port of loading'),
booked_lpod_short_name_business_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - Country_1 code and Name of the booked last port of discharge'),
original_departing_vessel_resource_item_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the vessel'),
original_arriving_vessel_resource_item_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the vessel'),
actual_departing_vessel_resource_item_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the vessel'),
actual_arriving_vessel_resource_item_sid INTEGER NOT NULL
OPTIONS(description='Denormalized Attribute - The unique identifier (surrogate key) for the vessel'),
originally_confirmed_etd_tmsp TIMESTAMP
OPTIONS(description='Denormalized Attribute - The timestamp that was originally confirmed as the estimated time of departure (etd )'),
originally_confirmed_eta_tmsp TIMESTAMP
OPTIONS(description='Denormalized Attribute - The timestamp that was originally confirmed as the estimated time of arrival (eta )'),
shipped_atd_tmsp TIMESTAMP
OPTIONS(description='Denormalized Attribute - The timestamp the shipment was actually shipped on ( atd )'),
shipped_eta_tmsp TIMESTAMP
OPTIONS(description='Denormalized Attribute - The timestamp the shipment is estimated to arrive ( eta )'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (product_instance_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Dimension - A lot is defined as the amount of shipped cartons per IAN+batch in the same shipment. There can be several lots on the same vessel . shipment in VMT is a lot (containers shipped in the same booking process). - Source - VMT');