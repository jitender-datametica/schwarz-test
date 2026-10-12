CREATE OR REPLACE TABLE kfl_production_dbp_data.artkz_loesch_1 (
loesch_id STRING(2) NOT NULL OPTIONS(description='ID des Loeschkennzeichens, z.Bsp. L fuer logisch geloeschte Artikel_1'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache.'),
loesch_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Sprachabhaengige Bezeichnung des Loeschkennzeichens'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, loesch_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Artikelkennzeichens Loeschartikel');