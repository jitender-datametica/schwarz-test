--==============================================================
-- Table: bonuskauf_dimension_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_dimension_spr_zu_2
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:42:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BONUSKAUF_DIMENSION_SPR_ZU_2 (
   bonuskauf_dimension_id              VARCHAR(10)     NOT NULL COMMENT 'Produktdimension',
   spr_id                              NUMBER(38,0)    NOT NULL COMMENT 'Sprachschlüssel',
   bonuskauf_dimension_bez             VARCHAR(60)     COMMENT 'Bezeichnung Produktdimension',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'This table provides the name to the product dimension ID (Produktdimension) - shows if the discount is for one or more products
          Example: 01 = Product, 02 = Product Group, 03 = Merchandise Category';
