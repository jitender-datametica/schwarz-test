--==============================================================
-- Table: t_oracle_v_dic_parameters_settings_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_dic_parameters_settings_2
   generated from Powerdesigner on Montag, 3. Juni 2024 10:57:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dic_parameters_settings_2 (
country_2 STRING(2) NOT NULL OPTIONS(description='Country_2, sourcefield: COUNTRY.'),
parameter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique ID to identify a parameter of an order group; sourcefield: DIC_PARAM_ID.'),
parameter_name STRING(100) NOT NULL
OPTIONS(description='Name of the parameter of an order group; sourcefield: DIC_PARAM_NAME.'),
defined_parameter_value STRING(50)
OPTIONS(description='The default value of a parameter if no other value was maintained by a user; sourcefield: DIC_DEF_VALUE.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Start date from when a defined parameter is valid; created in loading process (day of the loading in Snowflake table).'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Expiration date of a defined parameter; created in loading process (day of the loading in Snowflake table if a new parameter is set; usually set to date unlimited).'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date.'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country_2, parameter_id) NOT ENFORCED
)
OPTIONS(description='Defined parameters which have influence on calculations in ADF system. Values are uploaded by business via Excel file. Source: Parin/Parin1 table DIC_PARAMETERES_SETTIGNS.');