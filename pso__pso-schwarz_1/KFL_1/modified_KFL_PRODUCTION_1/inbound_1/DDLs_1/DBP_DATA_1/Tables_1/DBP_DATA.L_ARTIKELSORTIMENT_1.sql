--==============================================================
-- Table: l_artikelsortiment_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_artikelsortiment_1
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ARTIKELSORTIMENT_1 (
   ARTIKELSORTIMENT_ID                 VARCHAR(1)      NOT NULL COMMENT 'Artikelsortiment ID'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Artikelsortiment Lookup';
