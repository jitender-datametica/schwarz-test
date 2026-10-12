--==============================================================
-- Table: bonuskauf_produktvariante_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_produktvariante_spr_zu_1
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:43:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BONUSKAUF_PRODUKTVARIANTE_SPR_ZU_1 (
   bonuskauf_produktvariante_id        VARCHAR(10)     NOT NULL COMMENT 'Produktvariante',
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprachschlüssel',
   bonuskauf_produktvariante_bez       VARCHAR(60)     COMMENT 'Bezeichnung Produktvariante',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'This table provides the name to the product variety ID (Produktvariante) - means how the customer has to combine the products to get a discount
          Example: 0 = Any Products, 1 = Same Products, 2 = Different Products';
