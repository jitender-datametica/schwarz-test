CREATE TABLE DBP_DATA.MANDANT_2 (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	MANDANT_BEZ VARCHAR(160) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Mandanten, z.Bsp. Polen',
	MANDANT_KBEZ VARCHAR(12) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung des Mandanten, z.Bsp. PL',
	MANDANT_SAP_ID INTEGER COMMENT 'In SAP hat der Mandant_2 eine_2 zum DWH verschiedene ID. Für D in SAP 222, im DWH 1. Das Feld wurde im Rahmen des FWW-Projekts in 11/2004 hinzugefügt',
	DEFAULT_WRG VARCHAR(12) NOT NULL COLLATE 'en-ci' COMMENT 'Standardwährung für den Mandanten',
	MANDANT_SORT_ID INTEGER NOT NULL COMMENT 'Legt die Sortierreihenfolge der Mandanten fuer FrontEnd fest',
	SPAET_LIEF_TAGE INTEGER NOT NULL DEFAULT 1 COMMENT 'Akzeptanzwert der Verspätung der Lieferung in Tagen (Für IKS). Hart im DWH gepflegt, keine Regelversorgung',
	MANDANT_SB_ID INTEGER COMMENT 'Mandant_2 im System Schnellbeurteilung - ist teilweise abweichend vom DWH-Mandanten',
	MANDANT_SB_TF_ID INTEGER COMMENT 'TaskForce-Mandant_2 im System Schnellbeurteilung - ist abweichend vom DWH-Mandanten. Im SB-System werden über den TaskForce- Mandanten Berechtigungen gesteuert',
	MANDANT_ID_URSPRUNG INTEGER COMMENT 'ursprüngliche Mandant_2 ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant_2 ID von Rumänien gespeichert',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9),
	unique (MANDANT_ID)
)COMMENT='TP1_MIS - Mandant_2'
;