CREATE OR REPLACE TABLE WUP_TAG_WBS_SETTING_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL,
	NON_ADJUSTABLE_DAY_FG INTEGER NOT NULL COMMENT 'Flag: Datum ist für die Nachversorgung als \"non adjustable\" markiert',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Steuertabelle WBS'
;