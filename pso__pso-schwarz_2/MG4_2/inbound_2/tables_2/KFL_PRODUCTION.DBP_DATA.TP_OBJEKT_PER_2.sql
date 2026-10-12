create or replace TABLE KFL_PRODUCTION.DBP_DATA.TP_OBJEKT_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	TP_OBJEKT_ID NUMBER(38,0) NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2',
	DAT_VON DATE NOT NULL COMMENT 'Datum, ab dem der Datensatz gültig ist',
	TECHN_PLATZ_ID VARCHAR(30) NOT NULL COMMENT 'Der technische Platz ist eine_2 von Kaufland Facility Management verwaltete Einheit',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem der Datensatz gültig ist. Ist dieses Datum nicht bekannt, wird der 31.12.9999 eingestellt.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TP_OBJEKT_TYP VARCHAR(1) COMMENT 'Equipmenttyp',
	HERSTELLER_NAME VARCHAR(30) COMMENT 'Hersteller der Anlage_2',
	HERSTELLER_LAND_ID VARCHAR(2) COMMENT 'Herstellerland',
	HERSTELLER_TYP_BEZ VARCHAR(20) COMMENT 'Typenbezeichnung des Herstellers',
	HERSTELLER_SERIAL_ID VARCHAR(30) COMMENT 'Serialnummer gemäß Hersteller',
	BAU_KJ NUMBER(38,0) COMMENT 'Baujahr',
	BAU_KJMO NUMBER(38,0) COMMENT 'Baumonat',
	DAT_GEWAEHRLEISTUNG_START DATE COMMENT 'Gewährleistungsdatum',
	DAT_GEWAEHRLEISTUNG_ENDE DATE COMMENT 'Datum, an dem die Gewährleistung endet',
	TP_OBJEKT_NR VARCHAR(30) COMMENT 'Objektnummer',
	constraint PK_TP_OBJEKT_PER primary key (MANDANT_ID, TP_OBJEKT_ID, DAT_VON)
)COMMENT='IOS - Historisierte mandantenbezogene Stammtabelle für Objekte eines technischen Platzes.'
;