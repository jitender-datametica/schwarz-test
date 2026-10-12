--==============================================================
-- Table: l_versandstelle_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_versandstelle_1
   generated from Powerdesigner on Dienstag, 30. November 2021 11:31:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_versandstelle_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
versandstelle_id STRING(4) NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine_1 Gruppe_1 von Laderampen) oder um eine_1 logische Gruppierung (z.B. eine_1 Gruppe_1 von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
artikelsortiment_id STRING(1) OPTIONS(description='Artikelsortiment ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='TP408_LVS - In dieser Tabelle sind die Schlüssel der Versandstellen für die Lieferungen enthalten. - MULTISET');