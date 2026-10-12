--==============================================================
-- Table: tp_objekt_status_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tp_objekt_status_per_1
   generated from Powerdesigner on Donnerstag, 18. August 2022 08:45:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tp_objekt_status_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
tp_objekt_nr STRING(22) NOT NULL OPTIONS(description='Objektnummer'),
tp_objekt_status_id STRING(5) NOT NULL OPTIONS(description='Systemstatus'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Datensatz gültig ist'),
dat_bis DATE OPTIONS(description='Gültig bis'),
tp_objekt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'),
tp_objekt_status_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen: Status_1 inaktiv'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tp_objekt_nr, tp_objekt_status_id, dat_von) NOT ENFORCED
)
OPTIONS(description='Objektstatus SAP Industry (Tabelle JEST, gefiltert auf OBJNR die mit "IE" beginnen, also Equipments) - enthält (historisiert) den bzw. die Status_1 (mehrere sind möglich) pro Objekt');