create or replace TABLE KFL_PRODUCTION.DBP_DATA.STUECKLISTE_DET_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	STUECKLISTE_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID der Stückliste',
	STUECKLISTE_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Nummer der Position der Stücklistenkomponente',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode. Die Stückliste wird im DWH historisiert.Das Datum kommt aus den SAP Feldern andat bzw. aedat',
	DAT_BIS DATE NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM_2-TT.  Die Stückliste wird im DWH historisiert.Das Datum basiert auf den SAP Feldern andat bzw. aedat',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikelnummer der Stücklistenkomponente',
	STUECKLISTE_TYP_ID VARCHAR(1) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schlüssel für die Stücklistentypen.',
	KOMPONENTENMENGE NUMBER(18,4) NOT NULL COMMENT 'Menge der Stücklistenkomponente',
	KOMPONENTENMENGE_EINH_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert.Aus meinh',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_STUECKLISTE_DET primary key (MANDANT_ID, STUECKLISTE_ID, STUECKLISTE_POS_ID, DAT_VON)
)COMMENT='TP2_AIS - Die Tabelle stueckliste_det_2 enthält die Stücklistenpositionen aus der SAP Tabelle STPO. Eine_2 Stückliste besteht aus einer oder mehreren Komponenten.'
;