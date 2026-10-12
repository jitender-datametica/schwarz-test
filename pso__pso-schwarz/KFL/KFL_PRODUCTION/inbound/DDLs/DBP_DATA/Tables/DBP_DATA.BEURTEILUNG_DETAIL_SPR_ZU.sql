--==============================================================
-- Table: beurteilung_detail_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: beurteilung_detail_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEURTEILUNG_DETAIL_SPR_ZU (
   beurteilung_detail_id               NUMBER(38,0)     NOT NULL COMMENT 'Eindeutiger Schlüssel für das Detail eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   beurteilung_detail_bez              VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung für das Detail eines Bereiches eines Marktes (z.B. Ordnung und Sauberkeit Parkplatz).',
   beurteilung_bereich_bez             VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung für den Bereich eines Marktes (z.B. Ordnung und Sauberkeit).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEURTEILUNG_DETAIL_SPR_ZU PRIMARY KEY (beurteilung_detail_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'VIS - Schnellbeurteilung Detail Sprachzuordnung';

