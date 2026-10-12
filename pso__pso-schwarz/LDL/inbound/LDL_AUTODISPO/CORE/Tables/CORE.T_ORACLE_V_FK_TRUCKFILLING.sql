--==============================================================
-- Table: t_oracle_v_fk_truckfilling
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_truckfilling
   generated from Powerdesigner on Freitag, 26. Januar 2024 21:31:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_FK_TRUCKFILLING (
   country                             VARCHAR(2)      NOT NULL COMMENT 'Country; sourcefield: country',
   trf_store_nr                        NUMBER(38, 0)   NOT NULL COMMENT 'Number of a store, trf_nr is equal to ord_store_nr from order; sourcefield: trf_store_nr.',
   trf_deliverydate_id                 NUMBER          NOT NULL COMMENT 'Date ID of the calculation of the truckfilling in ADF; sourcefield: trf_deliverdate',
   trf_deliverydate                    DATE            NOT NULL COMMENT 'Date of the calculation of the truckfilling in ADF; sourcefield: trf_deliverdate',
   trf_storecalculation_id             NUMBER(38, 0)   NOT NULL COMMENT 'Order Identificator - ID is equal to ord_storecalculation_id but not unique, same number can come up in different countries. Sourcefield; trf_storecalculation_id.',
   trf_palettecount                    NUMBER(38, 5)   NOT NULL COMMENT 'Number of palettes requested for truckfilling by user. Sourcefield; trf_palettecount',
   mod_date                            TIMESTAMP_LTZ   COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date',
   source_extraction_tmsp              TIMESTAMP_LTZ   NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   snflk_insert_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   snflk_update_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_FK_TRUCKFILLING PRIMARY KEY (country, trf_store_nr, trf_deliverydate_id, trf_storecalculation_id) NOT ENFORCED 
)  COMMENT = 'Available space on a truck can be ordered after commissioning is done. Source Oracle BD Parin and Parin1 (FR) table v_fk_truckfilling.';
