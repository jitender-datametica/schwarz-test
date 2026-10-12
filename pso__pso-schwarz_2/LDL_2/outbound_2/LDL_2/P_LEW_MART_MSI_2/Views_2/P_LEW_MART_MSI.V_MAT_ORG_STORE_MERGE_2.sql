/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.t_org_store_merge.
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2018    Khusainov, Timur            Initiliazation
#  1.1  06.08.2020    Roy,Ritanjal                Introducing new country_2 Latviya
#  1.2  27.01.2021    Michael Morris              Set wh_id to NULL if aspect_id = 2 and no salesperson configured.
#                                                 Code standard changes
#                                                 20210127_2724_set_wh_id_null
#                                                 https://jira.schwarz/browse/REP4-8444
#  1.3  15.02.2021    Michael Morris              Transfer to Snowflake
#                                                 https://jira.schwarz/browse/REP4-8582
#  1.4  17.12.2021    Michael Morris              Add Estonia EE
#  1.5  31.05.2022    Zied Nanaa                  INC3727878_INTB105_WH_DESC_NULL
#                                                 https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/332856
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_org_store_merge_2
OPTIONS(DESCRIPTION = `PREPARE WAREHOUSE/STORE INFORMATION`) AS /* End of Version 1.2 change */ SELECT SM.store_id,
 SM.client_id,
 OSP.dat_opening,
 SM.dat_real_opening,
 OSP.dat_closing,
 SM.dat_valid_from,
 SM.object_nr,
 SM.licence_nr,
 SM.pst_lang_cd,
 SM.mde_print_cd,
 SM.closed_fg,
 SM.mde_lang_cd,
 SM.ord_unit_valid_store_cd,
 OSP.test_store_fg,
 SM.transfer_fg,
 OSP.store_desc,
 OSP.orig_store_nr /* Version 1.2 change */,
  CASE
  WHEN SM.aspect_id = 2 AND OSP.mis_store_active_fg = 0 AND WME.wh_desc IS NULL
  THEN NULL
  ELSE ASM.wh_id
  END AS wh_id,
 SM.cnt_open_days,
 SM.qty_min_dflt,
 OSP.dat_calc_start_py,
 OSP.dat_calc_end_py,
 OSP.dat_calc_start_ppy,
 OSP.dat_opening_ovis,
 OSP.dat_closing_ovis,
 OSP.objectstatus_id,
 OSP.mis_store_active_fg,
 SM.move_to_store_id,
 OSP.move_fg,
 SM.aspect_id,
 SC.zipcode,
 SC.city,
 SC.street,
 SC.postbox,
 SC.phone,
 SC.fax,
 SC.zipcode_postbox,
 SC.modem,
 ASM.move_store_desc,
 COALESCE(ASM.wh_id_exp, - 1335) AS wh_id_exp,
 ASM.sales_manager_id,
 ASM.longitude,
 ASM.latitude,
 COALESCE(SMM.account_manager_id, - 1335) AS account_manager_id,
 SMM.sales_manager_name,
 AMM.account_manager_name,
 WME.country_cd,
 COALESCE(WME.gl_region_id, - 1335) AS gl_region_id,
 WME.costcenter_cd,
 WME.company,
 WME.order_buying_list_cd,
 WME.vat_region_nr,
 WME.region_cd,
 WME.stock_plain,
 WME.sponsion,
 WME.global_location_nr,
 WME.wh_desc,
 WME.distribute_wh_fg,
 WME.int_fg,
 WME.hq_fg,
 WME.prop_wh_fg,
 WME.sales_wh_fg,
 WME.supp_wh_fg,
 WME.wawi_data_fg,
 WME.ovis_data_fg,
 WME.parent_wh_id,
 WME.buying_region,
 RME.gl_region_desc,
 RME.gl_last_name,
 RME.gl_first_name,
 COALESCE(CLE.int_id, - 1335) AS int_id,
 CLE.country_iso_cd,
 CLE.country_group_id,
 CLE.lisy_sort,
 CLE.dashboard_relevant_fg,
 CLE.country_desc_at,
 CLE.country_desc_be,
 CLE.country_desc_bg,
 CLE.country_desc_ch,
 CLE.country_desc_cy,
 CLE.country_desc_cz,
 CLE.country_desc,
 CLE.country_desc_dk,
 CLE.country_desc_ee,
 CLE.country_desc_es,
 CLE.country_desc_fi,
 CLE.country_desc_fr,
 CLE.country_desc_gb,
 CLE.country_desc_gr,
 CLE.country_desc_hr,
 CLE.country_desc_hu,
 CLE.country_desc_ie,
 CLE.country_desc_it,
 CLE.country_desc_lt,
 CLE.country_desc_lv,
 CLE.country_desc_ni,
 CLE.country_desc_nl,
 CLE.country_desc_de,
 CLE.country_desc_pl,
 CLE.country_desc_pt,
 CLE.country_desc_ro,
 CLE.country_desc_se,
 CLE.country_desc_si,
 CLE.country_desc_sk,
 CLE.country_desc_cs,
 CLE.country_desc_mt,
 CLE.country_desc_us,
 CLE.country_desc_rs,
 CLE.country_opening_date
FROM ldl_p_lew_mart_msi.v_mat0_org_store_merge_2 AS SM_2
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_org_store_pre_2 AS OSP ON SM.client_id = OSP.client_id AND SM.store_id = OSP.store_id
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_org_store_contact_2 AS SC ON SM.client_id = SC.client_id AND SM.store_id = SC.store_id
   
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_org_all_store_merge_2 AS ASM ON SM.client_id = ASM.client_id AND SM.aspect_id = ASM.aspect_id
     AND SM.move_to_store_id = ASM.move_to_store_id
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_org_sales_manager_merge_2 AS SMM ON ASM.aspect_id = SMM.aspect_id AND ASM.client_id =
      SMM.client_id AND ASM.wh_id = SMM.wh_id AND ASM.wh_id_exp = SMM.wh_id_exp AND ASM.sales_manager_id = SMM.sales_manager_id
   
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_org_account_manager_merge_2 AS AMM ON SMM.aspect_id = AMM.aspect_id AND SMM.client_id
     = AMM.client_id AND SMM.wh_id = AMM.wh_id AND SMM.account_manager_id = AMM.account_manager_id
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_org_wh_merge_2 AS WME ON ASM.client_id = WME.client_id AND ASM.aspect_id = WME.aspect_id
     AND ASM.wh_id = WME.wh_id
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_ref_gl_region_merge_2 AS RME ON WME.aspect_id = RME.aspect_id AND WME.client_id = RME
    .client_id AND WME.gl_region_id = RME.gl_region_id
 LEFT JOIN ldl_p_lew_mart_msi.v_mat_ref_client_lead_2 AS CLE ON SM.client_id = CLE.client_id;