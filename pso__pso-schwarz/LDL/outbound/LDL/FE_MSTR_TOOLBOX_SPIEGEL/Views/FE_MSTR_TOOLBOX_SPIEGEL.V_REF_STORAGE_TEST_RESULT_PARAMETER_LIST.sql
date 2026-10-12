/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_PRICE_LABEL_STORE
#----------------------------------------------------------------------------------------------------------------
# History:
#
#  1.2  20.05.2024    Simeon Nikolaev					  CREATION
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_storage_test_result_parameter_list (reconstructin_week_list_display
, reconstructin_week_list_display_desc, reconstructin_week_list_display_desc_de, reconstructin_week_list_display_desc_ch
, reconstructin_week_list_display_desc_at, reconstructin_week_list_display_desc_be_fr,
reconstructin_week_list_display_desc_bg, reconstructin_week_list_display_desc_cy,
reconstructin_week_list_display_desc_cz, reconstructin_week_list_display_desc_dk,
reconstructin_week_list_display_desc_es, reconstructin_week_list_display_desc_fi,
reconstructin_week_list_display_desc_fr, reconstructin_week_list_display_desc_gb,
reconstructin_week_list_display_desc_gr, reconstructin_week_list_display_desc_hr,
reconstructin_week_list_display_desc_hu, reconstructin_week_list_display_desc_ie,
reconstructin_week_list_display_desc_it, reconstructin_week_list_display_desc_lt,
reconstructin_week_list_display_desc_ni, reconstructin_week_list_display_desc_nl,
reconstructin_week_list_display_desc_pl, reconstructin_week_list_display_desc_pt,
reconstructin_week_list_display_desc_ro, reconstructin_week_list_display_desc_se,
reconstructin_week_list_display_desc_si, reconstructin_week_list_display_desc_sk,
reconstructin_week_list_display_desc_cs, reconstructin_week_list_display_desc_mt,
reconstructin_week_list_display_desc_us, reconstructin_week_list_display_desc_rs) AS SELECT
 reconstructin_week_list_display,
 reconstructin_week_list_display AS reconstructin_week_list_display_desc,
 reconstructin_week_list_display AS reconstructin_week_list_display_desc_de,
 reconstructin_week_list_display AS reconstructin_week_list_display_desc_ch,
 reconstructin_week_list_display AS reconstructin_week_list_display_desc_at,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_be_fr,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_bg,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_cy,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_cz,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_dk,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_es,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_fi,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_fr,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_gb,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_gr,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_hr,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_hu,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_ie,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_it,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_lt,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_ni,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_nl,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_pl,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_pt,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_ro,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_se,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_si,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_sk,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_cs,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_mt,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_us,
 reconstructin_week_list_display_eng AS reconstructin_week_list_display_desc_rs
FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_list;