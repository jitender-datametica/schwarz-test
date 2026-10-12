--==============================================================
-- Table: artikeltyp_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikeltyp_spr_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTIKELTYP_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   artikeltyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Klassifizierung des Artikels, z.Bsp. Displayartikel',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   artikeltyp_bez                      VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Artikeltyps, z.Bsp. Displayartikel',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTIKELTYP_SPR_ZU PRIMARY KEY (mandant_id, artikeltyp_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Sprachabhängige Bezeichnungen des Artikeltyps';

