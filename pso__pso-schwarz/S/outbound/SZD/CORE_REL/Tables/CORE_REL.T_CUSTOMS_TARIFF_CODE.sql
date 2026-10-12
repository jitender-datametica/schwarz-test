/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_TARIFF_CODE
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:57:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_tariff_code (
customs_classification_scheme_cd STRING(50) NOT NULL
OPTIONS(description='The unique code of the customs classification scheme.'),
customs_tariff_code_cd STRING(250) NOT NULL OPTIONS(description='The standardized customs tariff code number.'),
customs_tariff_code_descr STRING(250)
OPTIONS(description='A brief description of what kind of goods this customs tariff code is describing.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_classification_scheme_cd, customs_tariff_code_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The customs tariff code identifies the type of goods according to the HMRC Tariff. - Source - GTS/WWT, GS-Upload, Excel Report from CDS, Broker (per Mail)');