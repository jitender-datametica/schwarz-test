CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_OFENTYP_ZU_2 (
ART_ID INTEGER NOT NULL OPTIONS(description='DWH Artikelnummer'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
OFEN_TYP_ID STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Ofentyps aus dem Quellfeld oventype, z.Bsp. A.'),
BLECH_BELEGUNG INTEGER NOT NULL OPTIONS(description='optimale Anzahl des Artikels pro Backblech'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID) NOT ENFORCED
)
OPTIONS(description='VIS Backshop - Diese Tabelle ordnet den Artikeln die Ofentypen zu. Quelle ist die SAP-Klassenbibliothek');