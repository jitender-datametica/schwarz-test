CREATE TABLE DBP_DATA.LAGERPLATZ_AKTIVITAET_PER_1 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_1 im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	LAGERPLATZ_ID VARCHAR(18) NOT NULL COMMENT 'Lagerplatz',
	AKTIVITAET_ID VARCHAR(4) NOT NULL COMMENT 'Aktivität',
	DAT_VON DATE NOT NULL COMMENT 'Gültig von',
	DAT_BIS DATE COMMENT 'Gültig bis',
	LFD_NR INTEGER COMMENT 'Fortl. Nummer',
	AKTIVITAETSBEREICH_ID VARCHAR(4) COMMENT 'Aktivitätsbereich',
	LAGERTYP_ID VARCHAR(4) COMMENT 'Lagertyp',
	LAGERBEREICH_ID VARCHAR(4) COMMENT 'Lagerbereich',
	GANG_ID INTEGER COMMENT 'Gang',
	SORT_NR INTEGER COMMENT 'Sortierreihenfolge',
	ENTFERNUNG_START INTEGER COMMENT 'Entfernung zum Start',
	GANG_LAENGE INTEGER COMMENT 'Länge',
	FOLGE_GANG_ID INTEGER COMMENT 'Folgegang',
	ENTFERNUNG_FOLGEGANG INTEGER COMMENT 'Entfernung zum Folgegang',
	KONSOLIDIERUNGSGRUPPE_ID VARCHAR(10) COMMENT 'Konsolidierungsgruppe',
	ORG_AKTIVITAETSBEREICH_ID VARCHAR(4) COMMENT 'Aktivitätsbereich',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagerplätze für Bereiche und Aktivitäten'
;