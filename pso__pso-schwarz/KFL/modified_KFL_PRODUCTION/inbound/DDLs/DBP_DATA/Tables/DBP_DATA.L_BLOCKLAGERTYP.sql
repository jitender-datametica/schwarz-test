--==============================================================
-- Table: l_blocklagertyp
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_blocklagertyp
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 08:22:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_BLOCKLAGERTYP (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   lagernummer_id                      VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Lagernummer/Lagerkomplex',
   blocklagertyp_id                    VARCHAR(4)      NOT NULL COMMENT 'Blocklager',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Bulk Storage Indicators  (EWM)';
