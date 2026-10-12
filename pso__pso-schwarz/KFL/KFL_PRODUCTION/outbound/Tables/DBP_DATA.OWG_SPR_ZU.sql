CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.owg_spr_zu (
owg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
owg_bez STRING(400) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Oberwarengruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sprachabhängige Bezeichnung der Oberwarengruppen -  Stufe in der Artikelhierarchie');