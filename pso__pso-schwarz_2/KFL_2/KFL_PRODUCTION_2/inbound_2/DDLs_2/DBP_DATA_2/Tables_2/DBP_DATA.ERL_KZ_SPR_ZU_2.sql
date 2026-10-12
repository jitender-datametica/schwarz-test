--==============================================================
-- Table: erl_kz_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: erl_kz_spr_zu_2
   generated from Powerdesigner on Freitag, 20. Januar 2023 16:50:30
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ERL_KZ_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   erl_kz                              VARCHAR(1)      NOT NULL COMMENT 'Erledigtkennzeichen aus SAP; Quelle: zrs_vrdata/erlkz',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'ID der Sprache',
   erl_kz_bez                          VARCHAR(50)     NOT NULL COMMENT 'Bezeichnungen der Erledigtkennzeichen aus SAP; Quelle: Datenelement zrs_rv_erlkz',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ERL_KZ_SPR_ZU PRIMARY KEY (mandant_id, erl_kz, spr_id) NOT ENFORCED
)  COMMENT = 'Sprach-Zuordnung Tabelle für Erledigtkennzeichen AS Prozess aus SAP; Quelle: zrs_rvdata - Initialbeladung anhand Datei, keine Versorgung aus SAP.';