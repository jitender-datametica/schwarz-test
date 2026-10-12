--==============================================================
-- Table: saison_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: saison_spr_zu_2
   generated from Powerdesigner on Montag, 14. März 2022 11:26:26
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SAISON_SPR_ZU_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   saison_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'ID der Saison aus saiso, z.Bsp 9',
   spr_id                              INTEGER    NOT NULL COMMENT 'ID der Sprache',
   saison_bez                          VARCHAR(30)     COLLATE 'en-ci' COMMENT 'Bezeichnung des Saisonkennzeichens, z.Bsp Sommer',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SAISON_SPR_ZU PRIMARY KEY (mandant_id, saison_id, spr_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Sprachabhängige Bezeichnungen der Saison';