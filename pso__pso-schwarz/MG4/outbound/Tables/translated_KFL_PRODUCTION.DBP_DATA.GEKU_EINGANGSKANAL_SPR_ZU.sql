CREATE OR REPLACE TABLE kfl_production_dbp_data.geku_eingangskanal_spr_zu (
geku_eingangskanal_id INTEGER NOT NULL OPTIONS(description='GeKu Eingangskanal, z.Bsp. Fax, Telefon'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
geku_eingangskanal_bez STRING(60) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des GeKu-Eingangskanals, z.Bsp. Brief; Fax'),
quelle_spr_id INTEGER
OPTIONS(description='Fehlende Spracheinträge werden aus einem vorhandenen Eintrag generiert. Hier ist gespeichert, aus welcher Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_eingangskanal_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - Sprachabhängige Bezeichnungen der Eingangskanäle');