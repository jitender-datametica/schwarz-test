/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB table		|	t_logop_sapewm_storagebinhus
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_logop_sapewm_storagebinhus (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client id - calculated based on the country code'),
lidl_country STRING(3) NOT NULL OPTIONS(description='Country code. Original field name bic_zmlila'),
source_system STRING(30) NOT NULL OPTIONS(description='Source system'),
wh_nr STRING(5) NOT NULL
OPTIONS(description='Warehouse Number/Warehouse Complex - Technical name: LGNUM - Component Type: /SCWM/LGNUM'),
hu_ident STRING(20) NOT NULL
OPTIONS(description='Handling Unit Identification - Technical name: HUIDENT - Component Type: /SCWM/DE_HUIDENT'),
activity_area STRING(4) OPTIONS(description='Activity Area - Technical name: ZZ_AAREA - Component Type: /SCWM/DE_AAREA'),
sub_activity_area STRING(4)
OPTIONS(description='cartonization: Sub Activity Area - Technical name: ZZCAP_SUB_AAREA - Component Type: ZEWM_E_CAP_SUB_AAREA'),
hu_type STRING(4) OPTIONS(description='Handling Unit Type - Technical name: LETYP - Component Type: /SCWM/DE_HUTYP'),
zz_hu_type STRING(4)
OPTIONS(description='Handling Unit Type - Technical name: ZZ_HUTYP_ORG - Component Type: /SCWM/DE_HUTYP'),
crtd_by STRING(12) OPTIONS(description='User Name - Technical name: CREATED_BY - Component Type: UNAME'),
crtd_on_dt DATE OPTIONS(description='Created On - Technical name: CREATED_DATE - Component Type: /SCWM/DE_CREATED_DATE'),
crtd_at_tm TIME OPTIONS(description='Created At - Technical name: CREATED_TIME - Component Type: /SCWM/DE_CREATED_TIME'),
changed_on_dt DATE
OPTIONS(description='Changed On - Technical name: CHANGED_DATE - Component Type: /SCWM/DE_CHANGED_DATE'),
changed_at_tm TIME
OPTIONS(description='Changed At - Technical name: CHANGED_TIME - Component Type: /SCWM/DE_CHANGED_TIME'),
hu_weight BIGNUMERIC(38,3)
OPTIONS(description='Total Weight of Handling Unit - Technical name: G_WEIGHT - Component Type: /SCWM/BRGEW'),
weight_unit STRING(3) OPTIONS(description='Weight Unit - Technical name: UNIT_GW - Component Type: /SCWM/DE_WGT_UOM'),
capa BIGNUMERIC(38,3)
OPTIONS(description='Total Capacity Key Figure - Technical name: G_CAPA - Component Type: /SCWM/DE_GCAPA'),
vol_unit STRING(3) OPTIONS(description='Volume Unit - Technical name: UNIT_GV - Component Type: /SCWM/DE_VOL_UOM'),
sale_flg STRING(1)
OPTIONS(description='Special Sale Flag - Technical name: ZZ_NF_SPEC_SALE_HU - Component Type: ZEWM_E_NF_SPEC_SALE_HU'),
category STRING(20) OPTIONS(description='Category - Technical name: ZZ_CATEGORY - Component Type: ZEWM_E_NF_CAT'),
open_hu_wt_flg BOOL
OPTIONS(description='Indicator: Handling Unit is Being Moved (Open HU WT) - Technical name: FLGMOVE - Component Type: /SCWM/FLGMOVE'),
pack_mat STRING(40) OPTIONS(description='Packaging Material - Technical name: PMAT - Component Type: /SCWM/DE_PMAT'),
strg_bin STRING(18) OPTIONS(description='Storage Bin - Technical name: LGPLA - Component Type: /SCWM/LGPLA'),
sorted_non_food_flg STRING(1)
OPTIONS(description='Sorted Non-Food Flag - Technical name: ZZ_HU_SORTED - Component Type: ZEWM_E_HU_SORTED'),
pair_bracket BIGNUMERIC(38,0)
OPTIONS(description='Pair Bracket - Technical name: ZZ_PAIR_BRACK - Component Type: ZEWM_E_PAIR_BRACK'),
sys_pal BIGNUMERIC(38,0)
OPTIONS(description='System Pallet - Technical name: ZZ_SYS_PAL - Component Type: ZEWM_E_SYS_PAL'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load id'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created at'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated at'),
dwh_valid_from DATE NOT NULL OPTIONS(description='Valid from date'),
dwh_valid_to DATE NOT NULL OPTIONS(description='Valid to date'),
deleted_fg BOOL NOT NULL OPTIONS(description='Flag if record is deleted'),
PRIMARY KEY (client_id, wh_nr, hu_ident, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='Read HUs for storage bins - BI reporting');