/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_EXCISE_ANALYSIS_PER_DAY_1
   generated from Powerdesigner on Dienstag, 10. Oktober 2023 12:48:08
*/ --------------------------------------------------------------------------------


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS szd_core.t_fact_excise_analysis_per_day_1 (
trader_reference_nr STRING(250) NOT NULL
OPTIONS(description='This is a reference assigned by the declarant for the goods covered by the declaration.'),
customs_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the customs product.'),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
report_dt DATE NOT NULL
OPTIONS(description='This is the date when the goods have arrived at the import location_1 (from Broker Report) or the goods was ordered (from Consignor)..'),
broker_declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the broker declarant.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the consignor as defined in the consignor reports (BEI/WWT).'),
broker_consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the consignor as defined in the broker report.'),
cds_consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the consignor as defined in the CDS report.'),
original_consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the original consignor in BEI or WWT report.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the type of the customs declaration'),
customs_preference_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs preference.'),
curr_cd STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='The code identifying the currency according to ISO-4217.'),
movement_ref_number_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - Comma separated list of all movement reference numbers for this trader reference.'),
item_position_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - Comma separated list of the item_1 position numbers in the broker report for the trader reference and customs product.'),
article_variant_nr_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - The article variant number for a GTS product.'),
broker_line_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines in the broker report.'),
broker_line_missing_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines that are missed in the broker report, because there was no match found for the corresponding conisgnor report lines..'),
consignor_line_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines in the consignor report.'),
consignor_line_missing_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines that are missed in the consignor report, because there was no match found for the corresponding broker report lines..'),
broker_tax_cd STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The alcoholic beverage tax code the broker used to calculate the excise duty.'),
consignor_tax_cd STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The alcoholic beverage tax code the consignor used to calculate the excise duty.'),
different_tax_code_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines where the tax code is different between the consignor and broker report.'),
broker_excise_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The quantity (in liter or liter of pure alcohol depending on the alcoholic beverage type) declared by the broker.'),
consignor_excise_qty BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The quantity (in liter or liter of pure alcohol depending on the alcoholic beverage type) calculated by the consignor.'),
different_excise_quantity_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines where the calculated quantity of the consignor is different to the declared quantity of the broker.'),
broker_excise_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The amount of excise duty declared by the broker and paid by the consignor.'),
consignor_excise_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The amount of excise duty calculated by the consignor.'),
overpaid_excise_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The amount of overpaid excise duty as the positive difference between the paid excise duty and the calculated excise duty '),
underpaid_excise_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The amount of underpaid excise duty as the negative difference between the paid excise duty and the calculated excise duty '),
different_excise_amount_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines where the calculated excise duty of the consignor is different to the declared excise duty of the broker.'),
correct_excise_amount_cnt BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fact - additive - The count of lines where the calculated excise duty of the consignor is equal to the declared excise duty of the broker.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (trader_reference_nr, customs_product_sid, authority_country_location_sid, report_dt,
 broker_declarant_party_sid, customs_declaration_type_cd, customs_preference_cd, consignor_party_sid,
 broker_consignor_party_sid, cds_consignor_party_sid, original_consignor_party_sid) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by day and trader reference and customs product - Aggregate - Contains facts to compare the Broker Report with the Consignor Report to determine differences in the paid excises on a level of trader references. - Source - Broker Report, GTS/WWT');