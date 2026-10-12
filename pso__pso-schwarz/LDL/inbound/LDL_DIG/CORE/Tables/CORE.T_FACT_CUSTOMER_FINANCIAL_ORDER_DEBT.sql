/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_FINANCIAL_ORDER_DEBT
   GENERATED FROM POWERDESIGNER ON Mittwoch, 28. September 2022 14:00:17
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMER_FINANCIAL_ORDER_DEBT (
   CUST_ORDER_INSTALL_NR               VARCHAR(20)     NOT NULL COMMENT 'Per customer order there is one payment order, original number can be reused',
   DEBT_COLLECTION_ITEM_NR             NUMBER          NOT NULL COMMENT 'The collection item number related to the payment order that goes to debt collection process (Inkasso).(referred to one or multiple payment order positions assigned to debt collection process)',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CUST_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the customer (to whom the debt collection process relates)',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   DEBT_COLLECTION_REQUEST_LOCAL_VAL   NUMBER(38, 5)   COMMENT 'Open amount to be collected in the Inkasso process by a collection agency when the customer has ignored the payment requests. ',
   DEBT_COLLECTION_PAID_LOCAL_VAL      NUMBER(38, 5)   COMMENT 'Amount collected in the Inkasso process  by a collection agency  when the customer has ignored the payment requests(can be paid via collection agency or directly to Lidl)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_FACT_CUSTOMER_FINANCIAL_ORDER_DEBT PRIMARY KEY (CUST_ORDER_INSTALL_NR, DEBT_COLLECTION_ITEM_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'The fact table holding the debt collection item details ';
