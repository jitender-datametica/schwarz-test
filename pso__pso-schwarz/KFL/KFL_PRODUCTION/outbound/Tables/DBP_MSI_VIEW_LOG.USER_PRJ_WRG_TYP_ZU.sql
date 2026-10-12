CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_log.user_prj_wrg_typ_zu (
user_id STRING(120) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
wrg_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Es gibt zwei Typen der Währung - Land = 1 und Euro = 0'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='Zuordnung des FrontEnd-Users zu einem Währungstyp fuer das LOG MSTR-Projekt - über FrontEnd einstellbar');