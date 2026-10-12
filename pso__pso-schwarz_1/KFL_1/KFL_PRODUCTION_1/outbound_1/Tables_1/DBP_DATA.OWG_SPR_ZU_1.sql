CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.owg_spr_zu_1 (
owg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
owg_bez STRING(400) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Oberwarengruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sprachabhängige Bezeichnung der Oberwarengruppen -  Stufe in der Artikelhierarchie');