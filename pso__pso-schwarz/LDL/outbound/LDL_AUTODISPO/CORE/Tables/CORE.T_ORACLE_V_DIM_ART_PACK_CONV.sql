--==============================================================
-- Table: t_oracle_v_dim_art_pack_conv
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_oracle_v_dim_art_pack_conv
   generated from Powerdesigner on Donnerstag, 4. April 2024 10:22:56
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_autodispo_core.t_oracle_v_dim_art_pack_conv (
country STRING(2) NOT NULL OPTIONS(description='Country; sourcefield: country'),
pac_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Number of a Warehouse; sourcefield: pac_wh'),
pac_item_nr STRING(16777216) NOT NULL
OPTIONS(description='Global item number, pac_item_nr is equal to other xx_item_nr from other tables; sourcefield: pac_item_nr.'),
pac_item_packagecapacity BIGNUMERIC(38,5) NOT NULL
OPTIONS(description='Amount of salesitems that can be placed in one case. Sourcefield: PAC_ITEM_PACKAGECAPACITY'),
pac_article_unit BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Article unit-bundle (for sending to store) is set in ADF; IDs: 0 = case, 1 = layer, 2 = half palette, 3 = palette; sourcefield: PAC_ARTICLE_UNIT   (Also used in table core.T_ORACLE_V_DIM_SHC_DATE field SH_AOC_SHC_UNIT_ID)'),
pac_package_name STRING(16777216) NOT NULL
OPTIONS(description='Name of the PAC_ARTICLE_UNIT in ADF; IDs: 0 = case, 1 = layer, 2 = half palette, 3 = palette; sourcefield: PAC_PACKAGE_NAME'),
pac_package_count BIGNUMERIC(38,0)
OPTIONS(description='Amount of packages that can be placed on one pallette. Sourcefield: PAC_PACKAGE_COUNT'),
mod_date TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date'),
source_extraction_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.'),
snflk_insert_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake loading process.'),
snflk_update_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Date/Time combination added in the Snowflake table update process.'),
PRIMARY KEY (country, pac_wh, pac_item_nr, pac_item_packagecapacity, pac_article_unit) NOT ENFORCED
)
OPTIONS(description='Masterdata table on item level to see possible units, packages and counts. Source: Parin/Parin1 table DIM_ART_PACK_CONV.');