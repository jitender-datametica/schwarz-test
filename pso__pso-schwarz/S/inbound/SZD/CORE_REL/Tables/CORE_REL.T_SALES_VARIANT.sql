/* --------------------------------------------------------------------------------
   DDL for table: T_SALES_VARIANT
   generated from Powerdesigner on Montag, 31. März 2025 09:51:36
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SALES_VARIANT (
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   PARENT_PRODUCT_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   SALES_VARIANT_PRODUCT_GROUP_SID     NUMBER(38, 0)   COMMENT 'Major Entity - The sales variant group is a special product group for sales variants. - Source - LExIS',
   SALES_VARIANT_NR                    NUMBER(38, 0)   NOT NULL COMMENT 'The business identifier of the sales variant. This can be a article number from SAP or a sales GTIN number.',
   SALES_VARIANT_OLD_NR                NUMBER(38, 0)   COMMENT 'Descriptive attribute - the number of a former sales variant that was replaced by this one',
   SALES_VARIANT_NAME                  VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the sales variant.',
   GTIN_NR                             NUMBER(38, 0)   COMMENT 'Descriptive attribute - The GTIN of the sales variant',
   BASE_QUANTITY_UNIT_ID               NUMBER(38, 0)   NOT NULL COMMENT 'Id of the unit (e.g. material unit, production line parameter)',
   NET_WEIGHT_MEAS                     NUMBER(38, 5)   COMMENT 'Descriptive attribute - the net weight of the sales variant',
   NET_WEIGHT_UNIT_ID                  NUMBER(38, 0)   NOT NULL COMMENT 'Id of the unit of the net weight measure.',
   ORDER_QUANTITY_UNIT_ID              NUMBER(38, 0)   NOT NULL COMMENT 'Id of the unit of the order quantity.',
   SIZE_TXT                            VARCHAR(1000)   COMMENT 'Descriptive attribute - a text describing the size of the product',
   SIZE_UNIT_ID                        NUMBER(38, 0)   NOT NULL COMMENT 'Id of the unit of the size.',
   VOLUME_UNIT_ID                      NUMBER(38, 0)   NOT NULL COMMENT 'Id of the unit of the volume.',
   BUSINESS_VALID_FROM_DT              DATE            COMMENT 'Descriptive attribute - a date signifying from when on  sales variant is considored valid by the business',
   EARLIEST_DELIVERY_DT                DATE            COMMENT 'Descriptive attribute - the date when the sales variant can be delivered at the earliest',
   INTERNAL_OBJECT_NR                  NUMBER(38, 0)   COMMENT 'Descriptive attribute - an internal identifier from the source system',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_SALES_VARIANT PRIMARY KEY (PRODUCT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - The sales variants describes the kind of individual product, which is offered for sale. Variants of the same product may differ in their size (e.g. small, medium and large t-shirts), colour, style, flavour (e.g. strawberry and cherry yoghurt) or in certain technical details, such as a UK plug for a toaster. - Source - GTS';
