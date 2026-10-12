create or replace TABLE KFL_PRODUCTION.DBP_DATA.ABSCHRIFTART_INT_ZU_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ABSCHRIFTART_ID NUMBER(38,0) NOT NULL COMMENT 'Abschriftenart  -  numerisch',
	ABSCHRIFTART_INT_ID NUMBER(38,0) NOT NULL COMMENT 'ID Einheitliche Abschriftart KL international (z.B. -1=Werbeabschriften)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ABSCHRIFTART_INT_ZU primary key (MANDANT_ID, ABSCHRIFTART_ID, ABSCHRIFTART_INT_ID)
)COMMENT='VIS - Mapping-Tabelle nationale Abschrftenarten zu der iEinheitlichen Abschriftenarten KL international'
;