--==============================================================
-- Table: angebot_promotion_event_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_promotion_event_zu
   generated from Powerdesigner on Donnerstag, 27. Februar 2025 11:10:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.angebot_promotion_event_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
promotion_event_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Promotion Events.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, promotion_event_id, angebot_nr) NOT ENFORCED
)
OPTIONS(description='Beziehungstabelle zwischen dem Promotion Event und den Angeboten. Ein Angebot kann einem oder mehreren Promotion Events zugeordnet sein. Ein Promotion Event besteht aus einem oder mehreren Angeboten.');