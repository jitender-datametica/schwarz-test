create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TMS_DISPOSTELLE_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_DISPOSTELLE_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Dispostelles. Auspldispst.dst_id',
	TMS_DISPOSTELLE_NAME VARCHAR(50) NOT NULL COMMENT 'Dispostelle Name',
	LAGERNUMMER_ID VARCHAR(4) COMMENT 'Lagernummer der Dispostelle',
	BESTAND_TMS_GP_ID VARCHAR(30) COMMENT 'TMS Geschäftspartner-ID des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.',
	BESTAND_TMS_GP_TYP_CD VARCHAR(3) COMMENT 'TMS Geschäftspartnertyp-Code des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TMS_DISPOSTELLE primary key (MANDANT_ID, SYSTEM_ID, TMS_DISPOSTELLE_ID)
)COMMENT='TMS - Die Tabelle enthält Informationen über die Dispositionsstellen innerhalb des Unternehmens. Diese Stellen sind verantwortlich für die Planung und Steuerung von Transportprozessen. Aus der Quelle pldispst (WANKO)'
;
