create or replace TABLE KFL_PRODUCTION.DBP_DATA.MDL_FRAGE_ANTWORT_ZU_2 (
	FRAGE_ID NUMBER(38,0) NOT NULL COMMENT 'Frage ID aus Medallia',
	ANTWORT_ID NUMBER(38,0) NOT NULL COMMENT 'Antwort ID aus Medallia',
	NOK_FG NUMBER(38,0) NOT NULL DEFAULT 0 COMMENT 'Manuell gepflegtes Feld, sagt aus, ob Antwort einer Frage ohne (0) oder mit (1) Feststellung ist. Default ist ohne Feststellung',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='KMR - Medallia - Zuordnungstabelle von Frage zu Antwort; welche Antwortmöglichkeiten gibt es bei einer Frage'
;