--==============================================================
-- Table: l_av_herkunft_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_av_herkunft_2
   generated from Powerdesigner on Monday, March 28, 2022 2:27:58 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_AV_HERKUNFT_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2 im DWH',
   av_herkunft_id                      VARCHAR(10)     NOT NULL COMMENT 'Herkunft Arbeitsvorrat',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_AV_HERKUNFT PRIMARY KEY (mandant_id, av_herkunft_id) NOT ENFORCED
)  COMMENT = 'Lookup: Arbeitsvorrat Herkunft';
