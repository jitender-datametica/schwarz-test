--==============================================================
-- Table: artikelsortiment_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikelsortiment_spr_zu_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:57:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTIKELSORTIMENT_SPR_ZU_1 (
   ARTIKELSORTIMENT_ID                 VARCHAR(1)      NOT NULL COMMENT 'ARTIKELSORTIMENT ID',
   SPR_ID                              NUMBER(38,0)    NOT NULL COMMENT 'ID DER SPRACHE SPRACHSCHLÜSSEL',
   ARTIKELSORTIMENT_BEZ                VARCHAR(40)     COMMENT 'Lagersortiment Name'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Artikelsortiment Bezeichnung';
