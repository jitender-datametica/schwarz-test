CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.dwh_wg_erfass_artikel_1 (
art_id INTEGER NOT NULL OPTIONS(description='DWH-Artikelnummer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
td_update TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration')
);