CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_vertragsart_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
vertragsart_id INTEGER NOT NULL OPTIONS(description='Vertragsart'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
vertragsart_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL OPTIONS(description='Bezeichnung der Vertragsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vertragsart_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMMO - Sprachabhängige Bezeichnung der Art des Vermietungsvertrags  - SAP REFX - TIV2F');