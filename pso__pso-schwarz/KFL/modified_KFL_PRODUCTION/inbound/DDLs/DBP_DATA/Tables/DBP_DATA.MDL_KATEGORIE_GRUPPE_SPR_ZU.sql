CREATE TABLE DBP_DATA.MDL_KATEGORIE_GRUPPE_SPR_ZU (
	KATEGORIE_GRUPPE_ID INTEGER NOT NULL COMMENT 'Gruppierung derselben Kategorien unter einer ID, wird zur Anzeige der gedrehten Hierarchie im VIS Cockpit genutzt (aus / identisch zu mdl_kategorie_gruppe_zu) - manuell gepflegt',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	KATEGORIE_GRUPPE_BEZ VARCHAR(80) COMMENT 'Kategorie DESC aus Medallia übertragen auf DWH-generierte kategorie_gruppe_id - manuell gepflegt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='VIS - Medallia - Sprachtabelle zur Gruppierung der Kategorien zur Anzeige der gedrehten Hierarchhie im VIS Cockpit - manuell gepflegt'
;