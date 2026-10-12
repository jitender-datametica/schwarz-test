/* --------------------------------------------------------------------------------
   DDL for table: T_INTERNAL_SALES_RECEIPT_POSITION_2
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_INTERNAL_SALES_RECEIPT_POSITION_2 (
   SALES_RECEIPT_NR                    VARCHAR(250)    NOT NULL COMMENT 'The business number of the sales_2 receipt this delivery is connected to.',
   SALES_RECEIPT_POSITION_NR           NUMBER(38, 0)   NOT NULL COMMENT 'The position number on the receipt',
   EVENT_DT                            DATE            NOT NULL COMMENT 'The timestamp when the transaction happens',
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   INPUT_PRODUCT_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   PRICE_PRODUCT_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   SUBMITTING_LOCATION_SID             NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country.',
   RECEIVING_LOCATION_SID              NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country.',
   DISTRIBUTION_NR                     VARCHAR(250)    COMMENT 'The business number of the distribution.',
   DISTRIBUTION_POSITION_NR            NUMBER(38, 0)   NOT NULL COMMENT 'The number of the position of the delivery.',
   POSITION_TXT                        VARCHAR(1000)   NOT NULL COMMENT 'Descriptive attribute - short text describing the article of this position on the receipt',
   CONVERSION_FACTOR_VAL               NUMBER(38,5)    NOT NULL COMMENT 'Fact - non-additive - The conversion factor to calculate the base quantity unit_2 from the sales_2 quantity unit_2',
   NET_VAL                             NUMBER(38,5)    NOT NULL COMMENT 'Fact - semi-additive - The net value of this receipt position using the receipt currency',
   ORDER_QTY                           NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The quantity defined in the order.',
   DELIVERY_QTY                        NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The expected quantity of the delivery.',
   CONFIRMED_SALES_UNIT_QTY            NUMBER(38, 5)   COMMENT 'Fact - additive - The confirmed quantity measured in  sales_2 unit_2 of measure.',
   CONFIRMED_BASE_UNIT_QTY             NUMBER(38, 5)   COMMENT 'Fact - additive - The confirmed quantity measured in base unit_2 of measure.',
   GROSS_WEIGHT_MEAS                   NUMBER(38, 5)   COMMENT 'Fact - additive - The gross weight of the position.',
   NET_WEIGHT_MEAS                     NUMBER(38, 5)   COMMENT 'Fact - additive - The net weight of the position.',
   VOLUME_QTY                          NUMBER(38, 5)   COMMENT 'Fact - additive - The quantity of the volume of the position.',
   NET_PRICE_VAL                       NUMBER(38,5)    COMMENT 'Fact - semi-additive - The net price of the product of this position.',
   ACCOUNTING_GROUP_CD                 VARCHAR(50)     NOT NULL COMMENT 'The code identifying the accounting group.',
   SUBTOTAL_1_VAL                      NUMBER(38,5)    COMMENT 'Fact - semi-additive - The first subtotal amount from the calculation schema.',
   SUBTOTAL_2_VAL                      NUMBER(38,5)    COMMENT 'Fact - semi-additive - The second subtotal amount from the calculation schema.',
   SUBTOTAL_3_VAL                      NUMBER(38,5)    COMMENT 'Fact - semi-additive - The third subtotal amount from the calculation schema.',
   SUBTOTAL_4_VAL                      NUMBER(38,5)    COMMENT 'Fact - semi-additive - The fourth subtotal amount from the calculation schema.',
   CREATED_DELIVERY_DT                 DATE            COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   PROMISED_DELIVERY_DT                DATE            COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   PROMISED_DELIVERY_QTY               NUMBER(38, 5)   COMMENT 'Fact - additive - The promised quantity to be delivered measured in sales_2 units.',
   REQUESTED_QTY                       NUMBER(38, 5)   NOT NULL COMMENT 'Fact - additive - The quantity requested by the recipient',
   PACKAGE_TYPE_CD                     VARCHAR(50)     NOT NULL COMMENT 'Descriptive attribute - code that descripbes the type of packaging, currently only value is "Y001"',
   CUSTOMER_REFERENCE_NR               VARCHAR(250)    COMMENT 'Descriptive attribute - a text referencing the customer.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_INTERNAL_SALES_RECEIPT_POSITION PRIMARY KEY (SALES_RECEIPT_NR, SALES_RECEIPT_POSITION_NR, EVENT_DT) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Contains a position of a receipt for the internal sale of goods to stores from the LExIS system. - Source - Lexis';
