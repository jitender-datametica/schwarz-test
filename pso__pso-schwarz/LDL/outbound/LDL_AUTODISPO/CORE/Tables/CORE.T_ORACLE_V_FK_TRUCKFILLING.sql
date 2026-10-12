--==============================================================
-- Table: t_oracle_v_fk_truckfilling
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_truckfilling
   generated from Powerdesigner on Freitag, 26. Januar 2024 21:31:09
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_fk_truckfilling (
country STRING(2) NOT NULL OPTIONS(description='Country; sourcefield: country'),
trf_store_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Number of a store, trf_nr is equal to ord_store_nr from order; sourcefield: trf_store_nr.'),
trf_deliverydate_id BIGNUMERIC NOT NULL
OPTIONS(description='Date ID of the calculation of the truckfilling in ADF; sourcefield: trf_deliverdate'),
trf_deliverydate DATE NOT NULL
OPTIONS(description='Date of the calculation of the truckfilling in ADF; sourcefield: trf_deliverdate'),
trf_storecalculation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Order Identificator - ID is equal to ord_storecalculation_id but not unique, same number can come up in different countries. Sourcefield; trf_storecalculation_id.'),
trf_palettecount BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Number of palettes requested for truckfilling by user. Sourcefield; trf_palettecount'),
mod_date TIMESTAMP
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country, trf_store_nr, trf_deliverydate_id, trf_storecalculation_id) NOT ENFORCED
)
OPTIONS(description='Available space on a truck can be ordered after commissioning is done. Source Oracle BD Parin and Parin1 (FR) table v_fk_truckfilling.');