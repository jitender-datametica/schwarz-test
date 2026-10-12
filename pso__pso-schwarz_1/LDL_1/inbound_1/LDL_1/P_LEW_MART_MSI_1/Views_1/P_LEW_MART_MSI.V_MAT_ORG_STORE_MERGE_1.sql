CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_STORE_MERGE_1 COMMENT='Prepare Warehouse/Store Information'
AS
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.t_org_store_merge.
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2018    Khusainov, Timur            Initiliazation
#  1.1  06.08.2020    Roy,Ritanjal                Introducing new country_1 Latviya
#  1.2  27.01.2021    Michael Morris              Set wh_id to NULL if aspect_id = 2 and no salesperson configured.
#                                                 Code standard changes
#                                                 20210127_2724_set_wh_id_null
#                                                 https://jira.schwarz/browse/REP4-8444
#  1.3  15.02.2021    Michael Morris              Transfer to Snowflake
#                                                 https://jira.schwarz/browse/REP4-8582
#  1.4  17.12.2021    Michael Morris              Add Estonia EE
#  1.5  31.05.2022    Zied Nanaa                  INC3727878_INTB105_WH_DESC_NULL
#                                                 https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/332856
#----------------------------------------------------------------------------
*/
SELECT
      sM.store_id
    , sM.client_id
    , oSP.dat_opening
    , sM.dat_real_opening
    , oSP.dat_closing
    , sM.dat_valid_from
    , sM.object_nr
    , sM.licence_nr
    , sM.pst_lang_cd
    , sM.mde_print_cd
    , sM.closed_fg
    , sM.mde_lang_cd
    , sM.ord_unit_valid_store_cd
    , oSP.test_store_fg
    , sM.transfer_fg
    , oSP.store_desc
    , oSP.orig_store_nr
      /* Version 1.2 change */
    , CASE WHEN sM.aspect_id = 2 AND oSP.mis_store_active_fg = 0 AND wME.wh_desc IS NULL
           THEN CAST(NULL AS INTEGER)
           ELSE aSM.wh_id
      END                                     AS wh_id
      /* End of Version 1.2 change */
    , sM.cnt_open_days
    , sM.qty_min_dflt
    , oSP.dat_calc_start_py
    , oSP.dat_calc_end_py
    , oSP.dat_calc_start_ppy
    , oSP.dat_opening_ovis
    , oSP.dat_closing_ovis
    , oSP.objectstatus_id
    , oSP.mis_store_active_fg
    , sM.move_to_store_id
    , oSP.move_fg
    , sM.aspect_id
    , sC.zipcode
    , sC.city
    , sC.street
    , sC.postbox
    , sC.phone
    , sC.fax
    , sC.zipcode_postbox
    , sC.modem
    , aSM.move_store_desc
    , COALESCE(aSM.wh_id_exp, -1335)          AS wh_id_exp
    , aSM.sales_manager_id
    , aSM.longitude
    , aSM.latitude
    , COALESCE(sMM.account_manager_id, -1335) AS account_manager_id
    , sMM.sales_manager_name
    , aMM.account_manager_name
    , wME.country_cd
    , COALESCE(wME.gl_region_id, -1335)       AS gl_region_id
    , wME.costcenter_cd
    , wME.company
    , wME.order_buying_list_cd
    , wME.vat_region_nr
    , wME.region_cd
    , wME.stock_plain
    , wME.sponsion
    , wME.global_location_nr
    , wME.wh_desc
    , wME.distribute_wh_fg
    , wME.int_fg
    , wME.hq_fg
    , wME.prop_wh_fg
    , wME.sales_wh_fg
    , wME.supp_wh_fg
    , wME.wawi_data_fg
    , wME.ovis_data_fg
    , wME.parent_wh_id
    , wME.buying_region
    , rME.gl_region_desc
    , rME.gl_last_name
    , rME.gl_first_name
    , COALESCE(cLE.int_id, -1335)             AS int_id
    , cLE.country_iso_cd
    , cLE.country_group_id
    , cLE.lisy_sort
    , cLE.dashboard_relevant_fg
    , cLE.country_desc_AT
    , cLE.country_desc_BE
    , cLE.country_desc_BG
    , cLE.country_desc_CH
    , cLE.country_desc_CY
    , cLE.country_desc_CZ
    , cLE.country_desc
    , cLE.country_desc_DK
    , cLE.country_desc_EE
    , cLE.country_desc_ES
    , cLE.country_desc_FI
    , cLE.country_desc_FR
    , cLE.country_desc_GB
    , cLE.country_desc_GR
    , cLE.country_desc_HR
    , cLE.country_desc_HU
    , cLE.country_desc_IE
    , cLE.country_desc_IT
    , cLE.country_desc_LT
    , cLE.country_desc_LV
    , cLE.country_desc_NI
    , cLE.country_desc_NL
    , cLE.country_desc_DE
    , cLE.country_desc_PL
    , cLE.country_desc_PT
    , cLE.country_desc_RO
    , cLE.country_desc_SE
    , cLE.country_desc_SI
    , cLE.country_desc_SK
    , cLE.country_desc_CS
    , cLE.country_desc_MT
    , cLE.country_desc_US
    , cLE.country_desc_RS
    , cLE.country_opening_date
FROM p_lew_mart_msi.v_mat0_org_store_merge_1                     AS sM_1
LEFT OUTER JOIN p_lew_mart_msi.v_mat_org_store_pre_1             AS oSP
             ON sM.client_id        = oSP.client_id
            AND sM.store_id         = oSP.store_id
LEFT OUTER JOIN p_lew_mart_msi.v_mat_org_store_contact_1         AS sC
             ON sM.client_id        = sC.client_id
            AND sM.store_id         = sC.store_id
LEFT OUTER JOIN p_lew_mart_msi.v_mat_org_all_store_merge_1       AS aSM
             ON sM.client_id        = aSM.client_id
            AND sM.aspect_id        = aSM.aspect_id
            AND sM.move_to_store_id = aSM.move_to_store_id
LEFT OUTER JOIN p_lew_mart_msi.v_mat_org_sales_manager_merge_1   AS sMM
             ON aSM.aspect_id        = sMM.aspect_id
            AND aSM.client_id        = sMM.client_id
            AND aSM.wh_id            = sMM.wh_id
            AND aSM.wh_id_exp        = sMM.wh_id_exp
            AND aSM.sales_manager_id = sMM.sales_manager_id
LEFT OUTER JOIN p_lew_mart_msi.v_mat_org_account_manager_merge_1 AS aMM
             ON sMM.aspect_id          = aMM.aspect_id
            AND sMM.client_id          = aMM.client_id
            AND sMM.wh_id              = aMM.wh_id
            AND sMM.account_manager_id = aMM.account_manager_id
LEFT OUTER JOIN p_lew_mart_msi.v_mat_org_wh_merge_1              AS wME
             ON aSM.client_id          = wME.client_id
            AND aSM.aspect_id          = wME.aspect_id
            AND aSM.wh_id              = wME.wh_id
LEFT OUTER JOIN p_lew_mart_msi.v_mat_ref_gl_region_merge_1       AS rME
             ON wME.aspect_id          = rME.aspect_id
            AND wME.client_id          = rME.client_id
            AND wME.gl_region_id       = rME.gl_region_id
LEFT OUTER JOIN p_lew_mart_msi.v_mat_ref_client_lead_1           AS cLE
             ON sM.client_id           = cLE.client_id
;
