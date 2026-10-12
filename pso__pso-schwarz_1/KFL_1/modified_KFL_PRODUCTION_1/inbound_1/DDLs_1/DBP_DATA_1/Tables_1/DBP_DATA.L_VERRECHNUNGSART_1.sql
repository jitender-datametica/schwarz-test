--==============================================================
-- Table: l_verrechnungsart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_verrechnungsart_1
   generated from Powerdesigner on Donnerstag, 22. April 2021 11:00:23
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.l_verrechnungsart_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   verrechnungsart_id                  VARCHAR(1)      collate 'en-ci' NOT NULL COMMENT 'Verrechnung: (A)utomatisch oder (M)anuell'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Lookup Verrechnungsart';