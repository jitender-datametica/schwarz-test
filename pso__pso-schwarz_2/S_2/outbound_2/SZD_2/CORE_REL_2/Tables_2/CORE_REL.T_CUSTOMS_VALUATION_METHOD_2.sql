/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_VALUATION_METHOD_2
   generated from Powerdesigner on Mittwoch, 26. April 2023 09:58:07
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_customs_valuation_method_2 (
customs_valuation_method_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique code of the customs valuation method.'),
customs_valuation_method_descr STRING(1000) OPTIONS(description='A brief description of the customs valuation method.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (customs_valuation_method_id) NOT ENFORCED
)
OPTIONS(description='Minor Entity - There are 6 valuation methods that you can use to work out the customs value of your imported goods. - Source - Manual');