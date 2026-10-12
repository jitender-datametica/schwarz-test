--==============================================================
-- Table: ts_l_beschaffungsregion_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_l_beschaffungsregion_2
   generated from Powerdesigner on Friday, August 5, 2022 5:15:21 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_l_beschaffungsregion_2 (
besch_region_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Beschaffungsregion SCM'),
besch_region_bez STRING(100) OPTIONS(description='Beschaffungsregion SCM Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (besch_region_id) NOT ENFORCED
)
OPTIONS(description='LOG - Beschaffungsregion (SCM, organisatorisch). A procurement region_2 (Beschaffungsregion) is the region_2 that is responsible for product supply. It can either be the pickup of goods and coordination of other regions, or by just being the pickup region. From table gp_plz_besch_region_zu_per_2 both besch_region_id and besch_region_koordination_id refer to besch_region_id in here. A region_2 is not necessarily a country_2 but can also be a part within a country.');