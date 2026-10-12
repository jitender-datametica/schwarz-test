CREATE TABLE DBP_DATA.L_AKTIVITAETSBEREICH_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	AKTIVITAETSBEREICH_ID VARCHAR(4) NOT NULL COMMENT 'Aktivitätsbereich',
	PROTOKOLLEINTRAEGE_FG INTEGER COMMENT 'Flag: Protokolleinträge erzeugen',
	JOINED_AREA_FG INTEGER COMMENT 'Flag: Aktivitätsbereiche vereinigt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Aktivitaetsbereiche'
;