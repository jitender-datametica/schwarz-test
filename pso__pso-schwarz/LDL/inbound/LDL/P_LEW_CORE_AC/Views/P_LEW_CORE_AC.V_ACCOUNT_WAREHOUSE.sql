create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_ACCOUNT_WAREHOUSE(
	CLIENT_ID COMMENT 'DWH-Mandant; FK auf CLIENT',
	LOC_SID_WH COMMENT 'Warehouse FK auf LOCATION - Surrogate Key Warehouse',
	RECEIPT_ID COMMENT 'Document/Receipt number. Source: T90_WHACCOUNT.C90_FORMNR',
	RECEIPT_TYPE_ID COMMENT 'Indicates the type of CREDIT or DEBIT the document/receipt refers. Source: T90_WHACCOUNT.C90_FORMTYPE',
	RECEIPT_TYPE_DESCR COMMENT 'Description of the type of CREDIT or DEBIT the document refers. Source: T93_TROMTYPE.C93_FORMDESCR',
	ACCOUNT_BALANCE_PAGE_NR COMMENT 'Indicates the account statement number in ACP / Account Printing Module. Source: T90_WHACCOUNT.C90_PAGENO',
	LOC_SID_STORE COMMENT 'Store FK auf LOCATION - Surrogate Key STORE',
	DEBIT_VAL COMMENT 'Indication of the amount by which the company is charged (e.g., for incoming goods or breakage). Sourc: T90_WHACCOUNT.C90_DEBIT',
	DEBIT_NET_VAL COMMENT 'The corresponding net value of the column debit_val. Source: T90_WHACCOUNT.C90_DEBIT_NET',
	CREDIT_VAL COMMENT 'Specification of the amount by which the company is relieved (e.g., for goods deliveries or returns to the supplier). Source: T90_WHACCOUNT.C90_CREDIT',
	CREDIT_NET_VAL COMMENT 'The corresponding net value of the column credit_val. Source: T90_WHACCOUNT.C90_CREDIT_NET',
	DAYEND_DT COMMENT 'Indication of the date on which DAY wrote this entry (company''s daily closing date). Source: T90_WHACCOUNT.C90_DAYENDDATE',
	DWH_CAL_DT COMMENT 'Document/Receipt Date. Source: T90_WHACCOUNT.C90_FORMDATE',
	DWH_LOAD_ID COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED COMMENT 'Timestamp of the last update of the record in the DWH.'
) as SELECT
   client_id
  ,loc_sid_wh
  ,receipt_id
  ,receipt_type_id
  ,receipt_type_descr
  ,account_balance_page_nr
  ,loc_sid_store
  ,debit_val
  ,debit_net_val
  ,credit_val
  ,credit_net_val
  ,dayend_dt
  ,dwh_cal_dt
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
FROM P_LEW_CORE.T_ACCOUNT_WAREHOUSE
;
