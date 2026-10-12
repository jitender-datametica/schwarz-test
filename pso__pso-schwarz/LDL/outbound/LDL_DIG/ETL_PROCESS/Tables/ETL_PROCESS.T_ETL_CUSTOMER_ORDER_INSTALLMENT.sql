/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_CUSTOMER_ORDER_INSTALLMENT
   GENERATED FROM POWERDESIGNER ON Thursday, November 28, 2024 4:11:40 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_customer_order_installment (
wshop_cd STRING(5) OPTIONS(description='The unique code for the Lidl webshop'),
cust_order_install_nr STRING(20) NOT NULL
OPTIONS(description='Per customer order there is one payment order, original number can be reused'),
cust_order_install_pos_nr STRING(20) NOT NULL
OPTIONS(description='Per tax class there is one position inside payment order'),
cust_order_install_part_pos_nr STRING(20) NOT NULL
OPTIONS(description='In case of splitted payments there are several several sub positions'),
cust_order_install_part_rep_pos_nr STRING(20) NOT NULL
OPTIONS(description='Repeating position number - a split of sub position'),
fin_order_create_dt DATE OPTIONS(description='Create date of  the financial order'),
cust_order_sid BIGNUMERIC OPTIONS(description='Customer order link'),
cust_nr STRING(20)
OPTIONS(description='The unique identifier for the customer in SAP. The customer can be a person (e.g. online shop customer) or a legal entity (e.g. internal or external company).'),
install_type_cd STRING(5) OPTIONS(description='Type of financial order ( Clearing , Write-off Loss ...)'),
part_paym_dt DATE
OPTIONS(description='This is the date for a partial payment related to a customer order position. The amount of the payment is not fixed, which means it can vary for each order position and for each order part position depending on how much the customer chooses to pay.'),
install_part_pos_due_dt DATE
OPTIONS(description='Date until when the payment is due. In case of adhoc payments the due date equals the creation date. "Auf Rechnung" is 14 days after the order.'),
amt_paid_local_val BIGNUMERIC(38,5) OPTIONS(description='Amount paid '),
internal_company_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the company'),
internal_company_cd STRING(5)
OPTIONS(description='Unique identifier of the company to which we book accounting documents in the source system (SAP)'),
is_settl_fg BOOL OPTIONS(description='Was the partial installment settled ( paid in any way )'),
paym_settl_type_cd STRING(5) OPTIONS(description='How the installment amount was settled '),
fin_acct_transaction_cd STRING(20)
OPTIONS(description='Unique code identifying the main transactions in the SAP Financial Accounting module.  It is used to identify the primary type of transaction, such as a payment, invoice, or credit memo.'),
business_acct_model_cd STRING(20)
OPTIONS(description='Unique code used to categorize the business accounting processes of managing and selling the receivables. For instance, the code 01 is reserved for Lidl Online Shop. The process of managing and selling the receivables from the standard Lidl Online shop is different from the process used for D2 (Installment Payments) or D3 (Lidl Pay). Because of these differences, they are treated as separate divisions or business models.'),
debt_collection_item_nr BIGNUMERIC
OPTIONS(description='The collection item number related to the payment order that goes to debt collection process (Inkasso).(referred to one or multiple payment order positions assigned to debt collection process)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_order_install_nr, cust_order_install_pos_nr, cust_order_install_part_pos_nr,
 cust_order_install_part_rep_pos_nr) NOT ENFORCED
) OPTIONS(description='A helper table that facilitates the loading of data in T_FACT_CUSTOMER_ORDER_INSTALLMENT');