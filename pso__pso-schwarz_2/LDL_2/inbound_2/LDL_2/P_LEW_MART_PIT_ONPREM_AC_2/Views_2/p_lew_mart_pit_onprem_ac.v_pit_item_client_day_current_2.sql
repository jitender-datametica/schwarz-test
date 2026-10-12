CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_ITEM_CLIENT_DAY_CURRENT_2
AS
SELECT
client_id
,dwh_cal_dt
,cy_year
,cy_month
,iso_year_week
,adv_week_id
,lang_sid
,weekday_nr
,weekday_descr
,weekday_sdescr
,dwh_cal_dt_ldescr
,cy_month_descr
,item_sid
,item_mstr_sid
,item_fam_grp_sid -- uwg_af_sid

,brand_sid
,sub_item_grp_sid --uwg_sid

,item_grp_int_sid --wgi_sid

,orig_item_nr
,item_descr_int
,item_descr
,item_variant_descr_int
,item_variant_descr
,src_familygrp_id --uwg_af_id

,src_familygrp_cd --uwg_af_cd

,item_fam_grp_name --uwg_af_desc_int

,item_fam_grp_descr --uwg_af_desc_loc

,src_subitemgrp_id --uwg_id

,src_subitemgrp_cd --uwg_cd

,sub_item_grp_name --uwg_desc_int

,src_itemgrp_int_id --wgi_id

,src_itemgrp_int_cd --wgi_cd

,item_grp_int_name --wgi_desc_int

,item_grp_int_descr --wgi_desc_loc

,brand_name_int
,brand_descr
,buying_list_type_id
,buying_list_type_descr
,buying_list_type_group_id
,buying_list_type_group_descr
,listing_type_id
,listing_type_descr
,listing_type_group_id
,listing_type_group_descr
,listing_fg
,action_type_id
,marke_em_descr
,case_size
,marke_fg
,em_fg
FROM p_lew_mart_pit_onprem.v_pit_item_client_day_current_2;