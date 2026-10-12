/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SALES_VARIANT
   generated from Powerdesigner on Mittwoch, 30. Juli 2025 09:40:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SALES_VARIANT (
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   SALES_VARIANT_PRODUCT_GROUP_SID     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the item family.',
   SALES_VARIANT_NR                    NUMBER(38, 0)   NOT NULL COMMENT 'The business identifier of the sales variant. This can be a article number from SAP or a sales GTIN number.',
   SALES_VARIANT_NAME                  VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the sales variant.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source.',   
   CONSTRAINT PK_DIM_SALES_VARIANT PRIMARY KEY (PRODUCT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - The sales variants describes the kind of individual product, which is offered for sale. Variants of the same product may differ in their size (e.g. small, medium and large t-shirts), colour, style, flavour (e.g. strawberry and cherry yoghurt) or in certain technical details, such as a UK plug for a toaster. - Source - GTS, SAP RAN 900/878';
