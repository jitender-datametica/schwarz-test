CREATE OR REPLACE TABLE kfl_production_dbp_data.in_kostenstelle_spr_zu_per_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle aus kostl'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
dat_von DATE NOT NULL OPTIONS(description='Beginn des Gültigkeitszeitraums aus datab'),
spr_id INTEGER NOT NULL OPTIONS(description='Sprache im DWH'),
dat_bis DATE NOT NULL
OPTIONS(description='Ende des Gültigkeitszeitraums aus datbi, bei offenen Datensätzen ist dies 31.12.9999'),
kostenstelle_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Kostenstelle aus ltext'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_von, spr_id) NOT ENFORCED
) OPTIONS(description='IMS - Sprachabhängige Bezeichnungen dern Kostenstellen aus Industrie aus cskt');