CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_ETL_PROCESS.DWH_WG_ERFASS_ARTIKEL_1 (
ART_ID INTEGER NOT NULL OPTIONS(description='DWH-Artikelnummer'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
TD_UPDATE TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration')
);