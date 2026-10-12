CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_planung_mieteinnahmen_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Planflache in Quadratmetern'),
we_intreno STRING(20) COLLATE 'und:ci' NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Währungsid'),
planmiete_per_monat NUMERIC(18,2) NOT NULL,
planmiete_per_qm NUMERIC(18,2) NOT NULL OPTIONS(description='Planmiete pro Quadratmeter'),
planflaeche NUMERIC(18,4) NOT NULL OPTIONS(description='Planflaeche in Quadratmetern.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMMO - Planung der Mieteinnahmen für das laufende Jahr. Werden jedes Jahr überschrieben.');