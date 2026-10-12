/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CUSTOMS_CLEARANCE_REPORT_PER_DAY_1
   generated from Powerdesigner on Dienstag, 1. August 2023 12:06:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_customs_clearance_report_per_day_1 (
clearance_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country_1 of the customs authority.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
declarant_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the declarant.'),
import_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the transhipment location.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the type of the customs declaration'),
dispatch_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the country_1 that dispatched the good.'),
transport_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the political country_1 that has made the transport of the goods.'),
curr_cd STRING(3) NOT NULL OPTIONS(description='The currency code for the duty paid amount and the excise value.'),
declaration_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fact - additive - The count of declarations.'),
duty_paid_val BIGNUMERIC(38,5) NOT NULL OPTIONS(description='Fact - additive - The amount of duty that was paid.'),
excise_val BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Fact - additive - The total amount of paid excise per declaration.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the fully qualified names of the source tables from the relational model.'),
PRIMARY KEY (clearance_dt, authority_country_location_sid, consignor_party_sid, declarant_party_sid, import_location_sid
 , customs_declaration_type_cd, dispatch_country_location_sid, transport_country_location_sid, curr_cd) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granularity - by day & authority country_1 & consignor stream & declarant & procedure - Aggregate - Containts declaration related facts from the item_1 report from the customs authority. - Source - CDS Header Report, CDS Item_1 Report');