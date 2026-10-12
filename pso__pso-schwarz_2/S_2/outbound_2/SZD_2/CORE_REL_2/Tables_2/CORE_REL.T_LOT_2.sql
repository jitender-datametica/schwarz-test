/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_2
   generated from Powerdesigner on Donnerstag, 7. August 2025 09:48:18
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_lot_2 (
product_instance_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
nominated_fpol_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the first port of loading VMT Software has recommended in the prenomination process'),
booked_fpol_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the actual booked first port of loading'),
nominated_lpod_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the last port of discharge VMT Software has recommended in the prenomination process'),
booked_lpod_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the last port of destination that will be used'),
destination_external_warehouse_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique identifier for the Destination / Target  Import Warehouse'),
arrival_vessel_resource_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the first oversea vessel'),
departure_vessel_resource_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the name of the vessel that will arrive (for example after transshipments) at the destination port.'),
booked_hauler_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the carrier acutally shipping the lot'),
nominated_hauler_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the carrier VMT Software has recommended in the prenomination process'),
origin_handling_agent_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the original handling agent'),
destination_handling_agent_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the destination Handling Agent'),
destination_customs_agent_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the destination custom agent '),
booker_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party that performs the booking of the sea passage for a lot'),
vendor_party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the vendor'),
producer_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the producer'),
supplier_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the supplier_2'),
qci_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the qcc institute'),
product_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the product.'),
lot_nr STRING(50) NOT NULL OPTIONS(description='Natural/Business key - The number which identifies the lot.'),
lot_status_cd STRING(50) NOT NULL OPTIONS(description='The status_2 code for the lot'),
lot_transport_status_cd STRING(50) NOT NULL
OPTIONS(description='Status_2 of lot transport name (e.g. could be also delayed)'),
eu_lot_process_mode_cd STRING(50) NOT NULL
OPTIONS(description='Processing mode defines who handles the unloading and the transport to the country_2 distribution center. '),
booked_final_destination_cd STRING(50) NOT NULL
OPTIONS(description='Location_2 to where the shipment was booked to. Might be oversea port Rotterdam or inland terminal Moerdijk for example'),
international_transport_route_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the transport route type before import to a country.'),
international_transport_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique identifier of the transport mode before import to a country.'),
domestic_transport_route_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the transport route type  after import to a country..'),
domestic_transport_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique identifier of the transport mode after import to a country.'),
container_packing_place_cd STRING(50) NOT NULL
OPTIONS(description='Information where the container stuffing is taken place '),
dangerous_good_type_cd STRING(50) NOT NULL
OPTIONS(description='The classification of transported good as Dangerous Goods (SDB (Gefahrgut), Kein SDB )'),
predecessor_product_ian_nr STRING(50)
OPTIONS(description='Descriptive Attribute - Predecessor article of the current article'),
target_delivery_week_start_dt DATE
OPTIONS(description='Descriptive Attribute - Contractual  week where goods need to arrive in the country_2 distribution center'),
target_owim_delivery_week_start_dt DATE
OPTIONS(description='Descriptive Attribute - Calendar_2 week when the goods need to arrive at the OWIM warehouse'),
last_warehouse_arrive_week_start_dt DATE
OPTIONS(description='Descriptive Attribute - LDD - Calendar_2 week when the goods need to arrive at the inbound warehouse at the latest'),
booked_etd_dt DATE
OPTIONS(description='Descriptive Attribute - The ETD which was valid at the time the booking took place'),
booked_eta_dt DATE
OPTIONS(description='Descriptive Attribute - The ETA which was valid at the time the booking took place'),
in_longstay_terminal_fg BOOL
OPTIONS(description='Inicator if the containers of a lot have been relocated to a longstay terminal'),
closed_fg BOOL NOT NULL
OPTIONS(description='A lot can be closed if the goods are decided to be sent via plane instead for example or the shipment gets stolen, ship accident etc'),
consumable_lot_fg BOOL NOT NULL
OPTIONS(description='Indicates if lot contains consumables  - special articles with longer article numbers (9 digits)'),
dangerous_good_fg BOOL NOT NULL OPTIONS(description='Information if a goods is shipped a dangerous goods'),
sent_to_inspection_center_fg BOOL NOT NULL
OPTIONS(description='Inspection center flag, if true, goods are sent to an inspection center'),
consolidated_lot_nr_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - lot numbers of lots that are consolidated with this one'),
order_nr_txt STRING(1000) OPTIONS(description='Descriptive Attribute  - SAP Order number'),
inland_terminal_name STRING(100)
OPTIONS(description='Descriptive Attribute - Name of the inland terminal ( inland intermodal terminal directly connected by road or rail to a seaport, operating as a centre for the transshipment of sea cargo to inland destinations)'),
consignee_name STRING(100)
OPTIONS(description='Descriptive Attribute - Recipient of a shipment /owner of shipped goods'),
product_batch_nr STRING(50) NOT NULL OPTIONS(description='Relevant selection of the article'),
bill_of_lading_nr_txt STRING(1000) OPTIONS(description='Descriptive Attribute - Official loading document title'),
book_refer_nr STRING(50)
OPTIONS(description='Descriptive Attribute - A name/primary key of a booking, stays equal over different systems '),
customs_clearance_city_name STRING(100)
OPTIONS(description='Descriptive Attribute - The city where customs check is done'),
customs_clearance_country_pol_cd STRING(50)
OPTIONS(description='The code identifying  for the country_2 of customs clearance'),
origin_country_name STRING(100) NOT NULL
OPTIONS(description='Descriptive Attribute - The name of the country_2 of origin. Not the official countries name but an informal name'),
original_departing_vessel_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the original departing vessel'),
original_arriving_vessel_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the original arriving vessel'),
actual_departing_vessel_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the actual departing vessel'),
actual_arriving_vessel_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the actual arriving vessel'),
originally_confirmed_etd_tmsp TIMESTAMP
OPTIONS(description='The timestamp that was originally confirmed as the estimated time of departure (etd )'),
originally_confirmed_eta_tmsp TIMESTAMP
OPTIONS(description='The timestamp that was originally confirmed as the estimated time of arrival (eta )'),
shipped_atd_tmsp TIMESTAMP
OPTIONS(description='The timestamp the shipment was actually shipped on ( atd )'),
shipped_eta_tmsp TIMESTAMP
OPTIONS(description='The timestamp the shipment is estimated to arrive ( eta )'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (product_instance_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Major Entity - A lot is defined as the amount of shipped cartons per IAN+batch in the same shipment. There can be several lots on the same vessel . shipment in VMT is a lot (containers shipped in the same booking process) - Source - VMT');