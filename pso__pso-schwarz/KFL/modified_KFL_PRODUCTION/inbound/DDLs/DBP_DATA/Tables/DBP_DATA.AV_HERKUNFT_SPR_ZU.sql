--==============================================================
-- Table: av_herkunft_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: av_herkunft_spr_zu
   generated from Powerdesigner on Monday, March 28, 2022 2:29:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AV_HERKUNFT_SPR_ZU (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              VARCHAR(10)     NOT NULL COMMENT 'Sprache',
   av_herkunft_id                      VARCHAR(10)     NOT NULL COMMENT 'Herkunft Arbeitsvorrat',
   av_herkunft_bez                     VARCHAR(60)     COMMENT 'Herkunft Arbeitsvorrat Bez.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AV_HERKUNFT_SPR_ZU PRIMARY KEY (mandant_id, spr_id, av_herkunft_id) NOT ENFORCED
)  COMMENT = 'Bezeichnung: Arbeitsvorrat Herkunft';
