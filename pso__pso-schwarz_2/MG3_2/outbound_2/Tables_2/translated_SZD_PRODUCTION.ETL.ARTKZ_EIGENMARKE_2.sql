CREATE OR REPLACE TABLE szd_production_etl.artkz_eigenmarke_2 (
eigenmarke_id STRING(8) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eigenmarken-Kennzeichen (z.Bsp. C f��r Kaufland Klassikartikel)'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
eigenmarke_bez STRING(160) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Eigenmarkenkennzeichens'),
td_update TIMESTAMP,
td_insert TIMESTAMP
);