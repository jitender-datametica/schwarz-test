--==============================================================
-- Table: l_markt_lagerbereich_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_markt_lagerbereich_1
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_markt_lagerbereich_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
markt_lagerbereich_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lagerbereich ID in der Filiale.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, markt_lagerbereich_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Lagerbereichen in der Filiale. Wird manuell beladen. Z.B. 1=Nährmittel; 2=Konserven/Essig/Öl; usw.');