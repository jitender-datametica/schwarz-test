CREATE OR REPLACE TABLE szd_production_core.t_fact_broker_report_line_per_day_1 (
cds_acceptance_dt DATE NOT NULL
OPTIONS(description='This is the date when the goods have arrived at the import location.'),
authority_country_location_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country_1 of the customs authority.'),
broker_declarant_party_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the broker declarant.'),
consignor_party_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the type of the customs declaration'),
customs_product_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the customs product.'),
customs_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure.'),
total_line_cnt INTEGER NOT NULL OPTIONS(description='Fact - additive - The total number of lines in the broker report.'),
alcoholic_line_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - The count of lines containing alcoholic beverage products in the broker report.'),
non_alcoholic_line_cnt INTEGER NOT NULL
OPTIONS(description='Fact - additive - The count of lines containing non-alcoholic beverage products in the broker report.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (cds_acceptance_dt, authority_country_location_sid, broker_declarant_party_sid, consignor_party_sid,
 customs_declaration_type_cd, customs_product_sid, customs_procedure_cd) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by day and product and customs procedure code and declaration category - Aggregate - Contains facts regarding the lines in a broker report. - Source - Broker Report');