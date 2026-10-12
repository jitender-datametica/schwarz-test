--==============================================================
-- Table: in_messpunkt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_messpunkt
   generated from Powerdesigner on Freitag, 2. Dezember 2022 01:34:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_messpunkt (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
messpunkt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Messpunkt/Measuring point. In Plant Maintenance, measuring points are located on technical objects, in other words, on pieces of equipment or functional locations.'),
tp_objekt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP'),
tp_objekt_nr STRING(30) NOT NULL OPTIONS(description='Objektnummer'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, messpunkt_id) NOT ENFORCED
)
OPTIONS(description='Table for Measuring Points (Messpunkt).              In Plant Maintenance, measuring points are located on technical objects, in other words, on pieces of equipment or functional locations.');