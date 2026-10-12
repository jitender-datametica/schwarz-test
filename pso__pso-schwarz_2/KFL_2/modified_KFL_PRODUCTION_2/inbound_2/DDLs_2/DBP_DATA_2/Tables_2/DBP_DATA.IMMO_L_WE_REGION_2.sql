--==============================================================
-- Table: immo_l_we_region_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_we_region_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_L_WE_REGION_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   we_region                           VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Region_2 (nicht Bundesland) einer Wirtschaftseinheit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_L_WE_REGION PRIMARY KEY (mandant_id, we_region) NOT ENFORCED
)  COMMENT = 'IMMO - Lookup-Tabelle für WE-Region_2 - SAP Baustein ZBI_RE_DATA_BE_CI_DATA';
