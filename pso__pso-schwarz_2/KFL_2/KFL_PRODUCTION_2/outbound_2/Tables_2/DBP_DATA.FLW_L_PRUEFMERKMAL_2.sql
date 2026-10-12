--==============================================================
-- Table: flw_l_pruefmerkmal_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_pruefmerkmal_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_pruefmerkmal_2 (
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
stp_merkmal_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Stammprüfmerkmal aus mkmnr'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (werk_id, stp_merkmal_id, mandant_id, system_id) NOT ENFORCED
) OPTIONS(description='FLW - Prüfmerkmalsstamm aus qpmk');