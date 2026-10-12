create or replace TABLE KFL_PRODUCTION.DBP_DATA.STUECKLISTE_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	STUECKLISTE_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID der Stückliste',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer der Stückliste',
	STUECKLISTE_VERWENDUNG_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutiger Schlüssel für die Stücklistenverwendung',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_STUECKLISTE primary key (MANDANT_ID, STUECKLISTE_ID, DAT_VON)
)COMMENT='TP2_AIS - Die Tabelle stueckliste_1 enthält die Stücklisten aus der SAP Tabelle MAST. Aktuell werden nur die Vollgutstücklisten in das DWH übertragen'
;