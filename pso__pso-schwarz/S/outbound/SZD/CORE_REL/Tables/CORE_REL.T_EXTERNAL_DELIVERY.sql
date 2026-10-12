/* --------------------------------------------------------------------------------
   DDL for table: T_EXTERNAL_DELIVERY
   generated from Powerdesigner on Freitag, 9. Mai 2025 14:50:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_external_delivery (
delivery_nr STRING(250) NOT NULL OPTIONS(description='Business/Natural key - The business identifier of the delivery.'),
event_dt DATE NOT NULL OPTIONS(description='The date when the entry is found in the source.'),
client_party_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the party.'),
hauler_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the hauler party'),
carrying_hauler_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the company carrying the goods to the target.'),
recipient_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the party.'),
creditor_supplier_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the supplier/creditor party'),
supplier_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the supplier party'),
target_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the location.'),
loading_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country the goods are loaded.'),
import_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country where the goods are imported.'),
actual_goods_movement_dt DATE OPTIONS(description='The actual date of the movement of the goods.'),
planned_goods_movement_dt DATE OPTIONS(description='The planned date of the movement of the goods.'),
picking_dt DATE OPTIONS(description='The date when the goods are picked.'),
loading_dt DATE OPTIONS(description='The date when the goods was loaded before they are transported.'),
transport_dt DATE OPTIONS(description='The date when the transport of the goods has started.'),
actual_delivery_dt DATE OPTIONS(description='The date when the goods are delivered.'),
planned_delivery_dt DATE OPTIONS(description='The date when the goods are planned to delivered.'),
receipt_dt DATE OPTIONS(description='The date when the goods are received by the receipient.'),
invoice_dt DATE OPTIONS(description='The date on the invoice.'),
invoice_curr_cd STRING(50) NOT NULL OPTIONS(description='The currency of the the invoice.'),
lidl_delivery_week_dt DATE
OPTIONS(description='A day in the week the delivery is supposed to happen ( usually a monday, wednesday or thursday )'),
lidl_delivery_week_fixed_fg BOOL OPTIONS(description='Flag indicating if the delivery week is fixed'),
earliest_advertising_dt DATE OPTIONS(description='Earliest advertising date.'),
total_weight_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The total weight of the goods including packaging, etc.'),
total_weight_unit_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unit of measure the total weight is measured in.'),
net_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The net weight of the goods'),
net_weight_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unit of measure the net weight is measured in.'),
volume_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - The volume in space the goods take up.'),
volume_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unit of measure the volume is measured in.'),
package_cnt BIGNUMERIC(38,0) OPTIONS(description='Fact - additive - The count of packages.'),
sending_location_timezone_txt STRING(1000)
OPTIONS(description='Descriptive attribute - supposed to contain the timezone information of the location that sends goods somewhere - Source - LExIS'),
recieving_location_timezone_txt STRING(1000)
OPTIONS(description='Descriptive attribute - supposed to contain the timezone information of the location that recieves goods from somewhere - Source - LExIS'),
packing_instruction_nr STRING(250) OPTIONS(description='The business identifier of the package instructions.'),
packing_space_max_cnt BIGNUMERIC(38,0) OPTIONS(description='Fact - additive - Count of maximal parking spaces.'),
packing_space_total_cnt BIGNUMERIC(38,0) OPTIONS(description='Fact - additive - Count of total parking spaces.'),
packing_space_leftover_cnt BIGNUMERIC(38,0) OPTIONS(description='Fact - additive - Count of leftover parking spaces.'),
gross_weight_max_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - Maximum gross weight.'),
gross_weight_total_meas BIGNUMERIC(38,5)
OPTIONS(description='Fact - additive - The difference between maximum gross weight and leftover gross weight.'),
gross_weight_leftover_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - Leftover gross weight.'),
load_length_max_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - Total load length in meter.'),
load_length_total_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - Total load length in meter.'),
load_length_leftover_meas BIGNUMERIC(38,5) OPTIONS(description='Fact - additive - Leftover load length in meter.'),
monitoring_release_fg BOOL OPTIONS(description='Released for monitoring the advertisement.'),
delivery_note_nr STRING(50) OPTIONS(description='Descriptive Attribute - External delivery note number.'),
chargeback_min_dt DATE OPTIONS(description='Descriptive Attribute - Minimum date of charge back.'),
internal_delivery_uuid_nr STRING(100)
OPTIONS(description='Descriptive Attribute - Internal UUID representing the delivery.'),
document_category_cd STRING(50)
OPTIONS(description='Descriptive Attribute - Document category (e.g. delivery, return, stock transfer, etc.). Determines the type of logistics document.'),
transport_identification_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The transport identification number.'),
idoc_nr STRING(250) OPTIONS(description='Descriptive Attribute - Number of the IDoc.'),
detention_time_day_cnt BIGNUMERIC(38,0)
OPTIONS(description='Descriptive Attribute - Detention time for the container until a fee is charged.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (delivery_nr, event_dt) NOT ENFORCED
)
OPTIONS(description='Entity - Transactional - Transaction - shows the main common attributes of a delivery of goods from a supplier to a recipient/client via a carrier to an address. - Source - LExIS');