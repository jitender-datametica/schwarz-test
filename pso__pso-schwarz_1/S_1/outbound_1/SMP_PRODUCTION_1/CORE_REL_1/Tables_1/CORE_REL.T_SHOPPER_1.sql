CREATE OR REPLACE TABLE smp_production_core_rel.t_shopper_1 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_1 iso code'),
shopper_id STRING(100) NOT NULL OPTIONS(description='SMP Shopper_1 reference'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ '),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job'),
shopper_id_ref STRING(16777216) NOT NULL
OPTIONS(description='Division shopper_1 reference, e.g. customer_sid, Kundenkarte_id, KFL sometimes more than one'),
active_fg INTEGER NOT NULL OPTIONS(description='Flag active/inactve Shopper_1'),
home_store_id STRING(100) OPTIONS(description='Shopper_1 Favorite Store/Homestore'),
home_zip_code STRING(100) OPTIONS(description='Shopper_1 Zip Code (based on Favourite Store/Homestore'),
gender_id STRING(100) OPTIONS(description='Shoppper Gender: male, femaile, diverse, unknown'),
age INTEGER OPTIONS(description='Age of Shopper_1')
) OPTIONS(description='Shopper_1 masterdata');