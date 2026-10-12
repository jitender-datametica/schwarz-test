CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_account_warehouse (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), loc_sid_wh
OPTIONS(description='Warehouse FK auf LOCATION - Surrogate Key Warehouse'), receipt_id
OPTIONS(description='Document/Receipt number. Source: T90_WHACCOUNT.C90_FORMNR'), receipt_type_id
OPTIONS(description='Indicates the type of CREDIT or DEBIT the document/receipt refers. Source: T90_WHACCOUNT.C90_FORMTYPE'),
receipt_type_descr
OPTIONS(description='Description of the type of CREDIT or DEBIT the document refers. Source: T93_TROMTYPE.C93_FORMDESCR'),
account_balance_page_nr
OPTIONS(description='Indicates the account statement number in ACP / Account Printing Module. Source: T90_WHACCOUNT.C90_PAGENO'),
loc_sid_store OPTIONS(description='Store FK auf LOCATION - Surrogate Key STORE'), debit_val
OPTIONS(description='Indication of the amount by which the company is charged (e.g., for incoming goods or breakage). Sourc: T90_WHACCOUNT.C90_DEBIT'),
debit_net_val
OPTIONS(description='The corresponding net value of the column debit_val. Source: T90_WHACCOUNT.C90_DEBIT_NET'),
credit_val
OPTIONS(description='Specification of the amount by which the company is relieved (e.g., for goods deliveries or returns to the supplier). Source: T90_WHACCOUNT.C90_CREDIT'),
credit_net_val
OPTIONS(description='The corresponding net value of the column credit_val. Source: T90_WHACCOUNT.C90_CREDIT_NET'),
dayend_dt
OPTIONS(description='Indication of the date on which DAY wrote this entry (company\'s daily closing date). Source: T90_WHACCOUNT.C90_DAYENDDATE'),
dwh_cal_dt OPTIONS(description='Document/Receipt Date. Source: T90_WHACCOUNT.C90_FORMDATE'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp_ntz(9) of the record in the DWH.'), dwh_updated
OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH.')) AS SELECT *
FROM ldl_p_lew_core.t_account_warehouse;