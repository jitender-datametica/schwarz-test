CREATE OR REPLACE TABLE szd_production_etl.owg_spr_zu_2 (
owg_id INTEGER NOT NULL OPTIONS(description='ID der Oberwarengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
owg_bez STRING(400) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung der Oberwarengruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
);