CREATE OR REPLACE TABLE kfl_production_dbp_data.hwg_spr_zu (
hwg_id INTEGER NOT NULL OPTIONS(description='ID der Hauptwarengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
hwg_bez STRING(400) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Hauptwarengruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sprachabhängige Bezeichnung der Hauptwarengruppen -  Stufe in der Artikelhierarchie');