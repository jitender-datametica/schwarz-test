CREATE OR REPLACE TABLE kfl_production_dbp_data.artkz_lead_2 (
lead_id INTEGER NOT NULL OPTIONS(description='Artikelkennzeichen leader 1 ist Leader, sonst 0'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
lead_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung Leader'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (lead_id, mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Lookuptabelle des Artikelkennzeichens Leaderartikel');