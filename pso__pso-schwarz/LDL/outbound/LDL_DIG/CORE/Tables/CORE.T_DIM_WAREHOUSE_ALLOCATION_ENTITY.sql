/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_ALLOCATION_ENTITY
   GENERATED FROM POWERDESIGNER ON Donnerstag, 31. August 2023 14:46:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_warehouse_allocation_entity (
wh_alloc_entity_cd STRING(5) NOT NULL
OPTIONS(description='A code for warehouse allocation unit  (LI_DE , LI_CZ, KFL_DE, KFL_CZ , INTEGER etc)'),
wh_alloc_entity_descr STRING(250) NOT NULL OPTIONS(description='A description for warehouse allocation unit'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
wh_alloc_entity_country_cd STRING(5)
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
wh_alloc_entity_display_order_nr BIGNUMERIC
OPTIONS(description='A display order in which allocation entities appear in reporting'),
wh_alloc_entity_group_cd STRING(5)
OPTIONS(description='Groups allocation entities to related line of business ( LDI ,  Kaufland , etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_alloc_entity_cd) NOT ENFORCED
)
OPTIONS(description='A unit describing fractions or logical units to which warehouse management system allocates stock ( f.e. stock destinated to Lidl DE webshop , KFL CZ webshop , INTEGER - Lidl global pool)');