--==============================================================
-- Table: art_matching_nielsen_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_matching_nielsen_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_matching_nielsen_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_matching_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Zuordnung von KL-Artikel_1 zu Nielsen-Artikel_1 (=GTIN) über eine_1 matching_id für den Vergleich mit Nielsen Daten (evtl. Zusammenfassung mehrere KL-Artikel_1 zu einer matching_id)');