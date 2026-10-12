create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.L_LAGERNUMMER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	OUG_FG NUMBER(38,0) NOT NULL COMMENT 'Flag zur Kennzeichnung von Obst- und Gemüselägern. Kommt nicht aus SAP. Wird direkt im DWH gepflegt.',
	DUMMY_TOR_ID NUMBER(38,0) COMMENT 'Dummy_1 Tor aus ZLV_BSF_GLOBAL ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	SCU_ID VARCHAR(20) COMMENT 'Supply-Chain-Unit_1',
	SCU_GUID VARCHAR(32) COMMENT 'GUID für Supply-Chain-Unit_1',
	SORT_ID VARCHAR(3) COMMENT 'ID für Gruppierung und Sortierung im Frontend, wird im DWH gepflegt - 1. Stelle=Sortiment, 2. Stelle=Land_1, 3. Stelle = Lfd. Nr.',
	EWM_FG NUMBER(38,0) DEFAULT 0 COMMENT 'Indicates if the LGNUM is an SAP EWM-run warehouse',
	PERS_TEILBEREICH_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
	constraint PK_L_LAGERNUMMER primary key (MANDANT_ID, LAGERNUMMER_ID, WUP_ID, NB_ID)
)COMMENT='TP408_LVS - Lookuptabelle der Lagernummern aus der SAP Tabelle lagp'
;
