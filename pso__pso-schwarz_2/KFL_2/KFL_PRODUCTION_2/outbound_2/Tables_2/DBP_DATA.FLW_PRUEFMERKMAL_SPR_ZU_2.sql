--==============================================================
-- Table: flw_pruefmerkmal_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruefmerkmal_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_pruefmerkmal_spr_zu_2 (
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
stp_merkmal_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Stammprüfmerkmal aus mkmnr'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
merkmal_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung des Merkmals. Quelle ist sortfeld für Landessprache, kurztext für deutsche Übersetzung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (werk_id, stp_merkmal_id, spr_id, mandant_id, system_id) NOT ENFORCED
) OPTIONS(description='FLW - Bezeichnungen zum Prüfmerkmalsstamm aus qpmk');