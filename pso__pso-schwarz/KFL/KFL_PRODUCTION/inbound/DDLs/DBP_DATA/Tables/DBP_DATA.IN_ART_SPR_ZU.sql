--==============================================================
-- Table: in_art_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_art_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_ART_SPR_ZU (
   in_art_id                           NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige Kennzeichnung der Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   art_bez                             VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Materialkurztext. Quelle ist makt.maktx',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_ART_SPR_ZU PRIMARY KEY (in_art_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'BIS - Artikeltexte aus makt';
