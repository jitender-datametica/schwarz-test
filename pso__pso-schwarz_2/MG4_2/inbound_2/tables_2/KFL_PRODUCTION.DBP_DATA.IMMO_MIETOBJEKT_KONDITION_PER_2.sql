create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MIETOBJEKT_KONDITION_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	MO_INTRENO VARCHAR(20) NOT NULL COMMENT 'Interner Schlüssel des Immobilienobjekts',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem die Kondition gilt',
	KONDITIONSART_ID VARCHAR(4) NOT NULL COMMENT 'Konditionsart',
	MO_OBJEKT_NR VARCHAR(30) NOT NULL COMMENT 'Objektnummer für Berechnung',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem die Kondition gilt',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Währung der Konditionsposition',
	MIETE_PER_ANNO NUMBER(18,2) NOT NULL DEFAULT 0 COMMENT 'Vereinbarte jährliche Miete',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MIETOBJEKT_KONDITION_PER primary key (MANDANT_ID, MO_INTRENO, DAT_VON, KONDITIONSART_ID)
)COMMENT='IMMO - Mietobjekt Kondition - SAP REFX - ZBI_RE_DATA_RO_CONDITION_VIBDRO'
;