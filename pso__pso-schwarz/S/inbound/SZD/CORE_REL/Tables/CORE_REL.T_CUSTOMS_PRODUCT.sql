/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_PRODUCT
   generated from Powerdesigner on Dienstag, 19. Dezember 2023 09:34:35
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_PRODUCT (
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the customs product.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CUSTOMS_PRODUCT_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs product type.',
   ORIGIN_COUNTRY_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) for the political country.',
   CONSIGNOR_STREAM_CD                 VARCHAR(50)     NOT NULL COMMENT 'The unique code of the of the consignor stream.',
   CUSTOMS_CLASSIFICATION_SCHEME_CD    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the customs classification scheme.',
   CUSTOMS_TARIFF_CODE_CD              VARCHAR(250)    NOT NULL COMMENT 'Natural/Business Key - The standardized customs tariff code number.',
   PRODUCT_VARIANT_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant. This only applies when the customs product is a GTS product.',
   PARENT_PRODUCT_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product. This only applies when the customs product is a WWT product.',
   CUSTOMS_PRODUCT_NR                  VARCHAR(250)    NOT NULL COMMENT 'Natural/Business Key - The product number from the GTS report or GS Upload',
   ADDITIONAL_CD                       VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key - An additional customized code from the source which specialized the product.',
   CUSTOMS_PRODUCT_NAME                VARCHAR(250)    NOT NULL COMMENT 'The name/description of the customs product provided by the GS upload.',
   PREFERENTIAL_ORIGIN_FG              BOOLEAN         COMMENT 'Flag that shows whether the supplier can provide proof of preference or not.',
   ALLOCATION_CNT                      NUMBER(38,0)    COMMENT 'The count of pieces in a carton of this product.',
   VOLUME_UNIT_QTY                     NUMBER(38, 5)   COMMENT 'The volume of a unit of the product (e.g. size of a bottle).',
   VOLUME_UNIT_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'The ID of the unit of measure of the product (WWT only)',
   ALCOHOLIC_BEVERAGE_TAX_RATE_CD      VARCHAR(50)     NOT NULL COMMENT 'The unique code of the tax rate for alcoholic beverages within the country.',
   ALCOHOLIC_BEVERAGE_PCT              NUMBER(38, 5)   COMMENT 'The percentage of alcohol within an alcoholic beverage,',
   ALCOHOLIC_BEVERAGE_ADJUSTED_PCT     NUMBER(38, 5)   COMMENT 'The adjusted percentage of alcohol within an alcoholic beverage,',
   ALCOHOLIC_BEVERAGE_VOLUME_QTY       NUMBER(38, 5)   COMMENT 'The volume of the bottle/jar of the alcoholic beverage.',
   ALCOHOLIC_BEVERAGE_VOLUME_LPA_QTY   NUMBER(38, 5)   COMMENT 'The volume of pure alcohol in the bottle/jar of the alcoholic beverage.',
   ALCOHOLIC_BEVERAGE_UOM_ID           NUMBER(38, 0)   NOT NULL COMMENT 'The ID of the unit of measure for the alcoholic beverage.',
   ALCOHOLIC_BEVERAGE_DUTY_PER_LPA_VAL NUMBER(38, 5)   COMMENT 'The amount of duty per liter of pure alcohol.',
   ALCOHOLIC_BEVERAGE_DUTY_PER_UNIT_VAL NUMBER(38, 8)   COMMENT 'The amount of duty per unit (bottle/jar).',
   SPECIAL_EXCISE_RATE_VAL             NUMBER(38, 8)   COMMENT 'A special excise rate to be used to calculate the excise duty for this product. If NULL, the excise rate provided by the tax code is used.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_PRODUCT PRIMARY KEY (PRODUCT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - The customs product is a special product definition used in the "Foreign Trade" solution to cover both GTS and WWT products. - Source - GS-Upload, GTS/WWT, Excel Report from CDS, Broker (per Mail)';
