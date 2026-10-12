--==============================================================
-- Table: art_matching_nielsen_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_matching_nielsen_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_MATCHING_NIELSEN_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_matching_id                     INTEGER     NOT NULL COMMENT 'Gruppierungskriterium für Artikel_1 (kann auch nur ein Artikel_1 sein), die über die GTIN zu Nielsen-Artikel_1 gematched werden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_MATCHING_NIELSEN PRIMARY KEY (mandant_id, art_matching_id) NOT ENFORCED
)  COMMENT = 'EK-INT -  Sortimentstool - Zuordnung von KL-Artikel_1 zu Nielsen-Artikel_1 (=GTIN) über eine_1 matching_id für den Vergleich mit Nielsen Daten (evtl. Zusammenfassung mehrere KL-Artikel_1 zu einer matching_id)';

