--==============================================================
-- Table: l_erl_kz_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_erl_kz_1
   generated from Powerdesigner on Freitag, 20. Januar 2023 16:48:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_ERL_KZ_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   erl_kz                              VARCHAR(1)      NOT NULL COMMENT 'Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_ERL_KZ PRIMARY KEY (mandant_id, erl_kz) NOT ENFORCED
)  COMMENT = 'Lookuptabelle Erledigtkennzeichen AS-Prozess; SAP-Quelle: zrs_rvdata - Initialbeladung anhand Datei, Keine Versorgung aus SAP.';