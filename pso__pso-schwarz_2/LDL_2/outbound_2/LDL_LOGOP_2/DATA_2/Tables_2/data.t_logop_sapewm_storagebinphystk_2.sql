/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebinphystk_2
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_storagebinphystk_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_2 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_2 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
log_pos STRING(2)
OPTIONS(description='Logical Position of Handling Unit_2 - Technical name: LOGPOS - Component Type: /SCWM/DE_LOGPOS'),
hu_ident STRING(20) NOT NULL
OPTIONS(description='Handling Unit_2 Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'),
product_nr STRING(40) NOT NULL OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'),
product_desc STRING(40)
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'),
quantity BIGNUMERIC(38,3) OPTIONS(description='Quantity - Technical name: QUAN - Component Type: /SCWM/DE_UI_QUAN'),
buom STRING(3) OPTIONS(description='Base Unit_2 of Measure - Technical name: UNIT_2 - Component Type: /SCWM/DE_BASE_UOM'),
packed_qnty_auom BIGNUMERIC(38,3)
OPTIONS(description='Packed Quantity in Alternative Unit_2 of Measure - Technical name: QUANA - Component Type: /SCWM/DE_UI_QUAN_PACKED'),
stock_type STRING(2) NOT NULL OPTIONS(description='Stock Type - Technical name: CAT - Component Type: /SCWM/DE_CAT'),
batch STRING(10) NOT NULL OPTIONS(description='Batch - Technical name: CHARG - Component Type: /SCWM/DE_CHARG'),
shelf_life_exp_date DATE
OPTIONS(description='Shelf Life Expiration Date - Technical name: VFDAT - Component Type: /SCWM/SLED'),
gr_dt DATE NOT NULL
OPTIONS(description='Goods Receipt Date - Technical name: UI_WDATU - Component Type: /SCWM/DE_UI_WDATU'),
gr_tm TIME NOT NULL
OPTIONS(description='Goods Receipt Time - Technical name: UI_WDATT - Component Type: /SCWM/DE_UI_WDATT'),
doc_cat_doc_ref STRING(3)
OPTIONS(description='Doc. Category for Doc. Reference and Doc.-Related Stocks - Technical name: DOCCAT - Component Type: /SCWM/DE_DOCCAT'),
doc_nr STRING(35) NOT NULL OPTIONS(description='Document - Technical name: DOCNO - Component Type: /SCWM/SP_DOCNO_INT'),
strg_bin STRING(18) NOT NULL OPTIONS(description='Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'),
auom STRING(3)
OPTIONS(description='Alternative Unit_2 of Measure for Stockkeeping Unit_2 - Technical name: ALTME - Component Type: /SCWM/DE_AUNIT'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, hu_ident, product_nr, gr_dt, gr_tm, batch, strg_bin, stock_type, doc_nr, dwh_valid_from)
NOT ENFORCED
) OPTIONS(description='Storage Bin Physical Stock - BI reporting');