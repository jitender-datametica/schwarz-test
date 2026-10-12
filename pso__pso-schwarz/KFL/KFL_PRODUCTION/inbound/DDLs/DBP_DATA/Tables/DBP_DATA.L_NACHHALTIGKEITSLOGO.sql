--==============================================================
-- Table: l_nachhaltigkeitslogo
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_nachhaltigkeitslogo
   generated from Powerdesigner on Thursday, March 17, 2022 2:37:32 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_NACHHALTIGKEITSLOGO (
   nachhaltigkeitslogo_id              NUMBER(38,0)    NOT NULL COMMENT 'Id des Nachhaltigkeitslogos (bspw. Blauer Engel)',
   logo_kzstg                          VARCHAR(3)      DEFAULT '' NOT NULL COMMENT 'Nachhaltigkeitslogo SAP',
   nachhaltigkeitslogo_bez             VARCHAR(50)     COLLATE 'en-ci' DEFAULT ' ' NOT NULL COMMENT 'Bezeichnung des Nachhaltigkeitslogos (bspw. Blauer Engel)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_NACHHALTIGKEITSLOGO PRIMARY KEY (nachhaltigkeitslogo_id, logo_kzstg) NOT ENFORCED
)  COMMENT = 'AIS - Lookup für Nachhaltigkeitslogos. Initialbeladung durch DWH.';