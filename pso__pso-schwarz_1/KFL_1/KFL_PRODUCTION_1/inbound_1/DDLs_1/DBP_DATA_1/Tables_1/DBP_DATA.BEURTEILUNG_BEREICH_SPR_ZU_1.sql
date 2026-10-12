--==============================================================
-- Table: beurteilung_bereich_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_bereich_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEURTEILUNG_BEREICH_SPR_ZU_1 (
   beurteilung_bereich_id              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   beurteilung_bereich_bez             VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEURTEILUNG_BEREICH_SPR_ZU PRIMARY KEY (beurteilung_bereich_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Schnellbeurteilung Bereich Sprachzuordnung';

