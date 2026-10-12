CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WG_FILTER_ZU_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
WG_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppe'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WG_FILTER_ID INTEGER NOT NULL OPTIONS(description='ID Filter auf Warengruppen '),
WUG_ID INTEGER OPTIONS(description='ID der Warenuntergruppe'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='VIS - Zuordnung WG-Filter-ID zu WG_ID (Warengruppen) - wird manuell beladen');