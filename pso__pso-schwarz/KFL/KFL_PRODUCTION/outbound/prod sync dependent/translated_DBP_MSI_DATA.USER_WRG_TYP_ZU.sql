CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.user_wrg_typ_zu (
user_id STRING(30) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
wrg_typ_id INTEGER NOT NULL OPTIONS(description='Es gibt zwei Typen der Währung - Land = 1 und Euro = 0'),
berichtskurs_typ_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Es gibt zwei Typen des Berichtskurs - aktueller Berichtskurs = 0 und historischer Berichtskurs = 1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wrg_typ_id) NOT ENFORCED
)
OPTIONS(description='AIS_KMO - Zuordnung des FrontEnd-Users zu einem Währungstyp und Berichtskurstyp - über FrontEnd einstellbar.');