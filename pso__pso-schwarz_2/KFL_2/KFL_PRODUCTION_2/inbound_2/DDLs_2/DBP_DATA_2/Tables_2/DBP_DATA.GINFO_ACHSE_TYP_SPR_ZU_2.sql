--==============================================================
-- Table: ginfo_achse_typ_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ginfo_achse_typ_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GINFO_ACHSE_TYP_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.',
   ginfo_achse_typ_id                  VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Angabe der Einheit des Achsenwertes. Z.Bsp lfm oder Stk',
   ginfo_achse_typ_bez                 VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Achsentyps. Z.Bsp laufende Meter',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GINFO_ACHSE_TYP_SPR_ZU PRIMARY KEY (mandant_id, spr_id, ginfo_achse_typ_id) NOT ENFORCED
)  COMMENT = 'IOS - Sprachabhängige Bezeichnung des Achsentyps';
