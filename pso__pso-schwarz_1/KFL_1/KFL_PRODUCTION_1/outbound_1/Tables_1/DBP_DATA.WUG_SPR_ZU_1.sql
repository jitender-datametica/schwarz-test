CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wug_spr_zu_1 (
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
wug_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warenuntergruppe'),
wug_bez STRING(160) COLLATE 'und:ci' OPTIONS(description='Warenuntergruppe - Bezeichnung'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP2_AIS - Sprachabhaengige Bezeichnungen der Warenuntergruppen');