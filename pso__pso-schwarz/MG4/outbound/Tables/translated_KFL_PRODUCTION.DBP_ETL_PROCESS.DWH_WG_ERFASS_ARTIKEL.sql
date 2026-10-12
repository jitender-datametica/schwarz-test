CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.dwh_wg_erfass_artikel (
art_id INTEGER NOT NULL OPTIONS(description='DWH-Artikelnummer'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
wg_id INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id INTEGER NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
td_update TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration')
);