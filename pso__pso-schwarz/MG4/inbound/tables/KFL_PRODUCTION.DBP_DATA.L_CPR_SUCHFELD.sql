create or replace TABLE KFL_PRODUCTION.DBP_DATA.L_CPR_SUCHFELD (
	CPR_SUCHFELD_ID NUMBER(38,0) NOT NULL COMMENT 'Diese ID wird bei der Versorgung aus dem von der Quelle gelieferten Feld generiert',
	CPR_SUCHFELD VARCHAR(40) NOT NULL COLLATE 'en-ci' COMMENT 'Aus der Quelle geliefertes Suchfeld',
	CPR_SUCHFELD_AKT_FG NUMBER(38,0) NOT NULL DEFAULT 1 COMMENT 'aktiv genutzte Suchfelder',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_L_CPR_SUCHFELD primary key (CPR_SUCHFELD_ID)
)COMMENT='IOS - Lookuptabelle für das zentrals C-Projects-Suchfeld'
;