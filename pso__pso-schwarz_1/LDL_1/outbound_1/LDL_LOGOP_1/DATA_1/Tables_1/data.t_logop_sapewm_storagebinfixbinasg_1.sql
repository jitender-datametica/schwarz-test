/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebinfixbinasg_1
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_storagebinfixbinasg_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country_1 code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country_1 code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
strg_bin STRING(18) NOT NULL OPTIONS(description='Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'),
strg_bin_assgn_type_flg BOOL
OPTIONS(description='Storage Bin Assignment Type - Technical name: ASTYPE_BIN - Component Type: /SCWM/DE_FIXBIN_ASTYPE_B_MLTPL'),
product_nr STRING(40) NOT NULL OPTIONS(description='Product - Technical name: MATNR - Component Type: /SCWM/DE_MATNR'),
product_desc STRING(40)
OPTIONS(description='Product Short Description - Technical name: MAKTX - Component Type: /SCWM/DE_UI_MAKTX'),
product_assgn_type STRING(1)
OPTIONS(description='Product Assignment Type - Technical name: ASTYPE_PRODUCT - Component Type: /SCWM/DE_FIXBIN_ASTYPE_P_MLTPL'),
party_entitled_dispose STRING(10)
OPTIONS(description='Party Entitled to Dispose - Technical name: ENTITLED - Component Type: /SCWM/DE_ENTITLED'),
stock_in_fix_bin_flg BOOL
OPTIONS(description='Stock in Fixed Storage Bin - Technical name: STOCK - Component Type: /SCWM/DE_FIXBIN_STOCK_FULL'),
is_strg_bin_imprvbl STRING(1)
OPTIONS(description='Storage Bin Improvable - Technical name: OUTCON - Component Type: /SCWM/DE_OUTCON'),
strg_bin_imprvbl_change_dt DATE
OPTIONS(description='Storage Bin Improvable Changed On - Technical name: DATOUT - Component Type: /SCWM/DE_DATOUT'),
strg_type STRING(4) OPTIONS(description='Storage Type - Technical name: LGTYP - Component Type: /SCWM/LGTYP'),
strg_sec STRING(4) OPTIONS(description='Storage Section - Technical name: LGBER - Component Type: /SCWM/LGBER'),
strg_bin_empty_flg BOOL
OPTIONS(description='Empty Storage Bin - Technical name: KZLER - Component Type: /SCWM/LAGP_KZLER'),
crtd_by STRING(12) OPTIONS(description='Created By - Technical name: CREATED_BY - Component Type: /SCWM/DE_CREATOR'),
crtd_on_dt DATE
OPTIONS(description='Creation Date of a Fixed Storage Bin - Technical name: CREATED_DATE - Component Type: /SCWM/DE_FIXBIN_CREATED_DATE'),
crtd_at_tm TIME
OPTIONS(description='Fixed Storage Bin Creation Time - Technical name: CREATED_TIME - Component Type: /SCWM/DE_FIXBIN_CREATED_TIME'),
ps_area STRING(15)
OPTIONS(description='Production Supply Area(s) - Technical name: PSAS - Component Type: /SCWM/DE_PSAS'),
campaign_flg BOOL OPTIONS(description='Campaign - Technical name: ZZ_CAMPAIGN - Component Type: ZEWM_E_E323_CAMPAIGN'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, strg_bin, product_nr, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Fix bin assignment. BI Reporting');