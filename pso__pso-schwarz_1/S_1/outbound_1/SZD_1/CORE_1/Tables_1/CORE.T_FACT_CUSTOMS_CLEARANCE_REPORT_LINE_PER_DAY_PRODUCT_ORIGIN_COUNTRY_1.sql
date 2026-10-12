/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_PRODUCT_ORIGIN_COUNTRY_1
   generated from Powerdesigner on Dienstag, 1. August 2023 12:14:33
*/ --------------------------------------------------------------------------------


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS szd_core.t_fact_customs_clearance_report_line_per_day_product_origin_country_1 (
clearance_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
origin_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
customs_product_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the customs product.'),
customs_preference_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure code.'),
agreement_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the free trade agreement.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the type of the customs declaration'),
curr_cd STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='The currency code for the duty paid amount.'),
declaration_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fact - additive - The count of declatations.'),
duty_paid_val BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The amount of duty that was paid.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the fully qualified names of the source tables from the relational model.'),
PRIMARY KEY (clearance_dt, authority_country_location_sid, consignor_party_sid, origin_country_location_sid,
 customs_product_sid, customs_preference_cd, agreement_sid, customs_declaration_type_cd) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by day & customs product & origin country_1 & preference code - Aggregate - Special fact table with the count of declarations and sum of total duty paid dependent on the customs product, the origin country_1 and preference code of the items of a declaration. - Source - CDS Item_1 Report');