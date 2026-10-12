--==============================================================
-- Table: art_matching_nielsen_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_matching_nielsen_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_MATCHING_NIELSEN_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_matching_id                     INTEGER     NOT NULL COMMENT 'Gruppierungskriterium für Artikel_2 (kann auch nur ein Artikel_2 sein), die über die GTIN zu Nielsen-Artikel_2 gematched werden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_MATCHING_NIELSEN PRIMARY KEY (mandant_id, art_matching_id) NOT ENFORCED
)  COMMENT = 'EK-INT -  Sortimentstool - Zuordnung von KL-Artikel_2 zu Nielsen-Artikel_2 (=GTIN) über eine_2 matching_id für den Vergleich mit Nielsen Daten (evtl. Zusammenfassung mehrere KL-Artikel_2 zu einer matching_id)';

