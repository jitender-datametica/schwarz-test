CREATE OR REPLACE TABLE kfl_production_dbp_data.l_werbeteam_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
werbeteam_cd STRING(100) NOT NULL OPTIONS(description='Code des Werbeteams'),
werbebereich_cd STRING(100) OPTIONS(description='Code des Werbebereichs'),
werbeteam_bez STRING(100) OPTIONS(description='Werbeteam - Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werbeteam_cd) NOT ENFORCED
)
OPTIONS(description='Fachlich verantwortliche Personen (auch Planer genannt) die für eine_2 Kategorie an Artikel_2 die über die WGs identifziert werden, die Werbungen in Deutschland planen.\n             ');