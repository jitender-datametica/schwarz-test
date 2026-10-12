create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TMS_GP_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_GP_ID VARCHAR(30) NOT NULL COMMENT 'ID des Geschäftspartners. Aus plkd.nr',
	TMS_GP_TYP_CD VARCHAR(3) NOT NULL COMMENT 'Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)',
	TMS_GP_LFD_NR NUMBER(38,0) NOT NULL COMMENT 'SKey für die Tabelle tms_gp_1 im Quellsystem. Aus plkd.kd_id',
	TMS_GP_NAME VARCHAR(50) NOT NULL COMMENT 'Name des Geschäftspartners',
	TMS_GP_ALTNV_NAME VARCHAR(50) COMMENT 'Alternativer Name des Geschäftspartners',
	TMS_GP_STRASSE VARCHAR(50) COMMENT 'Straße des Geschäftspartners Adresse',
	TMS_GP_ORT_NAME VARCHAR(50) COMMENT 'Ort des Geschäftspartners Adresse',
	TMS_GP_PLZ VARCHAR(20) COMMENT 'Postleitzahl des Geschäftspartners Adresse',
	TMS_LAND_CD VARCHAR(5) COMMENT 'Länderkennzeichen',
	SPERR_FG NUMBER(38,0) COMMENT 'Kennzeichnung für Sperrung des Kunden',
	SAMMELBELEG_ID NUMBER(38,0) COMMENT 'Kennzeichen für Sammelbelege (aktuell nur J/N/leer)',
	TMS_STANDORTTYP_ID NUMBER(38,0) COMMENT 'Standort-Typ (Außenlager, VZ, FLW, Markt,…)',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TMS_GP primary key (MANDANT_ID, SYSTEM_ID, TMS_GP_ID, TMS_GP_TYP_CD)
)COMMENT='TMS - Die Tabelle enthält die Informationen über Geschäftspartner (z. B. Lager, Spediteure, Märkte) im System, einschließlich Adressen, Sperr_fg und Standorttyp. Aus der Quelle plkd (WANKO)'
;
