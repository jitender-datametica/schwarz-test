CREATE TABLE DBP_DATA.MDL_FRAGE_ANTWORT_ZU (
	FRAGE_ID INTEGER NOT NULL COMMENT 'Frage ID aus Medallia',
	ANTWORT_ID INTEGER NOT NULL COMMENT 'Antwort ID aus Medallia',
	NOK_FG INTEGER NOT NULL DEFAULT 0 COMMENT 'Manuell gepflegtes Feld, sagt aus, ob Antwort einer Frage ohne (0) oder mit (1) Feststellung ist. Default ist ohne Feststellung',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='KMR - Medallia - Zuordnungstabelle von Frage zu Antwort; welche Antwortmöglichkeiten gibt es bei einer Frage'
;