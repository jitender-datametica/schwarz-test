create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_ROHSTOFF_MONITORING_ANZEIGE_2 (
	ROHSTOFF_NR VARCHAR(200) NOT NULL COMMENT 'Mintecs Interne ID des Rohstoffs.',
	ROHSTOFF_KATEGORIE_KFL_NAME VARCHAR(300) NOT NULL COMMENT 'Kaufland interne Kategorische Zuordnung des Rohstoffs.',
	ROHSTOFF_KFL_BEZ VARCHAR(300) NOT NULL COMMENT 'Kaufland interne Bezeichnung des Rohstoffs.',
	ROHSTOFF_SUBKATEGORIE_KFL_NAME VARCHAR(300) COMMENT 'Kaufland interne Subkategorische Zuordnung des Rohstoffs.',
	ROHSTOFF_BLEND_KFL_TXT VARCHAR(300) COMMENT 'Gemischtes Mineralölprodukt, das aus verschiedene Rohstoffe entsteht.',
	ROHSTOFF_QUALITAET_TXT VARCHAR(1000) COMMENT 'Beschreibung der Qualität des Rohstoffs.',
	ROHSTOFF_QUELL_BEZ VARCHAR(200) COMMENT 'Enthält Informationen zur Quelle des Rohstoffes.',
	ROHSTOFF_CLUSTER_ID NUMBER(38,0) COMMENT 'Rohstoffe können für eine_2 Rohstoffgruppe einem Cluster zugeordnet werden, welches als Sortierkriterium zur Anzeige im FE verwendet werden kann. Aktuell nur für rohstoff_gruppe_typ_id = 2 verwendet.',
	DAT_ANZEIGE_VON DATE COMMENT 'Gibt an, ab welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.',
	DAT_ANZEIGE_BIS DATE COMMENT 'Gibt an, bis zu welchem Datum die Zuordnung zwischen den Rohstoffengruppen in die Rohstoffberichte gültig ist.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_ROHSTOFF_MONITORING_ANZEIGE primary key (ROHSTOFF_NR, ROHSTOFF_KATEGORIE_KFL_NAME)
)COMMENT='KFL Informationen über Rohstoff.'
;
