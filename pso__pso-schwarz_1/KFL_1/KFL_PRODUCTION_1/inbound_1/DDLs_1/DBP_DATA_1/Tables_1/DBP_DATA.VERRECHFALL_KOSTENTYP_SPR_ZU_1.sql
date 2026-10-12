--==============================================================
-- Table: verrechfall_kostentyp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verrechfall_kostentyp_spr_zu_1
   generated from Powerdesigner on Donnerstag, 22. April 2021 10:57:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.verrechfall_kostentyp_spr_zu_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   verrechfall_kostentyp_id            VARCHAR(1)      collate 'en-ci' NOT NULL COMMENT 'Typ: (F)ix oder (V)ariabel',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Sprach-ID',
   verrechfall_kostentyp_bez           VARCHAR(50)     collate 'en-ci' NOT NULL COMMENT 'Kostentyp Bezeichnung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Kostentyp Bezeichnung';