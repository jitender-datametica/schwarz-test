--==============================================================
-- Table: art_matching_nielsen_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_matching_nielsen_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_matching_nielsen_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
art_matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_matching_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Zuordnung von KL-Artikel_2 zu Nielsen-Artikel_2 (=GTIN) über eine_2 matching_id für den Vergleich mit Nielsen Daten (evtl. Zusammenfassung mehrere KL-Artikel_2 zu einer matching_id)');