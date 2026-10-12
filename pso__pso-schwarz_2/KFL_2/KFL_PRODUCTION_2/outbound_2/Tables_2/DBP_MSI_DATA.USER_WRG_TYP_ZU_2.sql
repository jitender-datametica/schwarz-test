--==============================================================
-- Table: user_wrg_typ_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: user_wrg_typ_zu_2
   generated from Powerdesigner on Mittwoch, 18. Dezember 2024 18:05:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.user_wrg_typ_zu_2 (
user_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
wrg_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Es gibt zwei Typen der Währung - Land_2 = 1 und Euro = 0'),
berichtskurs_typ_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Es gibt zwei Typen des Berichtskurs - aktueller Berichtskurs = 0 und historischer Berichtskurs = 1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wrg_typ_id) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - Zuordnung des FrontEnd-Users zu einem Währungstyp und Berichtskurstyp - über FrontEnd einstellbar.');