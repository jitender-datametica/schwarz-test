--==============================================================
-- Table: aktion_art_aktion_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_art_aktion_zu
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_art_aktion_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kl_art_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kaufland Artikelnummer'),
plan_aktion_id STRING(20) NOT NULL
OPTIONS(description='Vorläufige ID einer zukünftigen Aktion. Wird bei endgültiger Anlage im System in die sap_aktion_id geändert'),
aktion_id STRING(10) NOT NULL OPTIONS(description='Eindeutige Kennung einer Aktion aus der Quelle wakh.aktnr'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, kl_art_id, plan_aktion_id) NOT ENFORCED
)
OPTIONS(description='AIS - Aktionsartikeln wird eine Referenzaktion zugeordnet. Damit kann die Ermittlung der Aktionsmenge unterstützt werden');