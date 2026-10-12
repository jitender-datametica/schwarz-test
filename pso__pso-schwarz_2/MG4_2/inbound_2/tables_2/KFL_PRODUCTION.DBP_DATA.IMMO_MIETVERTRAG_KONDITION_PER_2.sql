create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MIETVERTRAG_KONDITION_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	MV_INTRENO VARCHAR(20) NOT NULL COLLATE 'en-ci' COMMENT 'Interner Schlüssel des Immobilienobjekts',
	MO_INTRENO VARCHAR(20) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Interner Schlüssel des Immobilienobjekts',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem die Kondition gilt',
	KONDITIONSART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Konditionsart',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem die Kondition gilt',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	MIETE_PER_ANNO NUMBER(18,2) NOT NULL DEFAULT 0 COMMENT 'Vereinbarte jährliche Miete',
	MIETE_UMSATZ_PROZENT NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Angabe Prozentsatz der Umsatzmiete',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MIETVERTRAG_KONDITION_PER primary key (MANDANT_ID, MV_INTRENO, MO_INTRENO, DAT_VON, KONDITIONSART_ID)
)COMMENT='IMMO - Mietvertrag Kondition - SAP REFX - ZBI_RE_DATA_CN_CONDITION_VICNCN'
;