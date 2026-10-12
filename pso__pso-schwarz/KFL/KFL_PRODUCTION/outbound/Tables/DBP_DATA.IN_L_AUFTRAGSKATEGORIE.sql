--==============================================================
-- Table: in_l_auftragskategorie
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_auftragskategorie
   generated from Powerdesigner on Freitag, 31. Mai 2024 08:58:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_auftragskategorie (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
auftragskategorie_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, auftragskategorie_id) NOT ENFORCED
)
OPTIONS(description='LIS - Auftragskategoriekennzeichen Instandhaltung - Lookup table for types of service and maintenance orders for industrial equipment and plants.');