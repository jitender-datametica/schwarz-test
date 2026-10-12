--==============================================================
-- Table: dispo_arttyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dispo_arttyp_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:47 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DISPO_ARTTYP_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant    ',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprachschlüssel',
   dispo_arttyp_id                     NUMBER(38,0)     NOT NULL COMMENT 'Typ  ',
   dispo_arttyp_bez                    VARCHAR(60)      COMMENT 'Typ Bez.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DISPO_ARTTYP_SPR_ZU PRIMARY KEY (mandant_id, spr_id, dispo_arttyp_id) NOT ENFORCED
)  COMMENT = 'VZ-Dispo Artikeltyp Texte (DD07V Domname ZSCM_DC_ARTTYPE)';
