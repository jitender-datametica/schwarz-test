create or replace TABLE KFL_PRODUCTION.DBP_DATA.MANDANT_WRG_TYP_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	WRG_TYP_ID NUMBER(38,0) NOT NULL COMMENT 'Es gibt zwei Typen der Währung - Land_2 = 1 und Euro = 0',
	WRG_ID VARCHAR(12) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	WRG_TYP_BEZ VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Währungstyps. Kann Land_2 oder Euro sein.',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='LIS - Legt pro Mandant_2 und Währungstyp eine_2 Währung fest'
;