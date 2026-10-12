--==============================================================
-- Table: in_auftrag_pps
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftrag_pps
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_auftrag_pps (
auftrag_id STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Auftragsnummer aus aufnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
dat_start DATE NOT NULL
OPTIONS(description='Eckstarttermin aus gstrp - the actual date when the process related to this order started'),
auftrag_rm_id BIGNUMERIC(38,0) OPTIONS(description='ID der Rückmeldung aus rueck'),
auftrag_rm_pos_id BIGNUMERIC(38,0) OPTIONS(description='Positionsid der Rückmeldung aus rmzhl'),
dat_planaufloesung DATE OPTIONS(description='Datum für Planauflösung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='LIS  - Auftragskopfdaten PPS Aufträge aus SAP Industrie afko. Tabelle wird für LIS Facility Management benötigt');