/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CUSTOMER_ORDER_INSTALLMENT_2
   GENERATED FROM POWERDESIGNER ON Thursday, November 28, 2024 4:08:06 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_customer_order_installment_2 (
cust_order_install_nr STRING(20) NOT NULL
OPTIONS(description='Per customer order there is one payment order, original number can be reused'),
cust_order_install_pos_nr STRING(20) NOT NULL
OPTIONS(description='Per tax class there is one position inside payment order'),
cust_order_install_part_pos_nr STRING(20) NOT NULL
OPTIONS(description='In case of splitted payments there are several several sub positions'),
cust_order_install_part_rep_pos_nr STRING(20) NOT NULL
OPTIONS(description='Repeating position number - a split of sub position'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
wshop_cd STRING(5) OPTIONS(description='The unique code for the Lidl webshop'),
cust_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the customer'),
cust_nr STRING(20)
OPTIONS(description='The unique identifier for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).'),
internal_company_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the company'),
install_type_cd STRING(5) OPTIONS(description='Type of financial order ( Clearing , Write-off Loss ...)'),
cust_paym_method_cd STRING(5) OPTIONS(description='Unique code of the payment method'),
paym_settl_type_cd STRING(5) OPTIONS(description='How the installment amount was settled '),
install_warn_status_cd BIGNUMERIC OPTIONS(description='If the position was not paid occurs warning status_2'),
curr_cd STRING(5) OPTIONS(description='The code identifying the currency according to ISO-4217.'),
debt_collection_status_cd STRING(5)
OPTIONS(description='The code for the status_2 of the debt collection process. e.g. 01 = Receivable Released For Submission, 02 = Receivable Submitted, 12 = Receivable Cleared etc. '),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
fin_order_create_dt DATE OPTIONS(description='Create date of  the financial order'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
install_part_pos_due_dt DATE
OPTIONS(description='Date until when the payment is due. In case of adhoc payments the due date equals the creation date. "Auf Rechnung" is 14 days after the order.'),
amt_paid_local_val BIGNUMERIC(38,5) OPTIONS(description='Amount paid '),
is_settl_fg BOOL OPTIONS(description='Was the partial installment settled ( paid in any way )'),
debt_collection_start_dt DATE OPTIONS(description='Start date of debt collection'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
paym_request_dt DATE
OPTIONS(description='Date when new payment request has been issued to the customer. Used for triggering/increasing the dunning level (MAHNS) to the customer'),
part_paym_dt DATE
OPTIONS(description='This is the date for a partial payment related to a customer order position. The amount of the payment is not fixed, which means it can vary for each order position and for each order part position depending on how much the customer chooses to pay.'),
amt_dunned_local_val BIGNUMERIC(38,5)
OPTIONS(description='Open amount which hasn\'t been paid by the customer yet. (Dunned amount that the customer has been asked for payment)'),
is_dun_notice_reversed_fg BOOL
OPTIONS(description='Flag column to show if a dunning notice has been canceled (no longer be used to determine dunning level or creditworthiness)'),
debt_collection_item_nr BIGNUMERIC
OPTIONS(description='The collection item_2 number related to the payment order that goes to debt collection process (Inkasso).(referred to one or multiple payment order positions assigned to debt collection process)'),
fin_acct_transaction_cd STRING(20)
OPTIONS(description='Unique code identifying the main transactions in the SAP Financial Accounting module.  It is used to identify the primary type of transaction, such as a payment, invoice, or credit memo.'),
business_acct_model_cd STRING(20)
OPTIONS(description='Unique code used to categorize the business accounting processes of managing and selling the receivables. For instance, the code 01 is reserved for Lidl Online Shop. The process of managing and selling the receivables from the standard Lidl Online shop is different from the process used for D2 (Installment Payments) or D3 (Lidl Pay). Because of these differences, they are treated as separate divisions or business models.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source table'),
PRIMARY KEY (cust_order_install_nr, cust_order_install_pos_nr, cust_order_install_part_pos_nr,
 cust_order_install_part_rep_pos_nr, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='For every customer order there is an internal financial order created by lidl. It is also keep tracking of payment status_2 of installment if the order was not paid in full. A payment might cover only part of installment so we could have serveral payments per one installment, and each payment updates the status_2 of installment (we do not have separate table just for installment plan). This information is used in risk level calculation for a customer.              ');