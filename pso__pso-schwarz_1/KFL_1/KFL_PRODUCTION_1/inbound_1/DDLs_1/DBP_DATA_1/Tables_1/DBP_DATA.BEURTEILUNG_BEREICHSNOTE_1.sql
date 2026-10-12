--==============================================================
-- Table: beurteilung_bereichsnote_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_bereichsnote_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEURTEILUNG_BEREICHSNOTE_1 (
   bereichsnote_id                     NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel für die Beurteilung_1 eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit).',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   beurteilung_bereich_id              NUMBER(38,0)     COMMENT 'Eindeutiger Schlüssel für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).',
   beurteilung_id                      NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel für die gesamte Beurteilung_1 eines Marktes. Es können mehrere Beurteilungen pro Markt und Tag_1 erfolgen.',
   note_bereich                        NUMBER(9,2)      COMMENT 'Schulnote für einen Bereich',
   eindruck_bereich                    VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Textfeld für den Bereichseindruck',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEURTEILUNG_BEREICHSNOTE PRIMARY KEY (bereichsnote_id) NOT ENFORCED
)  COMMENT = 'VIS - Schnellbeurteilung Bereichsnote';

