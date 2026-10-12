/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_CUSTOMS_CLEARANCE_REPORT_LINE_PER_DAY_PROCEDURE_1
   generated from Powerdesigner on Mittwoch, 14. Juni 2023 13:18:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_fact_customs_clearance_report_line_per_day_procedure_1 (
clearance_dt DATE NOT NULL
OPTIONS(description='The day represented as a calendar_1 date of the form YYYY-MM_1-DD. YYYY is the calendar_1 year, MM_1 (between 1 and 12) the calendar_1 month and DD the day of the calendar_1 month (between 1 and 31). '),
authority_country_location_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the political country.'),
consignor_party_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the consignor.'),
customs_declaration_type_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the type of the customs declaration'),
customs_procedure_cd STRING(50) NOT NULL OPTIONS(description='The unique code of the customs procedure of the item.'),
declaration_cnt BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Fact - additive - The count of declarations.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500) NOT NULL
OPTIONS(description='Contains the fully qualified names of the source tables from the relational model.'),
PRIMARY KEY (clearance_dt, authority_country_location_sid, consignor_party_sid, customs_procedure_cd,
 customs_declaration_type_cd) NOT ENFORCED
)
OPTIONS(description='Fact table - Analytical - Granulatity - by day & customs procedure - Aggregate - Special fact table with the count of declarations dependent on the customs procedure code of the items of a declaration. - Source - CDS Item_1 Report');