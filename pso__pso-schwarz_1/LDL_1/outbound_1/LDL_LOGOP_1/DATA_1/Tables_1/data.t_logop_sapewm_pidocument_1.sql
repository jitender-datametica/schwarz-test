/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_pidocument_1
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_pidocument_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5)
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
doc_nr BIGNUMERIC(38,0)
OPTIONS(description='Number of Physical Inventory Document - Technical name: DOC_NUMBER - Component Type: /SCWM/DE_PI_DOC_NUMBER'),
item_nr BIGNUMERIC(38,0) OPTIONS(description='Item_1 - Technical name: ITEM_NO - Component Type: /LIME/LINE_ITEM_ID'),
doc_year BIGNUMERIC(38,0)
OPTIONS(description='Document Year of Physical Inventory Document - Technical name: DOC_YEAR - Component Type: /LIME/PI_DOC_YEAR'),
doc_type STRING(2)
OPTIONS(description='Physical Inventory Procedure (Document Type of Phys. Inv.) - Technical name: DOC_TYPE - Component Type: /LIME/PI_DOCUMENT_TYPE'),
doc_status STRING(4)
OPTIONS(description='Physical Inventory Status_1 - Technical name: DOC_STATUS - Component Type: /LIME/PI_STATUS'),
activity_area STRING(4) OPTIONS(description='Activity Area - Technical name: AAREA - Component Type: /SCWM/DE_AAREA'),
reason STRING(4) OPTIONS(description='Reason - Technical name: REASON - Component Type: /SCWM/PI_REASON'),
reason_desc STRING(40)
OPTIONS(description='Reason Description - Technical name: REASON_TXT - Component Type: /SCWM/DE_REASON_TXT'),
prio BIGNUMERIC(38,0) OPTIONS(description='Priority - Technical name: PRIORITY - Component Type: /SCWM/PI_PRIORITY'),
prio_desc STRING(12)
OPTIONS(description='Priority Description - Technical name: PRIORITY_TXT - Component Type: /SCWM/PI_PRIORITY_TXT'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATE_DATE - Component Type: /SCWM/DE_CREATED_DATE'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATE_TIME - Component Type: /SCWM/DE_CREATED_TIME'),
crtd_by STRING(12) OPTIONS(description='Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'),
activ_dt DATE OPTIONS(description='Activation Date - Technical name: ACTI_DATE - Component Type: /SCWM/DE_ACTI_DATE'),
activ_tm TIME OPTIONS(description='Activation Time - Technical name: ACTI_TIME - Component Type: /SCWM/DE_ACTI_TIME'),
cnt_dt DATE OPTIONS(description='Count Date - Technical name: COUNT_DATE - Component Type: /SCWM/DE_COUNT_DATE'),
cnt_tm TIME OPTIONS(description='Count Time - Technical name: COUNT_TIME - Component Type: /SCWM/DE_COUNT_TIME'),
cnt_user STRING(12)
OPTIONS(description='Name of Counter - Technical name: COUNT_USER - Component Type: /SCWM/PI_DE_UI_COUNT_USER'),
post_dt DATE OPTIONS(description='Posting Date - Technical name: POST_DATE - Component Type: /SCWM/DE_POSTED_DATE'),
post_tm TIME OPTIONS(description='Time of Posting - Technical name: POST_TIME - Component Type: /SCWM/DE_POSTED_TIME'),
last_changed_by STRING(12)
OPTIONS(description='Changed By - Technical name: LAST_CHANGED_BY - Component Type: /SCWM/DE_CHANGED_BY'),
strg_bin_empty STRING(1)
OPTIONS(description='Storage Bin Empty - Technical name: IND_BIN_EMPTY - Component Type: /SCWM/DE_IND_BIN_EMPTY'),
strg_type STRING(4) OPTIONS(description='Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP'),
strg_sec STRING(4) OPTIONS(description='Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER'),
strg_bin STRING(18) OPTIONS(description='Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'),
product_nr STRING(40) OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'),
product_desc STRING(40)
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'),
batch STRING(10) OPTIONS(description='Batch - Technical name: CHARG - Component Type: /SCWM/DE_CHARG'),
stock_type STRING(2) OPTIONS(description='Stock Type - Technical name: CAT - Component Type: /SCWM/DE_CAT'),
stock_type_desc STRING(30)
OPTIONS(description='Description of Stock Type - Technical name: CAT_TEXT - Component Type: /SCWM/DE_UI_CAT_TEXT'),
party_entitled_dispose STRING(10)
OPTIONS(description='Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'),
partner_role_party_entitled_dispose STRING(2)
OPTIONS(description='Partner Role of Party Entitled to Dispose - Technical name: ENTITLED_ROLE - Component Type: /SCWM/DE_ENTITLED_ROLE'),
gr_dt DATE OPTIONS(description='Goods Receipt Date - Technical name: WDATU - Component Type: /SCWM/DE_WDATU'),
ui_gr_dt DATE OPTIONS(description='Goods Receipt Date - Technical name: UI_WDATU - Component Type: /SCWM/DE_UI_WDATU'),
ui_gr_tm TIME OPTIONS(description='Goods Receipt Time - Technical name: UI_WDATT - Component Type: /SCWM/DE_UI_WDATT'),
shelf_life_exp_dt DATE
OPTIONS(description='Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED'),
who_nr BIGNUMERIC(38,0)
OPTIONS(description='Warehouse Order Number - Technical name: WHO - Component Type: /SCWM/DE_WHO'),
quan_book BIGNUMERIC(38,3)
OPTIONS(description='Book Inventory Balance Quantity (Physical Inventory) - Technical name: QUAN_BOOK - Component Type: /SCWM/DE_QUAN_BOOK'),
quan_count BIGNUMERIC(38,3)
OPTIONS(description='Counted Quantity (Physical Inventory) - Technical name: QUAN_COUNT - Component Type: /SCWM/DE_QUAN_COUNT'),
quan_diff BIGNUMERIC(38,3)
OPTIONS(description='Difference Quantity - Technical name: QUAN_DIFF - Component Type: /SCWM/DE_UI_QUAN_DIFF'),
quan_diff_abs BIGNUMERIC(38,3)
OPTIONS(description='Absolute Difference Quantity - Technical name: QUAN_DIFF_ABS - Component Type: /SCWM/DE_QUAN_DIFF_ABS'),
buom STRING(3) OPTIONS(description='Base Unit_1 of Measure - Technical name: UNIT_1 - Component Type: /SCWM/DE_BASE_UOM'),
value_diff BIGNUMERIC(38,2)
OPTIONS(description='Difference Value - Technical name: VALUE_DIFF - Component Type: /SCWM/DE_VALUE_DIFF'),
value_diff_abs BIGNUMERIC(38,2)
OPTIONS(description='Absolute Difference Value - Technical name: VALUE_DIFF_ABS - Component Type: /SCWM/DE_VALUE_DIFF_ABS'),
curr_key STRING(5) OPTIONS(description='Currency Key - Technical name: WAERS - Component Type: WAERS'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at')
) OPTIONS(description='Physical Inventory documents for BI Reporting');