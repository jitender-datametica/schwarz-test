CREATE TABLE IF NOT EXISTS ldl_logop_data.t_wawi_whaccount_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
wh_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse number'),
id_value BIGNUMERIC(38,10) NOT NULL,
wawi_instanz_kzl STRING(3) NOT NULL OPTIONS(description='Country_1 code'),
t_code BIGNUMERIC(38,0)
OPTIONS(description='The value C90_T_Code is part of the document type and forms a higher-level grouping of individual document types. T93_FORMTYPE.C93_T_Code'),
form_type BIGNUMERIC(38,0)
OPTIONS(description='Specification of the document type or document type T93_FORMTYPE.C93_FormType'),
store_nr BIGNUMERIC(38,0) OPTIONS(description='Specification of the branch number T008_STORE.C008_Store'),
form_dt DATETIME OPTIONS(description='Specification of the document date.'),
day_end_dt DATETIME
OPTIONS(description='Specification of the date on which DAY wrote this entry (company daily closing date)'),
vat_grp STRING(15) OPTIONS(description='No use.'),
debit BIGNUMERIC(38,10)
OPTIONS(description='Specification of the amount by which the company is debited (e.g. for goods receipt or breakage).'),
credit BIGNUMERIC(38,10)
OPTIONS(description='Specification of the amount by which the company is credited (e.g. for goods dispatched or returned to the supplier_1).'),
page_no BIGNUMERIC(38,10)
OPTIONS(description='Specification of the account_1 statement number in ACP Account_1 Printing Module.'),
form_nr STRING(20) OPTIONS(description='Specification of the document number.'),
debit_net BIGNUMERIC(38,10) OPTIONS(description='The corresponding net value of the column C90_DEBIT'),
credit_net BIGNUMERIC(38,10) OPTIONS(description='The corresponding net value of the column C90_CREDIT'),
scn BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, id_value, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='WAWI - WHWAWIADM.T90_WHACCOUNT_1 table');