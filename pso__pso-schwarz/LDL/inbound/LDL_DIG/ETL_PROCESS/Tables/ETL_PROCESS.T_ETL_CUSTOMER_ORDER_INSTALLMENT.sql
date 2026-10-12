/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_CUSTOMER_ORDER_INSTALLMENT
   GENERATED FROM POWERDESIGNER ON Thursday, November 28, 2024 4:11:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_CUSTOMER_ORDER_INSTALLMENT (
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop',
   CUST_ORDER_INSTALL_NR               VARCHAR(20)     NOT NULL COMMENT 'Per customer order there is one payment order, original number can be reused',
   CUST_ORDER_INSTALL_POS_NR           VARCHAR(20)     NOT NULL COMMENT 'Per tax class there is one position inside payment order',
   CUST_ORDER_INSTALL_PART_POS_NR      VARCHAR(20)     NOT NULL COMMENT 'In case of splitted payments there are several several sub positions',
   CUST_ORDER_INSTALL_PART_REP_POS_NR  VARCHAR(20)     NOT NULL COMMENT 'Repeating position number - a split of sub position',
   FIN_ORDER_CREATE_DT                 DATE            COMMENT 'Create date of  the financial order',
   CUST_ORDER_SID                      NUMBER          COMMENT 'Customer order link',
   CUST_NR                             VARCHAR(20)     COMMENT 'The unique identifier for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).',
   INSTALL_TYPE_CD                     VARCHAR(5)      COMMENT 'Type of financial order ( Clearing , Write-off Loss ...)',
   PART_PAYM_DT                        DATE            COMMENT 'This is the date for a partial payment related to a customer order position. The amount of the payment is not fixed, which means it can vary for each order position and for each order part position depending on how much the customer chooses to pay.',
   INSTALL_PART_POS_DUE_DT             DATE            COMMENT 'Date until when the payment is due. In case of adhoc payments the due date equals the creation date. "Auf Rechnung" is 14 days after the order.',
   AMT_PAID_LOCAL_VAL                  NUMBER(38, 5)   COMMENT 'Amount paid ',
   INTERNAL_COMPANY_SID                NUMBER          COMMENT 'The unique identifier (surrogate key) for the company',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   IS_SETTL_FG                         BOOLEAN         COMMENT 'Was the partial installment settled ( paid in any way )',
   PAYM_SETTL_TYPE_CD                  VARCHAR(5)      COMMENT 'How the installment amount was settled ',
   FIN_ACCT_TRANSACTION_CD             VARCHAR(20)     COMMENT 'Unique code identifying the main transactions in the SAP Financial Accounting module.  It is used to identify the primary type of transaction, such as a payment, invoice, or credit memo.',
   BUSINESS_ACCT_MODEL_CD              VARCHAR(20)     COMMENT 'Unique code used to categorize the business accounting processes of managing and selling the receivables. For instance, the code 01 is reserved for Lidl Online Shop. The process of managing and selling the receivables from the standard Lidl Online shop is different from the process used for D2 (Installment Payments) or D3 (Lidl Pay). Because of these differences, they are treated as separate divisions or business models.',
   DEBT_COLLECTION_ITEM_NR             NUMBER          COMMENT 'The collection item number related to the payment order that goes to debt collection process (Inkasso).(referred to one or multiple payment order positions assigned to debt collection process)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_CUSTOMER_ORDER_INSTALLMENT PRIMARY KEY (CUST_ORDER_INSTALL_NR, CUST_ORDER_INSTALL_POS_NR, CUST_ORDER_INSTALL_PART_POS_NR, CUST_ORDER_INSTALL_PART_REP_POS_NR) NOT ENFORCED 
)  COMMENT = 'A helper table that facilitates the loading of data in T_FACT_CUSTOMER_ORDER_INSTALLMENT';
