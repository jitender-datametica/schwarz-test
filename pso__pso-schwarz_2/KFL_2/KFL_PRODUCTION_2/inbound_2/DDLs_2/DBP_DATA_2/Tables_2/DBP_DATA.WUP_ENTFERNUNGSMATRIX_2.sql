create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WUP_ENTFERNUNGSMATRIX_2 (
	WUP_ID_A NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
	WUP_ID_B NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet fuer Beziehung Lager zu Verteilzentrum',
	NB_ID_A NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer die Nebenbetriebskennziffer',
	NB_ID_B NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID_A NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	MANDANT_ID_B NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	DISTANZ_FAHRWEG_KM NUMBER(11,3) NOT NULL DEFAULT 0 COMMENT 'Entfernung in auf Straßen zurückzulegenden Kilometern zwischen den zwei Standorten A und B',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	DAUER_FAHRZEIT_MIN NUMBER(38,0) COMMENT 'Dauer der Fahrzeit in Minuten zwischen den zwei Standorten A und B',
	MAUT_KM NUMBER(11,3) COMMENT 'Anzahl mautpflichtiger Kilometer von DISTANZ_FAHRWEG_KM',
	constraint PK_WUP_ENTFERNUNGSMATRIX primary key (WUP_ID_A, WUP_ID_B, NB_ID_A, NB_ID_B, MANDANT_ID_A, MANDANT_ID_B)
)COMMENT='Entfernung (Fahrkilometer) zwischen zwei beliebigen Standorten'
;
