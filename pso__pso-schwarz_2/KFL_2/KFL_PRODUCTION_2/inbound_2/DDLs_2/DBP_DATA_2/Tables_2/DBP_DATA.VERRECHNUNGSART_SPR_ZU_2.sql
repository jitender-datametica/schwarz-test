--==============================================================
-- Table: verrechnungsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: verrechnungsart_spr_zu_2
   generated from Powerdesigner on Donnerstag, 22. April 2021 11:03:49
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.verrechnungsart_spr_zu_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   verrechnungsart_id                  VARCHAR(1)      collate 'en-ci' NOT NULL COMMENT 'Verrechnung: (A)utomatisch oder (M)anuell',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Sprach-ID',
   verrechnungsart_bez                 VARCHAR(50)     collate 'en-ci' NOT NULL COMMENT 'Verrechnungsart Bezeichnung'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Verrechnungsart Bezeichnung';