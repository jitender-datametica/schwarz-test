CREATE OR REPLACE TABLE kfl_production_dbp_data.wug_spr_zu (
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
wug_id INTEGER NOT NULL OPTIONS(description='ID der Warenuntergruppe'),
wug_bez STRING(160) COLLATE 'und:ci' OPTIONS(description='Warenuntergruppe - Bezeichnung'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP2_AIS - Sprachabhaengige Bezeichnungen der Warenuntergruppen');