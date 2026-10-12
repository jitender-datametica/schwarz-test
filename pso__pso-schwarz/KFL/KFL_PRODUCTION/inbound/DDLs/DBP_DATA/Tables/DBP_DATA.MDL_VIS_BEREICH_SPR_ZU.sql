CREATE TABLE DBP_DATA.MDL_VIS_BEREICH_SPR_ZU (
   BEREICH_ID                          NUMBER(38,0)    NOT NULL COMMENT 'Bereich ID ',
   SPR_ID                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Sprache',
   BEREICH_BEZ                         VARCHAR(80)     COMMENT 'Bereich DESC'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Sprachenabhängige Bezeichnungen der Bereiche';