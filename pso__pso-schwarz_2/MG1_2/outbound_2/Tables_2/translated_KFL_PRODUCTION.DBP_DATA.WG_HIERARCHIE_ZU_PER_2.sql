CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.WG_HIERARCHIE_ZU_PER_2 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ARTHIERTYP_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
WG_HIERARCHIE_EBENE_ID INTEGER NOT NULL OPTIONS(description='eindeutige ID der Ebene einer Warengruppenhierarchie'),
WG_HIERARCHIE_ID INTEGER NOT NULL OPTIONS(description='ID der Warengruppen Hierarchie'),
WG_HIERARCHIE_MUTTER_ID INTEGER NOT NULL OPTIONS(description='ID des Elternelements'),
DAT_VON DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode'),
DAT_BIS DATE NOT NULL OPTIONS(description='Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ARTHIERTYP_ID, WG_HIERARCHIE_EBENE_ID, WG_HIERARCHIE_ID, DAT_VON) NOT ENFORCED
) OPTIONS(description='TP2_AIS - Stammdaten der Warengruppenhierarchien');