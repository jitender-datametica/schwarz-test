--==============================================================
-- Table: kampagne_rhythmus_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_rhythmus_typ_spr_zu
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_RHYTHMUS_TYP_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   kampagne_rhythmus_typ_id            INTEGER     NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.',
   kampagne_rhythmus_typ_bez           VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung der Art der Wiederholungshäufigkeit der Kampagne in unterschiedlichen Sprachen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_RHYTHMUS_TYP_SPR_ZU PRIMARY KEY (mandant_id, kampagne_rhythmus_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne - manuell versorgt.';
