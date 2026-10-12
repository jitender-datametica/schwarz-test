create or replace TABLE KFL_PRODUCTION.DBP_DATA.ABSCHRIFTART_ABSCHRIFTGRP_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ABSCHRIFTART_ID NUMBER(38,0) NOT NULL COMMENT 'Abschriftenart  -  numerisch',
	ABSCHRIFTGRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'Merkmal zur Gruppierung der Abschriften',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ABSCHRIFTART_ABSCHRIFTGRP_ZU primary key (MANDANT_ID, ABSCHRIFTART_ID, ABSCHRIFTGRUPPE_ID)
)COMMENT='VIS - Gruppierung von Abschriftenarten'
;