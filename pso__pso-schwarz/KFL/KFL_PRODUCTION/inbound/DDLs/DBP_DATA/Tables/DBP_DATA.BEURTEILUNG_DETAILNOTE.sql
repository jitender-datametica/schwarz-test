--==============================================================
-- Table: beurteilung_detailnote
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_detailnote
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEURTEILUNG_DETAILNOTE (
   detailnote_id                       NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel für die Beurteilung eines Details eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).',
   beurteilung_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel für die gesamte Beurteilung eines Marktes. Es können mehrere Beurteilungen pro Markt und Tag erfolgen.',
   beurteilung_detail_id               NUMBER(38,0)     COMMENT 'Eindeutiger Schlüssel für das Detail eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).',
   note_detail                         NUMBER(9,2)      COMMENT 'Schulnote für das Detail eines Bereiches',
   eindruck_detail                     VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Textfeld für den Detaileindruck',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEURTEILUNG_DETAILNOTE PRIMARY KEY (detailnote_id, beurteilung_id) NOT ENFORCED
)  COMMENT = 'VIS - Schnellbeurteilung Detailnote';

