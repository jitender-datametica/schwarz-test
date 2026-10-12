CREATE OR REPLACE TABLE kfl_production_dbp_data.mandant_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
mandant_bez STRING(160) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Mandanten, z.Bsp. Polen'),
mandant_kbez STRING(12) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung des Mandanten, z.Bsp. PL'),
mandant_sap_id INTEGER
OPTIONS(description='In SAP hat der Mandant_1 eine_1 zum DWH verschiedene ID. Für D in SAP 222, im DWH 1. Das Feld wurde im Rahmen des FWW-Projekts in 11/2004 hinzugefügt'),
default_wrg STRING(12) COLLATE 'und:ci' NOT NULL OPTIONS(description='Standardwährung für den Mandanten'),
mandant_sort_id INTEGER NOT NULL OPTIONS(description='Legt die Sortierreihenfolge der Mandanten fuer FrontEnd fest'),
spaet_lief_tage INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Akzeptanzwert der Verspätung der Lieferung in Tagen (Für IKS). Hart im DWH gepflegt, keine Regelversorgung'),
mandant_sb_id INTEGER
OPTIONS(description='Mandant_1 im System Schnellbeurteilung - ist teilweise abweichend vom DWH-Mandanten'),
mandant_sb_tf_id INTEGER
OPTIONS(description='TaskForce-Mandant_1 im System Schnellbeurteilung - ist abweichend vom DWH-Mandanten. Im SB-System werden über den TaskForce- Mandanten Berechtigungen gesteuert'),
mandant_id_ursprung INTEGER
OPTIONS(description='ursprüngliche Mandant_1 ID DWH bezüglich des Liefersystem (SAP) - Bsp. Moldau wird im SAP-System Rumänien verwaltet, deshalb wird in diesem Feld die Mandant_1 ID von Rumänien gespeichert'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='TP1_MIS - Mandant_1');