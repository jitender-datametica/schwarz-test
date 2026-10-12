CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ABSCHRIFTART_INT_ZU (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ABSCHRIFTART_ID INTEGER NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
ABSCHRIFTART_INT_ID INTEGER NOT NULL
OPTIONS(description='ID Einheitliche Abschriftart KL international (z.B. -1=Werbeabschriften)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ABSCHRIFTART_ID, ABSCHRIFTART_INT_ID) NOT ENFORCED
)
OPTIONS(description='VIS - Mapping-Tabelle nationale Abschrftenarten zu der iEinheitlichen Abschriftenarten KL international');