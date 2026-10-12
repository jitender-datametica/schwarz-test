create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TMS_FAHRZEUG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_FAHRZEUG_ID VARCHAR(20) NOT NULL COMMENT 'ID des Fahrzeugs (Fahrzeugnummer). Aus plfaz.nr',
	TMS_FAHRZEUG_LFD_NR NUMBER(38,0) NOT NULL COMMENT 'SKey für die Tabelle tms_fahrzeug_1 im Quellsystem. Aus plfaz.faz_id',
	TMS_FAHRZEUGTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Fahrzeugtyp',
	TMS_FAHRZEUG_TRAILER_ID VARCHAR(20) COMMENT 'Hängernummer 1',
	SPEDITEUR_TMS_GP_ID VARCHAR(30) COMMENT 'ID des tms_gp_1, welcher hier als Spediteur auftrifft',
	SPEDITEUR_TMS_GP_TYP_CD VARCHAR(3) COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Spediteur auftrifft. immer \""S\"" (Typ = S Spediteur)',
	VERBRAUCH_PRO_100KM NUMBER(5,2) COMMENT 'Verbrauch pro 100 Km',
	TMS_TREIBSTOFF_ID NUMBER(38,0) COMMENT 'Treibstoffart (Diesel, Benzin, usw.)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TMS_FAHRZEUG primary key (MANDANT_ID, SYSTEM_ID, TMS_FAHRZEUG_ID)
)COMMENT='TMS - Die Tabelle enthält Informationen über die Fahrzeuge im System, einschließlich Fahrzeugtyp, Spediteur, Anhänger und Verbrauchsinformationen. Es handelt sich um konkrete Fahrzeuge (bei KFL vmtl. eher generische Objekte wie z. B. \""Elektro-LKW\"" oder \""LKW Diesel 40t\""). Aus der Quelle plfaz (WANKO)'
;
