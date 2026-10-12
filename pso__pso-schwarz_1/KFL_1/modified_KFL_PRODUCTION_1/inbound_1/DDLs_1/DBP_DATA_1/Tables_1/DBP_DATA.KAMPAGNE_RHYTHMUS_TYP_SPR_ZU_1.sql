--==============================================================
-- Table: kampagne_rhythmus_typ_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kampagne_rhythmus_typ_spr_zu_1
   generated from Powerdesigner on Samstag, 12. Oktober 2024 16:01:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KAMPAGNE_RHYTHMUS_TYP_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   kampagne_rhythmus_typ_id            INTEGER     NOT NULL COMMENT 'Numerischer Code zur Kennzeichnung der Wiederholungshäufigkeit der Kampagne.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.',
   kampagne_rhythmus_typ_bez           VARCHAR(200)     NOT NULL COMMENT 'Bezeichnung der Art_1 der Wiederholungshäufigkeit der Kampagne_1 in unterschiedlichen Sprachen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KAMPAGNE_RHYTHMUS_TYP_SPR_ZU PRIMARY KEY (mandant_id, kampagne_rhythmus_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnungen des Rhythmustyps der Kampagne_1 - manuell versorgt.';
