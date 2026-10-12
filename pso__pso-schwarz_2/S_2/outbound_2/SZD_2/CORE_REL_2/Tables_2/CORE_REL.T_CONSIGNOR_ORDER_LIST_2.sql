/* --------------------------------------------------------------------------------
   DDL for table: T_CONSIGNOR_ORDER_LIST_2
   generated from Powerdesigner on Dienstag, 10. Oktober 2023 12:42:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_consignor_order_list_2 (
trader_reference_nr STRING(250) NOT NULL
OPTIONS(description='Natural Key/Business Key - This is a reference assigned by the declarant for the goods covered by the declaration.'),
order_dt DATE NOT NULL
OPTIONS(description='Natural Key/Business Key - The date when the goods were ordered by the consignor.'),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_2 of the customs authority.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
original_consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the original consignor.'),
carrier_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the carrier company.'),
consignee_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignee party.'),
export_warehouse_resource_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the export warehouse (only WWT).'),
departure_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the departure country_2 (only BEI).'),
customs_office_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the customs office.'),
invoice_finance_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the invoice (only WWT).'),
transport_type_cd STRING(50) NOT NULL OPTIONS(description='The unique identifier of the transport mode (only BEI).'),
transport_route_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the transport route type(only BEI).'),
transport_reference_nr STRING(250)
OPTIONS(description='Descriptive attribute - The transport reference is used to track the transport to the destination (only BEI).'),
dispo_week BIGNUMERIC(38,0) OPTIONS(description='Descriptive Attribute - The dispo week (only WWT).'),
roll_on_roll_off_fg BOOL OPTIONS(description='Flag indicating whether if this "Roll on Roll off" (only BEI)..'),
purchase_order_nr STRING(250)
OPTIONS(description='Descriptive attribute - The order number of a truck load (only BEI).'),
shipment_nr STRING(250)
OPTIONS(description='Descriptive attribute - The shipment number (only provided by OWIM in BEI)'),
port_of_arrival_txt STRING(1000)
OPTIONS(description='Descriptive attribute - The port where the goods will arrive (only BEI).'),
estimated_arrival_dt DATE
OPTIONS(description='Descriptive attribute - The date of the estimated departure of the goods (only BEI).'),
estimated_departure_dt DATE
OPTIONS(description='Descriptive attribute - The date of the estimated arrival of the goods at the destination (only BEI).'),
bill_of_leding_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The number of the bill of lading (only BEI).'),
packaging_list_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The reference number of the packing list (only BEI).'),
container_nr_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - The container number(s) where the goods are transported in (only BEI).'),
vessel_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the nationality of the vessel (only BEI)'),
vessel_name STRING(100) OPTIONS(description='Descriptive Attribute - The identifier/name of the vessel (only BEI)'),
ferry_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the nationality of the ferry (only BEI).'),
ferry_name STRING(100) OPTIONS(description='Descriptive Attribute - The identifier/name of the ferry (only BEI)'),
truck_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the nationality of the truck (only BEI).'),
truck_name STRING(100) OPTIONS(description='Descriptive Attribute - The identifier/name of the truck (only BEI)'),
trailer_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the nationality of the trailer (only BEI).'),
trailer_name STRING(100) OPTIONS(description='Descriptive Attribute - The identifier/name of the trailer (only BEI)'),
train_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the nationality of the train (only BEI).'),
train_name STRING(100) OPTIONS(description='Descriptive Attribute - The identifier/name of the train (only BEI)'),
loading_reference_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The loading reference number  (usually a combination of packaging list number and container number) (only BEI).'),
inbound_delivery_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The inbound delivery number identifies the way materials and other goods are brought into a company. (only BEI)'),
inbound_delivery_dt DATE
OPTIONS(description='Descriptive Attribute - The time that inbound delievry is created. (only BEI)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (trader_reference_nr, order_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - The consignor order list contains a list of orders for goods to be imported for specific consignees. This list serves as a basis for the broker to create the customs declaration and the broker\'s report. This order list contains all the information that the broker needs to calculate the expected duties. There are two sources (BEI and WWT) for this report which provide different data. The data structures do not follow any standard. Therefore it is necessary to model two separate entities for BEI and WWT respectively. - Source - BEI/WWT Report');