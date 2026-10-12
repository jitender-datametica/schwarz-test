/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SURVEY_CODES_MAP_2
   GENERATED FROM POWERDESIGNER ON Montag, 24. Juli 2023 14:56:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_survey_codes_map_2 (
surv_platform_cd STRING(20) NOT NULL
OPTIONS(description='Code identifiying the platform (system) used for the surveys (ex Medallia, Netigate ..)'),
surv_field_name STRING(100) NOT NULL
OPTIONS(description='Name of the field which we will be mapping from the source dataset'),
surv_field_value STRING(1000) NOT NULL
OPTIONS(description='Value of the field which we will be mapping from the source dataset'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
core_schema_field STRING(100)
OPTIONS(description='Name of the field in CORE schema to which the source field will be mapped'),
core_schema_val STRING(1000)
OPTIONS(description='Corresponding value in the CORE schema, to which the source value is mapped'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (surv_platform_cd, surv_field_name, surv_field_value, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Supporting table used to define rules for mapping different codes from source systems to common codes used in the CORE schema (for example mapping of custom product categories used in surveys  to t_dim_product_subgroup.prod_subgroup_cd)');