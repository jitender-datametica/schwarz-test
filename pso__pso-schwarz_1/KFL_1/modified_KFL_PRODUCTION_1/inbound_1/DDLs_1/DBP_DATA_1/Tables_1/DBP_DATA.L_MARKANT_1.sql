--==============================================================
-- Table: l_markant_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_markant_1
   generated from Powerdesigner on Donnerstag, 16. September 2021 11:41:59
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_MARKANT_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   markant_id                          VARCHAR(2)      NOT NULL COMMENT 'ID Markantabrechnung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'AIS - Lookuptabelle für Markantabrechnung - manuelle Beladung';
