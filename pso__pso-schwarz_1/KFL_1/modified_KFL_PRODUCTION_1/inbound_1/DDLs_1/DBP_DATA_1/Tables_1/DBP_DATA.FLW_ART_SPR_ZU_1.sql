--==============================================================
-- Table: flw_art_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ART_SPR_ZU_1 (
   flw_art_id                          INTEGER     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   spr_id                              INTEGER     NOT NULL COMMENT 'Eindeutige Kennzeichnung der Sprache',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   art_bez                             VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Materialkurztext. Quelle ist makt.maktx',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ART_SPR_ZU PRIMARY KEY (flw_art_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Artikeltexte aus makt_1';

