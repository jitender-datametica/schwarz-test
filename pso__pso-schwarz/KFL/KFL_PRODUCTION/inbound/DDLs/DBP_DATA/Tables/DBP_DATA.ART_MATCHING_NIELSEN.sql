--==============================================================
-- Table: art_matching_nielsen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_matching_nielsen
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_MATCHING_NIELSEN (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   art_matching_id                     NUMBER(38,0)     NOT NULL COMMENT 'Gruppierungskriterium für Artikel (kann auch nur ein Artikel sein), die über die GTIN zu Nielsen-Artikel gematched werden',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_MATCHING_NIELSEN PRIMARY KEY (mandant_id, art_matching_id) NOT ENFORCED
)  COMMENT = 'EK-INT -  Sortimentstool - Zuordnung von KL-Artikel zu Nielsen-Artikel (=GTIN) über eine matching_id für den Vergleich mit Nielsen Daten (evtl. Zusammenfassung mehrere KL-Artikel zu einer matching_id)';

