--==============================================================
-- Table: ts_nfmd_manual_price_release_log
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_manual_price_release_log
   generated from Powerdesigner on Montag, 4. Juli 2022 13:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE_LOG (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp when the record was created',
   kjwo_ww                             INTEGER    COMMENT 'Calendar year-week when the promotion campaign started. Format JJJJWW',
   user_id                             VARCHAR(255)    COMMENT 'AD name of the user who created the record',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_MANUAL_PRICE_RELEASE_LOG PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
)  COMMENT = 'Approval of the changed prices & their validity per calendar week, client';
