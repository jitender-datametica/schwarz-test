CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.MANDANT_1 (
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
MANDANT_BEZ STRING(160) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Mandanten, z.Bsp. Polen'),
MANDANT_KBEZ STRING(12) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung des Mandanten, z.Bsp. PL'),
MANDANT_SAP_ID INTEGER
OPTIONS(description='In SAP hat der Mandant_1 eine_1 zum DWH verschiedene ID. Für D in SAP 222, im DWH 1. Das Feld wurde im Rahmen des FWW-Projekts in 11/2004 hinzugefügt'),
DEFAULT_WRG STRING(12) COLLATE 'und:ci' NOT NULL OPTIONS(description='Standardwährung für den Mandanten'),
MANDANT_SORT_ID INTEGER NOT NULL OPTIONS(description='Legt die Sortierreihenfolge der Mandanten fuer FrontEnd fest'),
SPAET_LIEF_TAGE INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Akzeptanzwert der Verspätung der Lieferung in Tagen (Für IKS). Hart im DWH gepflegt, keine Regelversorgung'),
MANDANT_SB_ID INTEGER
OPTIONS(description='Mandant_1 im System Schnellbeurteilung - ist teilweise abweichend vom DWH-Mandanten'),
MANDANT_SB_TF_ID INTEGER
OPTIONS(description='TaskForce-Mandant_1 im System Schnellbeurteilung - ist abweichend vom DWH-Mandanten. Im SB-System werden über den TaskForce- Mandanten Berechtigungen gesteuert'),
MANDANT_ID_URSPRUNG INTEGER
OPTIONS(description='ursprüngliche Mandant_1 ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant_1 ID von Rumänien gespeichert'),
TD_UPDATE TIMESTAMP,
TD_INSERT TIMESTAMP
) OPTIONS(description='TP1_MIS - Mandant_1');