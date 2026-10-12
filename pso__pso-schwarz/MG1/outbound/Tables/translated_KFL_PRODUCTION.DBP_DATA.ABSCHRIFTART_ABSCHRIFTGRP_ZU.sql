CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ABSCHRIFTART_ABSCHRIFTGRP_ZU (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
ABSCHRIFTART_ID INTEGER NOT NULL OPTIONS(description='Abschriftenart  -  numerisch'),
ABSCHRIFTGRUPPE_ID INTEGER NOT NULL OPTIONS(description='Merkmal zur Gruppierung der Abschriften'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (MANDANT_ID, ABSCHRIFTART_ID, ABSCHRIFTGRUPPE_ID) NOT ENFORCED
) OPTIONS(description='VIS - Gruppierung von Abschriftenarten');