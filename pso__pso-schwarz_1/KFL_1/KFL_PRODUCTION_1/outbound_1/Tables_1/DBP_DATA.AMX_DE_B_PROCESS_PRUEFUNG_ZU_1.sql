--==============================================================
-- Table: amx_de_b_process_pruefung_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_b_process_pruefung_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_de_b_process_pruefung_zu_1 (
business_process_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID des Geschäftsprozesses'),
pruefung_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID der Prüfung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (business_process_id, pruefung_id) NOT ENFORCED
)
OPTIONS(description='KMR - Audimex. Bildet n:m Beziehungen für business_process_id und Pruefungen ab für Kurzcheck DE Daten');