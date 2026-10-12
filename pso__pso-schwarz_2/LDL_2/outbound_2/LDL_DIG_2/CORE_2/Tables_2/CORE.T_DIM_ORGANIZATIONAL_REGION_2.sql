/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_ORGANIZATIONAL_REGION_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 30. November 2023 16:50:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_organizational_region_2 (
org_region_cd STRING(5) NOT NULL
OPTIONS(description='A two-letter code describing a sales_2 region_2 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.'),
org_region_descr STRING(250)
OPTIONS(description='A sales_2 region_2 within a country. The regions are defined by Lidl Stiftung, and represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (org_region_cd) NOT ENFORCED
)
OPTIONS(description='This dimensional table contains the codes and descriptions of all regions defined by Lidl Stiftung which represent an organizational hierarchy_2 level within a country_2, from a sales_2 perspective.');