create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.MANDANT_WRG_TYP_ZU (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Es gibt zwei Typen der Währung - Land = 1 und Euro = 0',
	WRG_ID VARCHAR(12) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	WRG_TYP_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Währungstyps. Kann Land oder Euro sein.',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='LIS - Legt pro Mandant und Währungstyp eine Währung fest'
;
