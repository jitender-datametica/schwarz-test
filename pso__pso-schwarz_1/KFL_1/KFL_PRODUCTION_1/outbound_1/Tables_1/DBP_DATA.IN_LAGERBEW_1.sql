--==============================================================
-- Table: in_lagerbew_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_lagerbew_1
   generated from Powerdesigner on Freitag, 17. März 2023 11:16:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_lagerbew_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
lagerbew_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung.'),
kj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahr, Format JJJJ'),
dat_buch DATE NOT NULL
OPTIONS(description='Datum, unter dem der Beleg in der Buchhaltung bzw. in der Kostenrechnung_1 erfasst wird. Quelle ist mkpf.budat'),
dat_erfasst DATE NOT NULL
OPTIONS(description='Gibt das Datum an, an dem der Materialbeleg erfasst wurde. Quelle ist mkpf.cpudt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagerbew_beleg_id, kj) NOT ENFORCED
) OPTIONS(description='BIS- Lagerbewegungen Kopfdaten aus Quelle SAP mkpf ');