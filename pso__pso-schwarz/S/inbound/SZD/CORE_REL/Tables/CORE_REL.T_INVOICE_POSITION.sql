/* --------------------------------------------------------------------------------
   DDL for table: T_INVOICE_POSITION
   generated from Powerdesigner on Montag, 12. Februar 2024 09:21:29
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INVOICE_POSITION (
   FINANCE_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the invoice position.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   INVOICE_FINANCE_SID                 NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the invoice that contains this position.',
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product.',
   ORIGIN_COUNTRY_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country.',
   EXPORT_WAREHOUSE_RESOURCE_ITEM_SID  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the export warehouse.',
   CARRIER_PARTY_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the carrier/hauler company.',
   REFERENCE_INVOICE_POSITION_FINANCE_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the referenced invoice position.',
   INVOICE_POSITION_SEQ                NUMBER(38, 0)   NOT NULL COMMENT 'The position number within the invoice.',
   ADDITIONAL_PRODUCT_CD               VARCHAR(250)    NOT NULL COMMENT 'An additional product code (can be empty, only WWT).',
   PRODUCT_NAME                        VARCHAR(100)    NOT NULL COMMENT 'The name of the product defined in this invoice position.',
   BUSINESS_TRANSACTION_TYPE_CD        VARCHAR(250)    COMMENT 'The code of the business transaction type (as it comes from WWT)',
   UNIT_GROSS_WEIGHT_MEAS              NUMBER(38, 5)   COMMENT 'Gross weight of a unit of the product in kilogram.',
   UNIT_NET_WEIGHT_MEAS                NUMBER(38, 5)   COMMENT 'Net weight of a unit of the product in kilogram.',
   ITEM_NET_WEIGHT_MEAS                NUMBER(38, 5)   COMMENT 'Net weight of a item of the product in kilogram.',
   NON_FOOD_FG                         BOOLEAN         COMMENT 'Flag indicating whether this product is categorized as "Non Food".',
   AMOUNT_VAL                          NUMBER(38, 5)   COMMENT 'The amount value of this invoice position.',
   PRICE_VAL                           NUMBER(38, 5)   COMMENT 'The price amount of the invoice position.',
   PACKAGE_CONTENT_CNT                 NUMBER(38,0)    COMMENT 'The count of single items within a package.',
   PACKAGE_QTY                         NUMBER(38, 5)   COMMENT 'The quantity of packages.',
   LOADING_DT                          DATE            COMMENT 'The date of the loading of the goods to the transport vehicle.',
   BATCH_NR                            VARCHAR(250)    COMMENT 'The number of the batch the product is part of.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_INVOICE_POSITION PRIMARY KEY (FINANCE_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - The invoice position is part of an invoice and contains information about a specific product sold/bought. - Source - WWT';
