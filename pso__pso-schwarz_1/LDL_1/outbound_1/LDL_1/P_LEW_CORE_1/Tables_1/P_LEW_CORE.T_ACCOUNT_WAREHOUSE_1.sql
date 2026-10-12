/* --------------------------------------------------------------------------------
   DDL for table: t_account_warehouse_1
   generated from Powerdesigner on Tuesday, October 28, 2025 8:35:33 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_account_warehouse_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse FK auf LOCATION_1 - Surrogate Key Warehouse'),
receipt_id STRING(100) NOT NULL OPTIONS(description='Document/Receipt number. Source: T90_WHACCOUNT.C90_FORMNR'),
receipt_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Indicates the type of CREDIT or DEBIT the document/receipt refers. Source: T90_WHACCOUNT.C90_FORMTYPE'),
receipt_type_descr STRING(100)
OPTIONS(description='Description of the type of CREDIT or DEBIT the document refers. Source: T93_TROMTYPE.C93_FORMDESCR'),
account_balance_page_nr BIGNUMERIC(38,0)
OPTIONS(description='Indicates the account_1 statement number in ACP / Account_1 Printing Module. Source: T90_WHACCOUNT.C90_PAGENO'),
loc_sid_store BIGNUMERIC(38,0) OPTIONS(description='Store FK auf LOCATION_1 - Surrogate Key STORE'),
debit_val NUMERIC(18,5)
OPTIONS(description='Indication of the amount by which the company is charged (e.g., for incoming goods or breakage). Sourc: T90_WHACCOUNT.C90_DEBIT'),
debit_net_val NUMERIC(18,5)
OPTIONS(description='The corresponding net value of the column debit_val. Source: T90_WHACCOUNT.C90_DEBIT_NET'),
credit_val NUMERIC(18,5)
OPTIONS(description='Specification of the amount by which the company is relieved (e.g., for goods deliveries or returns to the supplier_1). Source: T90_WHACCOUNT.C90_CREDIT'),
credit_net_val NUMERIC(18,5)
OPTIONS(description='The corresponding net value of the column credit_val. Source: T90_WHACCOUNT.C90_CREDIT_NET'),
dayend_dt DATE NOT NULL
OPTIONS(description='Indication of the date on which DAY wrote this entry (company\'s daily closing date). Source: T90_WHACCOUNT.C90_DAYENDDATE'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Document/Receipt Date. Source: T90_WHACCOUNT.C90_FORMDATE'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, loc_sid_wh, receipt_id, receipt_type_id, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='This table contains the debits and credits of the warehouse accounts splited by receipt type, allowing to calculate the turnover of the warehouse.             Source WAWI table: T90_WHACCOUNT_1');