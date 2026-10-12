--==============================================================
-- Table: angebot_promotion_event_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: angebot_promotion_event_zu_2
   generated from Powerdesigner on Donnerstag, 27. Februar 2025 11:10:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.angebot_promotion_event_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
angebot_nr STRING(50) NOT NULL OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'),
promotion_event_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Promotion Events.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, promotion_event_id, angebot_nr) NOT ENFORCED
)
OPTIONS(description='Beziehungstabelle zwischen dem Promotion Event und den Angeboten. Ein Angebot_2 kann einem oder mehreren Promotion Events zugeordnet sein. Ein Promotion Event besteht aus einem oder mehreren Angeboten.');