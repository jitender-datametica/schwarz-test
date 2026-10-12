create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_GP_NM_ZU_PER (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'DWH Artikelnummer',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT_VON DATE NOT NULL COMMENT 'Beginn der Gültigkeitsperiode\n            ',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
	DAT_BIS DATE NOT NULL COMMENT 'Datum, bis zu dem die Zuordnung gilt. Bei aktuellen Zuordnungen: 9999-12-31',
	VZ_WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Verteilzentrum, von dem der Artikel beschafft wird. Falls der Artikel nicht aus einem VZ kommt, ist in diesem Feld der Markt selbst gespeichert',
	BQ_FINDUNG_ID NUMBER(38,0) NOT NULL COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess',
	BEZUGSWEG_ID NUMBER(38,0) NOT NULL COMMENT 'Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_GP_NM_ZU_PER primary key (MANDANT_ID, ART_ID, WUP_ID, NB_ID, DAT_VON)
)COMMENT='TP2_AIS - Artikel - Lieferanten-Zuordnung mit n:m - Beziehung. Enthält den Markt zur Herstellung der Eindeutigkeit. (entspricht etwa Tabelle art_gp_zu_per plus wup_id)'
;