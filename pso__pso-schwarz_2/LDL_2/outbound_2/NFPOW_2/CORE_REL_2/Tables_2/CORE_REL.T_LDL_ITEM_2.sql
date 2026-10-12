CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_item_2 (
ldl_item_sid BIGNUMERIC(38,0) NOT NULL,
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
ldl_item_nr BIGNUMERIC(38,0),
case_size_qty BIGNUMERIC(38,5),
active_from_dt DATE,
ldl_brand_list_type_id BIGNUMERIC(38,0)
OPTIONS(description='WAWI: P_LEW_MART_MSI_AC_MATERIALIZED.v_ref_itm_list_type_buylist_2'),
ldl_list_type_id BIGNUMERIC(38,0) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.listing_type_id'),
ldl_brand_name STRING(100) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.brand_2'),
ldl_item_fam_grp_nr BIGNUMERIC(38,0) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_familygroup_id'),
ldl_sub_item_grp_id BIGNUMERIC(38,0),
ldl_item_name STRING(100) OPTIONS(description='WAWI:p_lew_mart_lead_ac.V_ITM_ITEM.item_desc'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_item_sid) NOT ENFORCED
)
OPTIONS(description='-Level wie in p_lew_core.t_item_2, key ist ldl_item_sid (aus item_sid)              WAWI: p_lew_mart_lead_ac.V_ITM_ITEM_2             Spalten: item_id,client_id,orig_item_nr,case_size,dat_valid_from             ,buying_list_type_id,listing_type_id,brand_2,subitemgroup_id,item_desc,item_familygroup_id             ');