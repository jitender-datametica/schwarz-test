--==============================================================
-- Table: t_oracle_v_fk_store_stock
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_fk_store_stock
   generated from Powerdesigner on Donnerstag, 2. Mai 2024 09:41:46
*/ --------------------------------------------------------------------------------

CREATE TABLE core.T_ORACLE_V_FK_STORE_STOCK CLUSTER BY (
     COUNTRY,
     FSS_DATE
)(
   country                             VARCHAR(16777216)  NOT NULL COMMENT 'Country; sourcefield: country',
   fss_store_nr                        NUMBER(38, 0)      NOT NULL COMMENT 'Number of a store, fss_store_nr is equal to other xx_store_nr from other tables;',
   fss_item_nr                         VARCHAR(16777216)  NOT NULL COMMENT 'Global item number, fss_item_nr is equal to other xx_item_nr from other tables',
   fss_time_id                         NUMBER(38, 0)      NOT NULL COMMENT 'fss_time_id',
   fss_date                            DATE               NOT NULL COMMENT 'Generated from field FSS_TIME_ID during loading with logic DATEADD(DAY, FSS_TIME_ID - 365.25 * (4712) - 2, ''0000-01-01'')',
   fss_quantity                        NUMBER(38, 2)     COMMENT 'fss_quantity',
   mod_date                            TIMESTAMP_LTZ     COMMENT 'Timestamp of altering entries inside the table. Sourcefield; mod_date',
   source_extraction_tmsp              TIMESTAMP_LTZ     NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   snflk_insert_tmsp                   TIMESTAMP_LTZ(9)  NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process',
   snflk_update_tmsp                   TIMESTAMP_LTZ(9)  NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_FK_STORE_STOCK PRIMARY KEY (country, fss_store_nr, fss_item_nr, fss_time_id) NOT ENFORCED 
)  COMMENT = 'T_ORACLE_V_FK_STORE_STOCK';
