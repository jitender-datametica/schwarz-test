CREATE OR REPLACE TABLE smp_production_etl_process.t_campaign_advertiser_exception_2 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_2 iso code'),
campaign_id STRING(100) NOT NULL OPTIONS(description='Unique identifier of campaign per Source and Country_2'),
campaign_name STRING(500) NOT NULL OPTIONS(description='Campaign Name of source system'),
advertiser_id_smp STRING(100) OPTIONS(description='Origin identifier advertiser smp source'),
advertiser_id_smp_split STRING(100) OPTIONS(description='Split Identifier advertiser'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job')
)
OPTIONS(description='Campaign advertiser exception for advertiser split which will not delivered per SMP interface, content manually maintained;');