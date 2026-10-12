--==============================================================
-- Table: t_oracle_v_calculation_user
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_calculation_user
   generated from Powerdesigner on Wednesday, July 31, 2024 12:50:37 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_calculation_user (
country STRING(2) NOT NULL OPTIONS(description='Country; sourcefield: country'),
wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='\'Number of a Warehouse; sourcefield: WAREHOUSE'),
storecalculation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Order Identificator - ID is equal to ord_storecalculation_id but not unique, same number can come up in different countries. Sourcefield: cal_storecalculation_id.'),
arguments STRING(50) NOT NULL
OPTIONS(description='Daily calculations for orders. Check potential orders and reserve for emergency concept; sourcefield: ARGUMENTS'),
user STRING(50) NOT NULL
OPTIONS(description='Usually calculation/Precalculation is provided automatically by the system. If user intervention is given it is set to manual; sourcefield: USER'),
calculation_date DATE NOT NULL
OPTIONS(description='Date when a calculation/precalculation is created; sourcefield: CALCULATION_DATE'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country, wh, storecalculation_id) NOT ENFORCED
)
OPTIONS(description=' Table contains information to create the take over rate of a calculation (evolution over a day if Calculation/Precalculation was done automatically or manually by intervention of a user); ADF sourcetable V_CALCULATION_USER             ');