--==============================================================
-- Table: t_oracle_v_dim_shc_date_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_dim_shc_date_1
   generated from Powerdesigner on Donnerstag, 4. April 2024 14:16:39
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_ORACLE_V_DIM_SHC_DATE_1 CLUSTER BY (COUNTRY_1,SH_DATE)
(
   country_1                             VARCHAR(2)       NOT NULL COMMENT 'Country_1; sourcefield: country_1',
   sh_date_id                          NUMBER(38, 0)    NOT NULL COMMENT 'Date ID of the creation of shelfcapacity in ADF; sourcefield: sh_date',
   sh_date                             DATE             NOT NULL COMMENT 'Date of the creation of shelfcapacity in ADF; generated in loading from sh_date_id',
   sh_store_nr                         NUMBER           NOT NULL COMMENT 'Number of a store, sh_store_nr is equal to other xx_store_nr from other tables; sourcefield: sh_store_nr.',
   sh_item_nr                          NUMBER           NOT NULL COMMENT 'Global item_1 number, sh_item_nr is equal to other xx_item_nr from other tables; sourcefield: sh_item_nr.',
   sh_aoc_shc_unit_id                  NUMBER(38, 0)    COMMENT 'Shelfcapacity unit_1-bundle (for sending to store) of an article, is set in ADF; IDs: 0 = case, 1 = layer, 2 = half palette, 3 = palette; sourcefield: SH_AOC_SHC_UNIT_ID',
   sh_qty_aoc                          NUMBER           COMMENT 'Capacity for a given item_1 in units  SH_AOC_SHC_UNIT_ID in ADF; sourcefield: SH_QTY_AOC',
   sh_wawi_shc_unit_id                 NUMBER(38, 0)    COMMENT 'Shelfcapacity unit_1 -bundle (for sending to store) of an article, comes from Wawi; IDs: 0 = case, 1 = layer, 2 = half palette, 3 = palette; sourcefield: SH_WAWI_SHC_UNIT_ID',
   sh_qty_wawi                         NUMBER           COMMENT 'Capacity for a given item_1 in units SH_WAWI_SHC_UNIT_ID in Wawi; sourcefield: SH_QTY_WAWI',
   mod_date                            TIMESTAMP_LTZ    NOT NULL COMMENT 'Timestamp of altering entries inside the table. Sourcefield; mod_date',
   source_extraction_tmsp              TIMESTAMP_LTZ    NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   snflk_insert_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process',
   snflk_update_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_DIM_SHC_DATE PRIMARY KEY (country_1, sh_date_id, sh_store_nr, sh_item_nr) NOT ENFORCED 
)  COMMENT = 'Shelfcapacity on store item_1 level created in ADF, if used has priority over MDE device in stores. Sourcetable Parin/Parin1 is v_DIM_SHC_date.';
