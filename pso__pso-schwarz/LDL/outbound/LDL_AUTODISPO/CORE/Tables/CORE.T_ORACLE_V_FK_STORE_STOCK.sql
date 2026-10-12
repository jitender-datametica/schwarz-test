--==============================================================
-- Table: t_oracle_v_fk_store_stock
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_store_stock
   generated from Powerdesigner on Donnerstag, 2. Mai 2024 09:41:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_store_stock (
country STRING(16777216) NOT NULL OPTIONS(description='Country; sourcefield: country'),
fss_store_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of a store, fss_store_nr is equal to other xx_store_nr from other tables;'),
fss_item_nr STRING(16777216) NOT NULL
OPTIONS(description='Global item number, fss_item_nr is equal to other xx_item_nr from other tables'),
fss_time_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='fss_time_id'),
fss_date DATE NOT NULL
OPTIONS(description='Generated from field FSS_TIME_ID during loading with logic DATEADD(DAY, FSS_TIME_ID - 365.25 * (4712) - 2,\'0000-01-01\')'),
fss_quantity BIGNUMERIC(38,2) OPTIONS(description='fss_quantity'),
mod_date TIMESTAMP
OPTIONS(description='Timestamp of altering entries inside the table. Sourcefield; mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country, fss_store_nr, fss_item_nr, fss_time_id) NOT ENFORCED
) CLUSTER BY country, fss_date
OPTIONS(description='T_ORACLE_V_FK_STORE_STOCK');