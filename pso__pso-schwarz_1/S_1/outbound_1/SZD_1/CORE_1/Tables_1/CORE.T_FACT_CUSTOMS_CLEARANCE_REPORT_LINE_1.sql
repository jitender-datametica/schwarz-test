/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_1
   generated from Powerdesigner on Dienstag, 4. Februar 2025 14:27:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_customs_clearance_report_line_1 (
movement_ref_number STRING(250) NOT NULL
OPTIONS(description='The movement reference number that identifies a declaration.'),
trader_reference STRING(250) NOT NULL
OPTIONS(description='Descriptive attribute - This is a reference assigned by the declarant for the goods covered by the declaration.'),
item_position BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The position number within the shipment/declaration. '),
clearance_dt DATE NOT NULL OPTIONS(description='The clearance date of the declaration.'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The month identifier of the clearance date.'),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country_1 of the customs authority.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
importer_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the importer.'),
importer_number STRING(250) NOT NULL OPTIONS(description='The business identifier of the importer.'),
declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the declarant'),
acceptance_dt DATE NOT NULL OPTIONS(description='Denormalized Attribute - The date of acceptance.'),
declarant_number STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - The business identifier of the declarant.'),
declarant_name STRING(100) OPTIONS(description='Denormalized Attribute - The name of the declarant.'),
declarant_authorized_fg BOOL NOT NULL
OPTIONS(description='Denormalized Attribute - Flag indicating whether the declarant is authorized.'),
customs_declaration_type_cd STRING(50) OPTIONS(description='The unique code of the type of the customs declaration'),
customs_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure.'),
customs_preference_cd STRING(50) OPTIONS(description='The unique code of the customs procedure code.'),
origin_country_location_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
origin_iso_country_cd STRING(50) NOT NULL
OPTIONS(description='Denormalized Attribute - The ISO code of the origin country.'),
customs_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the customs product.'),
customs_tariff_number_cd STRING(50)
OPTIONS(description='Denormalized Attribute - The customs tariff number from the customs product.'),
customs_product_number STRING(250) NOT NULL
OPTIONS(description='Denormalized Attribute - The product number including the additional code for the customs product.'),
article_variant_nr STRING(250)
OPTIONS(description='Descriptive Attribute - The arbitrary article variant number of a product from the GTS system.'),
goods_descr STRING(250) OPTIONS(description='Denormalized Attribute - The name of the customs product.'),
curr_cd STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='The currency code for the duty paid amount, the VAT paid amount and the customs value.'),
vat_paid_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The total amount of VAT paid on the item.'),
duty_paid_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The total amount of duty paid on the item.'),
net_weight_meas BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The net weight measure of the item.'),
customs_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The total value of the item_1 for the purposes of customs duty. In addition to the actual price of the goods this includes additional elements such as Freight Charges to the EU boundary. '),
preference_indicator_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - A list of documents that are used to determine the preference.'),
allocation_cnt BIGNUMERIC(38,0) OPTIONS(description='Fact - additive - The count of items in a package.'),
package_cnt BIGNUMERIC(38,0) OPTIONS(description='Fact - additive - The count of packages.'),
item_cnt BIGNUMERIC(38,0)
OPTIONS(description='Fact - additive - The count of items (allocation count times package_1 count).'),
batch_nr_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - A list of batch numbers the product is part of (only for products from WWT).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (movement_ref_number, trader_reference, item_position) NOT ENFORCED
)
OPTIONS(description='Fact table - Transactional Events - Periodic Snapshot_1 - This table contains information about the declarations and their items settled up by the customs authority. - Source - CDS Header Report, CDS Item_1 Report');