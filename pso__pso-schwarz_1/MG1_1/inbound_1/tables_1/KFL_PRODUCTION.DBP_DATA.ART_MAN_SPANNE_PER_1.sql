create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_MAN_SPANNE_PER_1 (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 ID',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	KONDITIONSART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
	DAT_VON DATE NOT NULL COMMENT 'gültig-ab aus gm_vld_fr',
	EK_FAKTOR NUMBER(9,4) WITH MASKING POLICY #unknown_policy COMMENT 'Faktor wird aus dem Original-Prozentwert errechnet aus kwert',
	DAT_BIS DATE NOT NULL COMMENT 'gültig-bis aus gm_vld_to',
	LOESCH_FG NUMBER(38,0) NOT NULL COMMENT 'Das Flag kennzeichnet die Kondition als gelöscht aus lvorm',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_MAN_SPANNE_PER primary key (ART_ID, MANDANT_ID, KONDITIONSART_ID, DAT_VON)
)COMMENT='AIS_KMO - Faktoren zur EK Bewertung auf Ebene Artikel_1 der manuellen Spannenpflege aus a445'
;