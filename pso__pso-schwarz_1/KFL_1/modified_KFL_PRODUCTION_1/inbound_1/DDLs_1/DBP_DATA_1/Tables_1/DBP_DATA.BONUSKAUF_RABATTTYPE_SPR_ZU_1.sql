--==============================================================
-- Table: bonuskauf_rabatttyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_rabatttyp_spr_zu
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:43:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BONUSKAUF_RABATTTYPE_SPR_ZU_1 (
   bonuskauf_rabatttype_id              VARCHAR(10)     NOT NULL COMMENT 'Rabatttyp',
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprachschlüssel',
   bonuskauf_rabatttype_bez             VARCHAR(60)     COMMENT 'Bezeichnung Rabattyp',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'shows what kind of discount the customer gets (Rabatttyp) Example: 01 = Regular Price, 02 = Discount Price, 03 = Discount Amount Off, 05 = Free';
