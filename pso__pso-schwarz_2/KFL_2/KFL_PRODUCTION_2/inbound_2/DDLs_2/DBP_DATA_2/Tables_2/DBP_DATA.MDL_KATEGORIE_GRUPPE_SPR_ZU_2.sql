CREATE TABLE DBP_DATA.MDL_KATEGORIE_GRUPPE_SPR_ZU_2 (
	KATEGORIE_GRUPPE_ID NUMBER(38,0) NOT NULL COMMENT 'Gruppierung derselben Kategorien unter einer ID, wird zur Anzeige der gedrehten Hierarchie im VIS Cockpit genutzt (aus / identisch zu mdl_kategorie_gruppe_zu_2) - manuell gepflegt',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	KATEGORIE_GRUPPE_BEZ VARCHAR(80) COMMENT 'Kategorie DESC aus Medallia übertragen auf DWH-generierte kategorie_gruppe_id - manuell gepflegt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Medallia - Sprachtabelle zur Gruppierung der Kategorien zur Anzeige der gedrehten Hierarchhie im VIS Cockpit - manuell gepflegt'
;