create or replace TABLE KFL_PRODUCTION.DBP_DATA.WUP_PLAN_TAG_1 (
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT DATE NOT NULL COMMENT 'Datum',
	PLAN_TAG_FG NUMBER(38,0) COMMENT 'Wenn die Daten bereits in der SST auf der Ebene wup_1 und Tag_1 geliefert wurden: 1, sonst  0',
	UMSATZ_NETTO_PLAN NUMBER(18,2) COMMENT 'geplanter Nettoumsatz',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	UMSATZ_NETTO_PLAN_EXTERN NUMBER(18,2) COMMENT 'umsatz_netto_plan_extern. Upload aus Excel',
	MENGE_ABSATZ_OHNE_PFAND_PLAN NUMBER(38,3) COMMENT 'Geplante Anzahl der zu verkaufenden Artikel_1 (ohne Pfand-Artikel_1) auf  Ebene Filiale/Tag.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_WUP_PLAN_TAG primary key (WUP_ID, NB_ID, MANDANT_ID, DAT)
)COMMENT='VIS - Planwerte pro Markt und Tag_1'
;