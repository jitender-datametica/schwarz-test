--==============================================================
-- Table: art_matching_nielsen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_matching_nielsen
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_matching_nielsen (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_matching_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, art_matching_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  -  Sortimentstool - Zuordnung von KL-Artikel zu Nielsen-Artikel (=GTIN) über eine matching_id für den Vergleich mit Nielsen Daten (evtl. Zusammenfassung mehrere KL-Artikel zu einer matching_id)');