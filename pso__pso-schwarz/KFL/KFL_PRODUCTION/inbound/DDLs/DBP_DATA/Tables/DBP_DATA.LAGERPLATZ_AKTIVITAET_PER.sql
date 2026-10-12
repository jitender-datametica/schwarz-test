CREATE TABLE DBP_DATA.LAGERPLATZ_AKTIVITAET_PER (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer',
	LAGERPLATZ_ID VARCHAR(18) NOT NULL COMMENT 'Lagerplatz',
	AKTIVITAET_ID VARCHAR(4) NOT NULL COMMENT 'Aktivität',
	DAT_VON DATE NOT NULL COMMENT 'Gültig von',
	DAT_BIS DATE COMMENT 'Gültig bis',
	LFD_NR NUMBER(38,0) COMMENT 'Fortl. Nummer',
	AKTIVITAETSBEREICH_ID VARCHAR(4) COMMENT 'Aktivitätsbereich',
	LAGERTYP_ID VARCHAR(4) COMMENT 'Lagertyp',
	LAGERBEREICH_ID VARCHAR(4) COMMENT 'Lagerbereich',
	GANG_ID NUMBER(38,0) COMMENT 'Gang',
	SORT_NR NUMBER(38,0) COMMENT 'Sortierreihenfolge',
	ENTFERNUNG_START NUMBER(38,0) COMMENT 'Entfernung zum Start',
	GANG_LAENGE NUMBER(38,0) COMMENT 'Länge',
	FOLGE_GANG_ID NUMBER(38,0) COMMENT 'Folgegang',
	ENTFERNUNG_FOLGEGANG NUMBER(38,0) COMMENT 'Entfernung zum Folgegang',
	KONSOLIDIERUNGSGRUPPE_ID VARCHAR(10) COMMENT 'Konsolidierungsgruppe',
	ORG_AKTIVITAETSBEREICH_ID VARCHAR(4) COMMENT 'Aktivitätsbereich',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT='Lagerplätze für Bereiche und Aktivitäten'
;