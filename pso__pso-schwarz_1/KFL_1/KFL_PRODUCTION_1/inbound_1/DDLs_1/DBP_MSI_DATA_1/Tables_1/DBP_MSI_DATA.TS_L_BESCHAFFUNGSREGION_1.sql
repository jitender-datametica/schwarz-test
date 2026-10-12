--==============================================================
-- Table: ts_l_beschaffungsregion_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_l_beschaffungsregion_1
   generated from Powerdesigner on Friday, August 5, 2022 5:15:21 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_L_BESCHAFFUNGSREGION_1 (
   besch_region_id                     NUMBER(38,0)    NOT NULL COMMENT 'Beschaffungsregion SCM',
   besch_region_bez                    VARCHAR(100)    COMMENT 'Beschaffungsregion SCM Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_L_BESCHAFFUNGSREGION PRIMARY KEY (besch_region_id) NOT ENFORCED
)  COMMENT = 'LOG - Beschaffungsregion (SCM, organisatorisch). A procurement region_1 (Beschaffungsregion) is the region_1 that is responsible for product supply. It can either be the pickup of goods and coordination of other regions, or by just being the pickup region. From table gp_plz_besch_region_zu_per_1 both besch_region_id and besch_region_koordination_id refer to besch_region_id in here. A region_1 is not necessarily a country_1 but can also be a part within a country.';
