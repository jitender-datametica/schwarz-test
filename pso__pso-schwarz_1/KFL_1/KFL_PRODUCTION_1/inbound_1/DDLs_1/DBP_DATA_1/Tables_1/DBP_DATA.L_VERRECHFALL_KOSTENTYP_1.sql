--==============================================================
-- Table: l_verrechfall_kostentyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verrechfall_kostentyp_1
   generated from Powerdesigner on Donnerstag, 22. April 2021 10:54:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.l_verrechfall_kostentyp_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_im DWH',
   verrechfall_kostentyp_id            VARCHAR(1)      collate 'en-ci' NOT NULL COMMENT 'Typ: (F)ix oder (V)ariabel'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lookup Kostentyp';