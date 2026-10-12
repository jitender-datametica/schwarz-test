CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.sortiment_user_wg_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
user_id STRING(120) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des MSI Users'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Security-Tabelle für die Zuordnung von Warengruppen zu Usern (was darf im Sortimentstool eingesehen werden) Pflege erfolgt über einen MSI-TS-Bericht');