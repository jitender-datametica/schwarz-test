--==============================================================
-- Table: beurteilung_detailnote_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_detailnote_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEURTEILUNG_DETAILNOTE_1 (
   detailnote_id                       INTEGER     NOT NULL COMMENT 'Eindeutiger Schlüssel für die Beurteilung_1 eines Details eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).',
   beurteilung_id                      INTEGER     NOT NULL COMMENT 'Eindeutiger Schlüssel für die gesamte Beurteilung_1 eines Marktes. Es können mehrere Beurteilungen pro Markt und Tag_1 erfolgen.',
   beurteilung_detail_id               INTEGER     COMMENT 'Eindeutiger Schlüssel für das Detail eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).',
   note_detail                         NUMBER(29,2)      COMMENT 'Schulnote für das Detail eines Bereiches',
   eindruck_detail                     VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Textfeld für den Detaileindruck',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEURTEILUNG_DETAILNOTE PRIMARY KEY (detailnote_id, beurteilung_id) NOT ENFORCED
)  COMMENT = 'VIS - Schnellbeurteilung Detailnote';

