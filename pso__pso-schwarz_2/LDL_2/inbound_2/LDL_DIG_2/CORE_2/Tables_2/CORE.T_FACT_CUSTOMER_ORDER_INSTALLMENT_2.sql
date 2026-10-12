/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_ORDER_INSTALLMENT_2
   GENERATED FROM POWERDESIGNER ON Thursday, November 28, 2024 4:08:06 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CUSTOMER_ORDER_INSTALLMENT_2 (
   CUST_ORDER_INSTALL_NR               VARCHAR(20)     NOT NULL COMMENT 'Per customer order there is one payment order, original number can be reused',
   CUST_ORDER_INSTALL_POS_NR           VARCHAR(20)     NOT NULL COMMENT 'Per tax class there is one position inside payment order',
   CUST_ORDER_INSTALL_PART_POS_NR      VARCHAR(20)     NOT NULL COMMENT 'In case of splitted payments there are several several sub positions',
   CUST_ORDER_INSTALL_PART_REP_POS_NR  VARCHAR(20)     NOT NULL COMMENT 'Repeating position number - a split of sub position',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   CUST_ORDER_SID                      NUMBER          COMMENT 'The unique identifier (surrogate key) for customer order',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop',
   CUST_SID                            NUMBER          COMMENT 'The unique identifier (surrogate key) for the customer',
   CUST_NR                             VARCHAR(20)     COMMENT 'The unique identifier for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).',
   INTERNAL_COMPANY_SID                NUMBER          COMMENT 'The unique identifier (surrogate key) for the company',
   INSTALL_TYPE_CD                     VARCHAR(5)      COMMENT 'Type of financial order ( Clearing , Write-off Loss ...)',
   CUST_PAYM_METHOD_CD                 VARCHAR(5)      COMMENT 'Unique code of the payment method',
   PAYM_SETTL_TYPE_CD                  VARCHAR(5)      COMMENT 'How the installment amount was settled ',
   INSTALL_WARN_STATUS_CD              NUMBER          COMMENT 'If the position was not paid occurs warning status_2',
   CURR_CD                             VARCHAR(5)      COMMENT 'The code identifying the currency according to ISO-4217.',
   DEBT_COLLECTION_STATUS_CD           VARCHAR(5)      COMMENT 'The code for the status_2 of the debt collection process. e.g. 01 = Receivable Released For Submission, 02 = Receivable Submitted, 12 = Receivable Cleared etc. ',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   FIN_ORDER_CREATE_DT                 DATE            COMMENT 'Create date of  the financial order',
   INTERNAL_COMPANY_CD                 VARCHAR(5)      COMMENT 'Unique identifier of the company to which we book accounting documents in the source system (SAP)',
   INSTALL_PART_POS_DUE_DT             DATE            COMMENT 'Date until when the payment is due. In case of adhoc payments the due date equals the creation date. "Auf Rechnung" is 14 days after the order.',
   AMT_PAID_LOCAL_VAL                  NUMBER(38, 5)   COMMENT 'Amount paid ',
   IS_SETTL_FG                         BOOLEAN         COMMENT 'Was the partial installment settled ( paid in any way )',
   DEBT_COLLECTION_START_DT            DATE            COMMENT 'Start date of debt collection',
   CUST_ORDER_NR                       VARCHAR(20)     COMMENT 'The original order number of the source system',
   PAYM_REQUEST_DT                     DATE            COMMENT 'Date when new payment request has been issued to the customer. Used for triggering/increasing the dunning level (MAHNS) to the customer',
   PART_PAYM_DT                        DATE            COMMENT 'This is the date for a partial payment related to a customer order position. The amount of the payment is not fixed, which means it can vary for each order position and for each order part position depending on how much the customer chooses to pay.',
   AMT_DUNNED_LOCAL_VAL                NUMBER(38, 5)   COMMENT 'Open amount which hasn''t been paid by the customer yet. (Dunned amount that the customer has been asked for payment)',
   IS_DUN_NOTICE_REVERSED_FG           BOOLEAN         COMMENT 'Flag column to show if a dunning notice has been canceled (no longer be used to determine dunning level or creditworthiness)',
   DEBT_COLLECTION_ITEM_NR             NUMBER          COMMENT 'The collection item_2 number related to the payment order that goes to debt collection process (Inkasso).(referred to one or multiple payment order positions assigned to debt collection process)',
   FIN_ACCT_TRANSACTION_CD             VARCHAR(20)     COMMENT 'Unique code identifying the main transactions in the SAP Financial Accounting module.  It is used to identify the primary type of transaction, such as a payment, invoice, or credit memo.',
   BUSINESS_ACCT_MODEL_CD              VARCHAR(20)     COMMENT 'Unique code used to categorize the business accounting processes of managing and selling the receivables. For instance, the code 01 is reserved for Lidl Online Shop. The process of managing and selling the receivables from the standard Lidl Online shop is different from the process used for D2 (Installment Payments) or D3 (Lidl Pay). Because of these differences, they are treated as separate divisions or business models.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_FACT_CUSTOMER_ORDER_INSTALLMENT PRIMARY KEY (CUST_ORDER_INSTALL_NR, CUST_ORDER_INSTALL_POS_NR, CUST_ORDER_INSTALL_PART_POS_NR, CUST_ORDER_INSTALL_PART_REP_POS_NR, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'For every customer order there is an internal financial order created by lidl. It is also keep tracking of payment status_2 of installment if the order was not paid in full. A payment might cover only part of installment so we could have serveral payments per one installment, and each payment updates the status_2 of installment (we do not have separate table just for installment plan). This information is used in risk level calculation for a customer. 
             ';
