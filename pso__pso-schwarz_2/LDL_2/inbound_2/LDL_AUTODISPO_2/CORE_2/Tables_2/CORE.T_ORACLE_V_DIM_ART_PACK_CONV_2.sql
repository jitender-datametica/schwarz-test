--==============================================================
-- Table: t_oracle_v_dim_art_pack_conv_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_dim_art_pack_conv_2
   generated from Powerdesigner on Donnerstag, 4. April 2024 10:22:56
*/ --------------------------------------------------------------------------------

CREATE TABLE core.T_ORACLE_V_DIM_ART_PACK_CONV_2 (
   country_2                             VARCHAR(2)        NOT NULL COMMENT 'Country_2; sourcefield: country_2',
   pac_wh                              NUMBER(38,0)      NOT NULL COMMENT 'Number of a Warehouse; sourcefield: pac_wh',
   pac_item_nr                         VARCHAR(16777216) NOT NULL COMMENT 'Global item_2 number, pac_item_nr is equal to other xx_item_nr from other tables; sourcefield: pac_item_nr.',
   pac_item_packagecapacity            NUMBER(38, 5)     NOT NULL COMMENT 'Amount of salesitems that can be placed in one case. Sourcefield: PAC_ITEM_PACKAGECAPACITY',
   pac_article_unit                    NUMBER(38,0)      NOT NULL COMMENT 'Article unit_2-bundle (for sending to store) is set in ADF; IDs: 0 = case, 1 = layer, 2 = half palette, 3 = palette; sourcefield: PAC_ARTICLE_UNIT
   (Also used in table core.T_ORACLE_V_DIM_SHC_DATE_2 field SH_AOC_SHC_UNIT_ID)',
   pac_package_name                    VARCHAR(16777216) NOT NULL COMMENT 'Name of the PAC_ARTICLE_UNIT in ADF; IDs: 0 = case, 1 = layer, 2 = half palette, 3 = palette; sourcefield: PAC_PACKAGE_NAME',
   pac_package_count                   NUMBER(38,0)     COMMENT 'Amount of packages that can be placed on one pallette. Sourcefield: PAC_PACKAGE_COUNT',
   mod_date                            TIMESTAMP_LTZ    NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date',
   source_extraction_tmsp              TIMESTAMP_LTZ    NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
   snflk_insert_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
   snflk_update_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',   
   CONSTRAINT PK_T_ORACLE_V_DIM_ART_PACK_CONV PRIMARY KEY (country_2, pac_wh, pac_item_nr, pac_item_packagecapacity, pac_article_unit) NOT ENFORCED 
)  COMMENT = 'Masterdata table on item_2 level to see possible units, packages and counts. Source: Parin/Parin1 table DIM_ART_PACK_CONV.';
