create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_GEBIETS_BETREUER_1 (
	GEBIETS_BETREUER_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Gebietsbetreuers',
	FV_FG NUMBER(38,0) COMMENT 'Flag für Eigen/Fremdverteilung. Wert = 1 ist FV',
	FV_GB_ID VARCHAR(60) COLLATE 'en-ci' COMMENT 'ID FV / GB aus NILS aus fv_gb_id',
	GBB_NAME VARCHAR(60) COLLATE 'en-ci' COMMENT '(Nach)name des Gebietsbetreuers aus fv_gb_id',
	GBB_VORNAME VARCHAR(60) COLLATE 'en-ci' COMMENT 'Vorname des Gebietsbetreuers aus vorname',
	GBB_ANREDE VARCHAR(60) COLLATE 'en-ci' COMMENT 'Anrede des Gebietsbetreuers aus text_out.salutation_uid',
	GBB_STRASSE VARCHAR(60) COLLATE 'en-ci' COMMENT 'Strasse des Gebietsbetreuers aus street',
	GBB_PLZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Postleitzahl des Gebietsbetreuers plz',
	GBB_ORT VARCHAR(60) COLLATE 'en-ci' COMMENT 'Standort des Gebietsbetreuers aus stadt',
	GBB_LAND_ID VARCHAR(2) COLLATE 'en-ci' COMMENT 'Land_1 des Gebietsbetreuers',
	MANDANT_ID NUMBER(38,0) COMMENT 'Mandant_1 im DWH',
	GBB_EMAIL VARCHAR(250) COLLATE 'en-ci' COMMENT 'email_Adresse des Gebietsbetreuers aus email',
	GBB_TEL_MOBIL VARCHAR(60) COLLATE 'en-ci' COMMENT 'Mobilnummer des Gebietsbetreuers aus tel_mobil',
	GBB_TELEFON VARCHAR(60) COLLATE 'en-ci' COMMENT 'Telefonnummer des Gebietsbetreuers  aus telefon',
	GBB_FAX VARCHAR(60) COLLATE 'en-ci' COMMENT 'Faxnummer des Gebietsbetreuers aus fax',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_GEBIETS_BETREUER primary key (GEBIETS_BETREUER_UID)
)COMMENT='GEKU - Gebietsbetreuer-Stammdaten aus der Tabelle wmd_area_responsibles'
;