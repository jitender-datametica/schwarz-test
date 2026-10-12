--==============================================================
-- Table: t_oracle_v_fk_parameters_settings_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_parameters_settings_1
   generated from Powerdesigner on Montag, 3. Juni 2024 11:00:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_parameters_settings_1 (
country_1 STRING(2) NOT NULL OPTIONS(description='Country_1, sourcefield: COUNTRY.'),
parameter_date DATE NOT NULL
OPTIONS(description='Date on which the saved order group settings in ADF were valid; sourcefield: PAM_DATE'),
parameter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique ID to identify a parameter of an order group; sourcefield: PAM_OG_PARAM_ID'),
wh_nr BIGNUMERIC NOT NULL
OPTIONS(description='Warehouse number that is connected to the order group; sourcefield: PAM_WH_NR'),
order_group_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Unique ID to identify an order group; sourcefield: PAM_OG_ID'),
order_group_name STRING(100) NOT NULL OPTIONS(description='Name of the order group; sourcefield: PAM_OG_NAME'),
order_group_active_fg BIGNUMERIC NOT NULL
OPTIONS(description='Status_1 of an order group set in ADF system. Active=1 inactive=0; sourcefield: PAM_ACTIVE'),
adf_parameter_value STRING(50)
OPTIONS(description='Value that was maintained in ADF system by a user for a specific order group setting (parameter); sourcefield: PAM_OG_VALUE.'),
calculationmethod BIGNUMERIC(38,0)
OPTIONS(description='Calculation method is used to assign an order group to a set of items (e.g. Ambient, Tiko etc). 1 = Ambient, 2 = Mopro, 3 = Tiko, 4 = Bake-Off, 6 = Fresh Bread; sourcefield: PAM_CALCULATIONMETHOD'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date.'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country_1, parameter_id, parameter_date, wh_nr, order_group_id) NOT ENFORCED
)
OPTIONS(description='Parameters which have influence on calculations in ADF system. Values are generated in ADF system. Source: Parin/Parin1 table FK_PARAMETERS_SETTINGS.');