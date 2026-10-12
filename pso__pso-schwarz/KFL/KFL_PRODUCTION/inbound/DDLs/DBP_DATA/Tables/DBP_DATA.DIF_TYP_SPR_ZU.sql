--==============================================================
-- Table: dif_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dif_typ_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DIF_TYP_SPR_ZU (
   dif_typ_id                          NUMBER(38,0)     NOT NULL COMMENT 'DIF Typ (Mult., Add., Abs.)',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprach-ID',
   dif_typ_bez                         VARCHAR(40)      COMMENT 'DIF Typ Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DIF_TYP_SPR_ZU PRIMARY KEY (dif_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'DIF Typ Bezeichnung';

