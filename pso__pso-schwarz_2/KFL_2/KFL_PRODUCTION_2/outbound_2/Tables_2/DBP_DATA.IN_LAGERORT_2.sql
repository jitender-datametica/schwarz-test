--==============================================================
-- Table: in_lagerort_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_lagerort_2
   generated from Powerdesigner on Mittwoch, 17. August 2022 20:23:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_lagerort_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk'),
in_lagerort_id STRING(4) NOT NULL OPTIONS(description='Lagerort'),
in_lagerort_bez STRING(40) OPTIONS(description='Bezeichnung Technikbereich'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (in_lagerort_id, mandant_id, werk_id) NOT ENFORCED
) OPTIONS(description='Lagerorte aus SAP Industry (Tabelle T001L) mit Bezeichnung');