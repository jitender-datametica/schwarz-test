--==============================================================
-- Table: flw_produktgruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_produktgruppe_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_produktgruppe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
produktgruppe_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Produktguppe Id aus prodgr'),
hauptgruppe_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hauptgruppe = oberste Hierarchiestufe der Fleischwerk- Produkthierarchie. Entspricht der Tierart'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='FLW - Produktgruppen sind eine_1 Gruppierung von Produkthierarchien beliebiger Stufe aus zfw_prodgr');