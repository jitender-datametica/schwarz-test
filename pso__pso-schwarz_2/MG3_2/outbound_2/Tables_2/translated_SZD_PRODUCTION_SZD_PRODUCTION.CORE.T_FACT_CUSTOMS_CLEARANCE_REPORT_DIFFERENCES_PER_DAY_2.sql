CREATE OR REPLACE TABLE szd_production_core.t_fact_customs_clearance_report_differences_per_day_2 (
authority_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the authority country.'),
report_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). '),
broker_declarant_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the declarant.'),
consignor_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
original_consignor_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the original consignor in BEI or WWT report.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique code of the type of the customs declaration'),
trader_reference_nr STRING(250) NOT NULL
OPTIONS(description='This is a reference assigned by the declarant for the goods covered by the declaration.'),
customs_product_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the customs product.'),
customs_product_nr STRING(250) NOT NULL
OPTIONS(description='The product number of the customs product (can be a IAN or a single article item_2 number from GTS).'),
customs_product_descr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - The description of the product.'),
article_variant_nr_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - Comma separated list of article variant numbers (only for products from GTS).'),
movement_ref_number_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - Comma separated list of all movement reference numbers for this trader reference.'),
item_position_txt STRING(1000) NOT NULL
OPTIONS(description='Descriptive Attribute - Comma separated list of the item_2 position numbers in the broker report for the trader reference and customs product.'),
broker_line_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - Count of lines in the broker report.'),
consignor_line_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - Count of lines in BEI/WWT report.'),
correct_line_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of lines in broker report with no differences at all.'),
invalid_consignor_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of invalid consignors (A consignor is considered as invalid if he is EXTERNAL).'),
invalid_importer_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - Count of invalid importers.'),
broker_trader_reference_missing_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of missing products because of missing trader reference in broker report.'),
consignor_trader_reference_missing_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of missing products because of missing trader reference in consignor report.'),
broker_product_missing_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of missing products because of missing product number within a trader reference in broker report.'),
consignor_product_missing_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of missing products because of missing product number within a trader reference in consignor report.'),
different_commodity_code_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of products with different commodity code between BEI/WWT and broker report.'),
broker_commodity_code_nr STRING(250) OPTIONS(description='Descriptive Attribute - Commodity code from broker report.'),
consignor_commodity_code_nr STRING(250)
OPTIONS(description='Descriptive Attribute - Commodity code from BEI/WWT report.'),
different_country_of_origin_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of products with different country_2 of origin between BEI/WWT and broker report.'),
broker_origin_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the origin country_2 of the broker.'),
broker_country_of_origin_cd STRING(50)
OPTIONS(description='Descriptive Attribute - Country_2 of origin from broker report.'),
consignor_origin_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the origin country_2 of the consignor.'),
consignor_country_of_origin_cd STRING(50)
OPTIONS(description='Descriptive Attribute - Country_2 of origin from consignor report.'),
different_net_mass_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of products with different net mass between BEI/WWT and broker report.'),
cds_net_mass_meas NUMERIC(29,5) OPTIONS(description='Fact - additive - Net mass measure from the CDS report.'),
consignor_net_mass_meas NUMERIC(29,5) OPTIONS(description='Fact - additive - Net mass measure from the BEI/WWT report.'),
different_invoice_amount_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of products with different invoice amount between BEI/WWT and broker report.'),
cds_invoice_amount_val NUMERIC(29,5) OPTIONS(description='Fact - additive - Invoice amount from the CDS report.'),
consignor_invoice_amount_val NUMERIC(29,5)
OPTIONS(description='Fact - additive - Invoice amount from the BEI/WWT report.'),
different_invoice_curr_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of products with different invoice currency between BEI/WWT and broker report.'),
cds_invoice_curr_cd STRING(50) OPTIONS(description='Descriptive Attribute - Currency code from CDS item_2 report.'),
consignor_invoice_curr_cd STRING(50) OPTIONS(description='Descriptive Attribute - Currency code from BEI/WWT report.'),
missing_document_codes_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of products with missing document codes in CDS report.'),
cds_document_codes_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - List of document codes from CDS report.'),
consignor_document_codes_txt STRING(1000)
OPTIONS(description='Descriptive Attribute - List of document codes from BEI.'),
missing_document_codes_txt STRING(1000) OPTIONS(description='Descriptive Attribute - List of missing document codes.'),
invalid_incoterm_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - Count of invalid incoterms (must always be DAP).'),
incoterm_cd STRING(50) OPTIONS(description='Descriptive Attribute - The code of the incoterm.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (trader_reference_nr, authority_country_location_sid, broker_declarant_party_sid, consignor_party_sid,
 customs_declaration_type_cd, report_dt, customs_product_sid) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by day, trader reference and product number - Aggregate - Contains facts about the differences of informationen between the BEI/WWT data and the broker/CDS data. - Source - Broker Report, BEI/WWT, CDS');