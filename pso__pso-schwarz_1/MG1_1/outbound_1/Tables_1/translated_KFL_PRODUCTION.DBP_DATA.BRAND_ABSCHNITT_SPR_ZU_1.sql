CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BRAND_ABSCHNITT_SPR_ZU_1 (
BRAND_ABSCHNITT_ID STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Brandabschnitts aus brand_1'),
MANDANT_ID INTEGER NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
LAGERNUMMER_ID STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
SPR_ID INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
BRAND_ABSCHNITT_BEZ STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Brandabschnitts aus brant'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, SPR_ID) NOT ENFORCED
) OPTIONS(description='LIS - Sprachabhängige Bezeichnungen der Brandabschnitte aus t309t');