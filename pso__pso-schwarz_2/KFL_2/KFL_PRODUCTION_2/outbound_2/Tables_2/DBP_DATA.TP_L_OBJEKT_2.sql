--==============================================================
-- Table: tp_l_objekt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_l_objekt_2
   generated from Powerdesigner on Freitag, 31. Mai 2024 09:26:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tp_l_objekt_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
tp_objekt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tp_objekt_id) NOT ENFORCED
)
OPTIONS(description='IOS - Mandantenbezogene Stammtabelle für Objekte eines technischen Platzes.             Generic table with IDs of Devices/Equipment/Machine/Area in industrial plant - anything that could be part of manifacturing process and/or subjected to maintenance.');