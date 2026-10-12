--==============================================================
-- Table: fremd_lagerort_artikelsortiment_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fremd_lagerort_artikelsortiment_zu_2
   generated from Powerdesigner on Mittwoch, 21. April 2021 15:57:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FREMD_LAGERORT_ARTIKELSORTIMENT_ZU_2 (
   MANDANT_ID                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   FREMD_LAGERORT_ID                   VARCHAR(4)      NOT NULL COMMENT 'Fremdlagerort',
   ARTIKELSORTIMENT_ID                 VARCHAR(1)      NOT NULL COMMENT 'Artikelsortiment ID'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'fremd_lagerort_artikelsortiment_zu_2';
