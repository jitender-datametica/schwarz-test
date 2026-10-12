create or replace TABLE KFL_PRODUCTION.DBP_DATA.MANDANT (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	MANDANT_BEZ VARCHAR(160) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Mandanten, z.Bsp. Polen',
	MANDANT_KBEZ VARCHAR(12) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung des Mandanten, z.Bsp. PL',
	MANDANT_SAP_ID NUMBER(38,0) COMMENT 'In SAP hat der Mandant eine zum DWH verschiedene ID. Für D in SAP 222, im DWH 1. Das Feld wurde im Rahmen des FWW-Projekts in 11/2004 hinzugefügt',
	DEFAULT_WRG VARCHAR(12) NOT NULL COLLATE 'en-ci' COMMENT 'Standardwährung für den Mandanten',
	MANDANT_SORT_ID NUMBER(38,0) NOT NULL COMMENT 'Legt die Sortierreihenfolge der Mandanten fuer FrontEnd fest',
	SPAET_LIEF_TAGE NUMBER(38,0) NOT NULL DEFAULT 1 COMMENT 'Akzeptanzwert der Verspätung der Lieferung in Tagen (Für IKS). Hart im DWH gepflegt, keine Regelversorgung',
	MANDANT_SB_ID NUMBER(38,0) COMMENT 'Mandant im System Schnellbeurteilung - ist teilweise abweichend vom DWH-Mandanten',
	MANDANT_SB_TF_ID NUMBER(38,0) COMMENT 'TaskForce-Mandant im System Schnellbeurteilung - ist abweichend vom DWH-Mandanten. Im SB-System werden über den TaskForce- Mandanten Berechtigungen gesteuert',
	MANDANT_ID_URSPRUNG NUMBER(38,0) COMMENT 'ursprüngliche Mandant ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant ID von Rumänien gespeichert',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9),
	unique (MANDANT_ID)
)COMMENT='TP1_MIS - Mandant'
;