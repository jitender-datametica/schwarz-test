create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_MAN_SPANNE_PER (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel ID',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	KONDITIONSART_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
	DAT_VON DATE NOT NULL COMMENT 'gültig-ab aus gm_vld_fr',
	EK_FAKTOR NUMBER(9,4) WITH MASKING POLICY #unknown_policy COMMENT 'Faktor wird aus dem Original-Prozentwert errechnet aus kwert',
	DAT_BIS DATE NOT NULL COMMENT 'gültig-bis aus gm_vld_to',
	LOESCH_FG NUMBER(38,0) NOT NULL COMMENT 'Das Flag kennzeichnet die Kondition als gelöscht aus lvorm',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_MAN_SPANNE_PER primary key (ART_ID, MANDANT_ID, WUP_ID, NB_ID, KONDITIONSART_ID, DAT_VON)
)COMMENT='AIS_KMO - Daten der manuellen Spannenpflege auf Marktebene aus a406'
;