create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.BELOS_ADRESSE (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	BELOS_ADRESSE_ID VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Schluessel zur Identifikation einer Belos Adresse',
	LAND_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'Land, in dem sich der Markt befindet. Hat immer Länge von 2 Zeichen (PL, CZ, DE,..). Im Quellsystem SAP hat das Feld 3 Zeichen',
	ADRESS_NAME VARCHAR(60) COLLATE 'en-ci' COMMENT 'Name der Belos Adresse',
	ADRESS_NAME_ZUSATZ VARCHAR(40) COLLATE 'en-ci' COMMENT 'Namenszusatz der Belos Adresse',
	STRASSE VARCHAR(40) COLLATE 'en-ci' COMMENT 'Strasse der Belos Adresse',
	BE_ENTLADE_STELLE VARCHAR(40) COLLATE 'en-ci' COMMENT 'Be-/Entladestelle der Belos Adresse',
	PLZ VARCHAR(10) COLLATE 'en-ci' COMMENT 'Postleitzahl',
	ANSPRECHPARTNER VARCHAR(40) COLLATE 'en-ci' COMMENT 'Ansprechpartner der Belos Adresse. Compress blank',
	ORT VARCHAR(40) COLLATE 'en-ci' COMMENT 'Ort der Belos Adresse',
	SPEDITION_FG NUMBER(38,0) NOT NULL COMMENT 'Flag - der Wert 1 bedeutet, dass es sich um eine Spedition handelt',
	BELOS_STANDORT_TYP_ID NUMBER(38,0) NOT NULL DEFAULT -1 COMMENT 'ID des Belos_standorttyps. Wird im DWH vergeben',
	BELOS_ADRESSE_NUM_ID NUMBER(38,0) NOT NULL COMMENT 'numerischer Wert für die belos_adresse. Bei Märkten/Lägern ist hier die wup_id hinterlegt, ansonsten ein negativer Wert. Wird für Join-Zwecke benötigt',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BELOS_ADRESSE primary key (MANDANT_ID, BELOS_ADRESSE_ID)
)COMMENT='LIS - Stammdaten fuer die Belos Adressen. Die Eintraege haben keine Referenz zu der DWH Stammdatentabelle GP weil Belos keine Kreditorennummer liefert.'
;
