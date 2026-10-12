--==============================================================
-- Table: l_geku_bereich_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_geku_bereich_1
   generated from Powerdesigner on Dienstag, 20. September 2022 11:52:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_geku_bereich_1 (
geku_bereich_uid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID des GeKu-Bereichs, aus workflow_level1_uid.'),
geku_bereich_id STRING(60) NOT NULL
OPTIONS(description='Logischer Schlüssel aus Fachbereich, z.B. 90. Aus workflow_level1_ext_key.'),
wmd_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Freigabe für WMD: 0 = nicht freigegeben; 1 = freigegeben.'),
kdc_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Freigabe für KDC: 0 = nicht freigegeben; 1 = freigegeben.'),
mzk_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag: Freigabe für MZK: 0 = nicht freigegeben; 1 = freigegeben.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_bereich_uid) NOT ENFORCED
) OPTIONS(description='GEKU - Stufe 1 der GeKu-Artikelhierarchie aus s1_dhw_workflow_level1_out.');