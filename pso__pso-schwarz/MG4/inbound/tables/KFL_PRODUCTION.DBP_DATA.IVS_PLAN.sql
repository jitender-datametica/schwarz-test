create or replace TABLE KFL_PRODUCTION.DBP_DATA.IVS_PLAN (
	PLANDETAIL_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID fuer ein Plandetail',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant',
	PLANTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID des Plantyps',
	PLAN_OBJEKT_ID VARCHAR(50) NOT NULL COMMENT 'ID, auf der geplant wird. Kann zb. eine Kostenstelle aus TP4 oder Flaeche aus TP5 sein.',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahr und Monat',
	PLAN_WERT NUMBER(18,2) COMMENT 'Geplanter Wert in Landeswährung',
	PLAN_WERT_KONZ NUMBER(18,2) COMMENT 'Geplanter Wert in Konzernwährung',
	KOSTENSTELLE_ID VARCHAR(20) NOT NULL COMMENT 'Eindeutige ID der Kostenstelle (aus SAP, Paisy-Kostenstellen werden auf SAP-Kostenstellen gemappt, bzw. fuer einige Faelle die Hyperion-Kostenstelle)',
	DAT_EXTRAKT DATE NOT NULL COMMENT 'Extraktions- bzw. Erstellungsdatum des Datensatzes',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	constraint PK_IVS_PLAN primary key (PLANTYP_ID, PLANDETAIL_ID, MANDANT_ID, PLAN_OBJEKT_ID)
)COMMENT='IVS - Plandaten Köpfe, Kosten, Stunden'
;