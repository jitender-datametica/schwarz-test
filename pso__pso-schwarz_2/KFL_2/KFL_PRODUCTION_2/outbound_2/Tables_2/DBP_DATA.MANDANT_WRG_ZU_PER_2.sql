--==============================================================
-- Table: mandant_wrg_zu_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mandant_wrg_zu_per_2
   generated from Powerdesigner on Mittwoch, 28. September 2022 14:44:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mandant_wrg_zu_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
dat_von DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL OPTIONS(description='Beginn Gültigkeitsperiode.'),
dat_bis DATE DEFAULT CAST('9999-12-31' AS DATE) NOT NULL OPTIONS(description='Ende Gültigkeitsperiode.'),
von_wrg_id STRING(3)
OPTIONS(description='Währung, die vom Quellsystem kommt und für welche die on-the-fly Konvertierung stattfinden soll. Im Grunde die abgelöste Währung.            Kurzbezeichnung der Währung, z.B. CZK, EUR.'),
umrechnungskurs BIGNUMERIC(38,5)
OPTIONS(description='Umrechnungskurs mit dem von Spalte von_wrg_id in wrg_id umgerechnet werden soll. In der Regel, der vom Land_2 offiziell verwendete Wechselkurs.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wrg_id, dat_von) NOT ENFORCED
)
OPTIONS(description='AIS - Tabelle hat mehrere Zwecke:             1. Historisierte Zuordnung von Währung zu Mandant. Wird herangezogen, sollte die Quelle zu währungsrelevanten Daten keine Währungsinformation liefern. (Das sollte eigentlich in der Tabelle mandant_2 passieren, aber die Umstellung ist zu aufwendig.)             2. Bildet im Backend die Basis für eine_2 automatische Währungskonvertierung bei Währungswechsel eines Landes und speichert dafür den vom Land_2 offiziell angegebenen Wechselkurs.             Nicht zu verwechseln mit der regulären Wechselkurstabelle kurs_2, in der auch die Konvertierung anders berechnet wird.');