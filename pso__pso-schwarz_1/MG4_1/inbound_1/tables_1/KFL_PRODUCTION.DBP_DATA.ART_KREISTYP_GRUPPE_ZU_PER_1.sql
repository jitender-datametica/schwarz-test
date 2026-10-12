create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_KREISTYP_GRUPPE_ZU_PER_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Id',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	KREISTYP_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Kreistyp',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode',
	KREISTYP_GRUPPE_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Region_1 / Gruppierung Kreistypen',
	DAT_BIS DATE NOT NULL COMMENT 'Endedatum der Gültigkeit, bei aktuellen Sätzen = 31.12.9999',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_KREISTYP_GRUPPE_ZU_PER primary key (ART_ID, MANDANT_ID, DAT_VON, KREISTYP_GRUPPE_ID)
)COMMENT='TP2_AIS - Zeitabhängige Zuordnung der Artikel_1 zu Kreistyp und Kreistypgruppe'
;