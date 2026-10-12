CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_1 AS
-- 2025-10-17, Change by Daniel Vering, AP0297866, Add buying_list_type_id

-- 2025-11-03, Change by Daniel Vering, AP0273402, Add item_sid + item_custom_need_*
 -- AP0273402
 -- AP0273402

-- AP0273402
 -- AP0273402

-- TRY_CAST(Coalesce(itm.config_item_cd,itm.src_orig_item_nr,itm.src_matnr) AS INTEGER ) AS item_nr,

-- TRY_CAST(Coalesce(itm.item_eks_cd, wawi_itm.orig_item_nr_int) AS INTEGER )           AS orig_item_nr_int,

-- 2025-10-17, Change by Daniel Vering, APxx, Add buying_list_type_id

-- 2025-11-03, Change by Daniel Vering, AP0273402, Add item_sid + item_custom_need_*
 /* core table as base quantity */
/* 2025-11-03 by Daniel Vering - AP0273402 CROSS JOIN custom_needs information - Bedürfniswelten */
/* only numerical item_1 numbers greater than 0 */ /* filter only for SAP countries */
/* filter only for WAWI countries */ /* restrictions regarding item_status */ SELECT DISTINCT country_lidl_cd,
 MAX(src_subitemgrp_cd) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
  AND UNBOUNDED FOLLOWING) AS src_subitemgrp_cd,
 MAX(src_familygrp_cd) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS src_familygrp_cd,
 MAX(vat_id) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS vat_id,
 MAX(status_id_hq) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS status_id_hq,
 item_nr,
 MAX(orig_item_nr_int) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS orig_item_nr_int,
 MAX(smallest_orderunit) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
  AND UNBOUNDED FOLLOWING) AS smallest_orderunit,
 dat_valid_from_ AS dat_valid_from,
 MAX(smallest_unit) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS smallest_unit,
 MAX(weight_item_fg) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS weight_item_fg,
 MAX(dangerous_goods_fg) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
  AND UNBOUNDED FOLLOWING) AS dangerous_goods_fg,
 MAX(list_type) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS list_type,
 MAX(brand_type_mark) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS brand_type_mark,
 MAX(val_deposit) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS val_deposit,
 buying_list_type_id_ AS buying_list_type_id,
 item_sid_ AS item_sid,
 custom_need_type_cd_ AS item_custom_need_type_cd,
 custom_need_type_desc_ AS item_custom_need_type_desc,
 custom_need_subtype_cd_ AS item_custom_need_subtype_cd,
 custom_need_subtype_desc_ AS item_custom_need_subtype_desc
FROM (SELECT CLNT.src_country_lidl_cd AS country_lidl_cd,
   ROUND(CAST(ITM_HIER.src_subitemgrp_cd AS BIGNUMERIC), 0) AS src_subitemgrp_cd,
   ROUND(CAST(REGEXP_EXTRACT_ALL(ITM_HIER.src_familygrp_cd, '[^.]+')[SAFE_OFFSET(1)] AS BIGNUMERIC), 0) AS
   src_familygrp_cd,
   COALESCE(ITM_VAT.vat_id, WAWI_ITM.vat_id) AS vat_id,
   ROUND(CAST(TRIM(SUBSTR(CAST(COALESCE(CAST(CASE
           WHEN SUBSTR(ITM_HIST.state_bges_cd, 1, 1) = 'S'
           THEN '45'
           ELSE ITM_HIST.state_bges_cd
           END AS BIGNUMERIC), WAWI_ITM.status_id_hq) AS STRING), 1, 39)) AS BIGNUMERIC), 0) AS status_id_hq,
   ROUND(CAST(COALESCE(ITM.config_item_cd, ITM.src_orig_item_nr, ITM.src_matnr) AS BIGNUMERIC), 0) AS item_nr,
   COALESCE(CAST(ITM.item_eks_cd AS BIGNUMERIC), WAWI_ITM.orig_item_nr_int) AS orig_item_nr_int,
    CASE
    WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
      
    THEN 1
    ELSE 0
    END AS is_wawi_country,
   CAST(CASE
     WHEN CASE
       WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
       THEN 1
       ELSE 0
       END = 0
     THEN NULL
     ELSE WAWI_ITM.smallest_orderunit
     END AS BIGNUMERIC) AS smallest_orderunit,
   COALESCE(ITM.src_dat_valid_from, ITM_HIST.dwh_valid_from) AS dat_valid_from_,
   CAST(CASE
     WHEN CASE
       WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
       THEN 1
       ELSE 0
       END = 0
     THEN NULL
     ELSE WAWI_ITM.smallest_unit
     END AS STRING) AS smallest_unit,
   COALESCE(scale_area.weight_item_fg, WAWI_ITM.weight_fg, 0) AS weight_item_fg,
   CAST(CASE
     WHEN ITM_HIST.hazardous_material_cd IS NULL AND (WAWI_ITM.dangerous_goods_fg IS NULL OR WAWI_ITM.dangerous_goods_fg = 0)
     THEN 0
     ELSE 1
     END AS BIGNUMERIC) AS dangerous_goods_fg,
    CASE
    WHEN CASE
      WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
        
      THEN 1
      ELSE 0
      END = 1
    THEN CASE
     WHEN WAWI_ITM.buying_list_type_id IN (7, 8, 16)
     THEN 'A'
     WHEN WAWI_ITM.buying_list_type_id IN (1, 2, 3, 4, 5, 6, 9, 10, 13, 14, 15, 17)
     THEN 'S'
     ELSE NULL
     END
    ELSE ITM_LIST_TYPE.list_type
    END AS list_type,
    CASE
    WHEN CASE
      WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
        
      THEN 1
      ELSE 0
      END = 1
    THEN CASE
     WHEN WAWI_ITM.buying_list_type_id IN (1, 3, 5, 7, 9, 11)
     THEN 'M'
     WHEN WAWI_ITM.buying_list_type_id IN (2, 4, 6, 8, 10, 12)
     THEN 'EM'
     WHEN WAWI_ITM.buying_list_type_id IN (13, 14, 15, 16, 17, 18)
     THEN 'HM'
     ELSE NULL
     END
    ELSE COALESCE(itm_brand.brand_type_mark, 'HM')
    END AS brand_type_mark,
   CAST(CASE
     WHEN CASE
       WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
       THEN 1
       ELSE 0
       END = 0
     THEN NULL
     ELSE WAWI_ITM.val_deposit
     END AS NUMERIC) AS val_deposit,
   WAWI_ITM.buying_list_type_id AS buying_list_type_id_,
   ITM.item_sid AS item_sid_,
   mrtitm.mdm_cust_need_type_cd AS custom_need_type_cd_,
   mrtitm.mdm_cust_need_type_name AS custom_need_type_desc_,
   mrtitm.mdm_cust_need_subtype_cd AS custom_need_subtype_cd_,
   mrtitm.mdm_cust_need_subtype_name AS custom_need_subtype_desc_
  FROM ldl_p_lew_core_ac.v_item_1 AS ITM
   LEFT JOIN (SELECT MRTITM.client_id,
     MRTITM.item_id,
      CASE
      WHEN MRTITM.mdm_cust_need_type_cd LIKE '%#NA#%'
      THEN 'None'
      ELSE MRTITM.mdm_cust_need_type_cd
      END AS mdm_cust_need_type_cd,
     COALESCE(REFMDM.mdm_cust_need_type_name, 'None') AS mdm_cust_need_type_name,
      CASE
      WHEN MRTITM.mdm_cust_need_subtype_cd LIKE '%#NA#%'
      THEN 'None'
      ELSE MRTITM.mdm_cust_need_subtype_cd
      END AS mdm_cust_need_subtype_cd,
     COALESCE(REFMDMSUB.mdm_cust_need_subtype_name, 'None') AS mdm_cust_need_subtype_name
    FROM ldl_p_lew_mart_lead.v_itm_item_1 AS MRTITM
     LEFT JOIN ldl_p_lew_core.t_ref_mdm_customer_need_type_1 AS REFMDM ON MRTITM.mdm_cust_need_type_cd = REFMDM.mdm_cust_need_type_cd
      
     LEFT JOIN ldl_p_lew_core.t_ref_mdm_customer_need_subtype_1 AS REFMDMSUB ON MRTITM.mdm_cust_need_subtype_cd =
      REFMDMSUB.mdm_cust_need_subtype_cd) AS mrtitm ON ITM.client_id = mrtitm.client_id AND ITM.item_sid = mrtitm.item_id
     /* fetching client information for country_lidl_cd */
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLNT ON ITM.client_id = CLNT.client_id
    /* fetching client migration data for identifying WAWI countries */
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS CLIENT_MIGRATION ON ITM.client_id = CLIENT_MIGRATION.client_id
    /* fetching historical item_1 information */
   INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS ITM_HIST ON ITM.client_id = ITM_HIST.client_id AND ITM.item_sid =
      ITM_HIST.item_sid AND CURRENT_DATE BETWEEN ITM_HIST.dwh_valid_from AND ITM_HIST.dwh_valid_to
     /* fetching information of the item_1 hierarchy_1 from a view with consolidated logic */
   INNER JOIN ldl_p_lew_bil_ac.v_item_hierarchy_1 AS ITM_HIER ON ITM.client_id = ITM_HIER.client_id AND ITM.item_sid =
     ITM_HIER.item_sid /* fetching item_1 information which are only available for wawi countries */
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS WAWI_ITM ON ITM.client_id = WAWI_ITM.client_id AND ITM.item_sid =
     WAWI_ITM.item_sid /* fetching information if it is a weight wise sold item_1 */
   LEFT JOIN (SELECT client_id,
     item_sid,
      CASE
      WHEN CAST(MAX(scale_area) AS INTEGER) IN (1000, 1001)
      THEN 1
      ELSE 0
      END AS weight_item_fg
    FROM ldl_p_lew_core_ac.v_item_pos_control_hist_1
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
    GROUP BY client_id,
     item_sid) AS scale_area ON ITM.client_id = scale_area.client_id AND ITM.item_sid = scale_area.item_sid
     /* fetching information of the item_1 listing type for sap items */
   LEFT JOIN ldl_p_lew_bil_ac.v_item_listing_type_asis_1 AS ITM_LIST_TYPE ON ITM.client_id = ITM_LIST_TYPE.client_id AND
     ITM.item_sid = ITM_LIST_TYPE.item_sid /* fetching brand_1 information */
   LEFT JOIN (SELECT DISTINCT P.client_id,
     P.item_sid,
     B.brand_descr,
      CASE
      WHEN B.brand_descr = 'M'
      THEN 'M'
      WHEN B.brand_descr <> 'M'
      THEN 'EM'
      ELSE 'HM'
      END AS brand_type_mark
    FROM ldl_p_lew_core_ac.v_pinfo_header_1 AS P
     INNER JOIN ldl_p_lew_core_ac.v_pinfo_header_hist_1 AS PH ON P.pinfo_sid = PH.pinfo_sid AND P.client_id = PH.client_id
          AND CURRENT_DATE BETWEEN PH.dwh_valid_from AND PH.dwh_valid_to AND PH.deleted_fg = 0
     INNER JOIN ldl_p_lew_core_ac.v_pinfo_detail_hist_1 AS PD_1 ON P.pinfo_sid = PD.pinfo_sid AND P.client_id = PD.client_id
          AND CURRENT_DATE BETWEEN PD.dwh_valid_from AND PD.dwh_valid_to AND PD.deleted_fg = 0
     INNER JOIN ldl_p_lew_core_ac.v_brand_descr_1 AS B ON PD.brand_sid = B.brand_sid AND PD.client_id = B.client_id AND B
       .lang_cd = 'DE'
    QUALIFY (RANK() OVER (PARTITION BY CAST(P.client_id AS STRING), CAST(P.item_sid AS STRING) ORDER BY COALESCE(PH.main_supplier_fg
           , 0) IS NULL, COALESCE(PH.main_supplier_fg, 0), P.sap_creation_dt IS NULL, P.sap_creation_dt, P.src_infnr
          IS NULL, P.src_infnr, B.brand_sid IS NULL, B.brand_sid)) = 1) AS itm_brand ON ITM.client_id = itm_brand.client_id
      AND ITM.item_sid = itm_brand.item_sid /* fetching tax information */
   LEFT JOIN ldl_p_lew_bil_ac.v_item_vat_act_1 AS ITM_VAT ON ITM.client_id = ITM_VAT.client_id AND ITM.item_sid = ITM_VAT
     .item_sid
  WHERE ROUND(SAFE_CAST(COALESCE(ITM.config_item_cd, ITM.src_orig_item_nr, ITM.src_matnr) AS BIGNUMERIC), 0) >= 0
   AND (CASE
         WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
           
         THEN 1
         ELSE 0
         END = 0 /* only Verkaufs- and Beschaffungsvariante will be in the result set */ AND ITM.log_var_cd IN ('2', '3'
         ) /* filter items considering location_1 restrictions */ AND (ITM.client_id, ITM.item_sid) IN (SELECT (IIPLH.client_id
          , IIPLH.item_sid)
        FROM ldl_p_lew_core_ac.v_location_1 AS LOC
         INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS IIPLH ON LOC.client_id = IIPLH.client_id AND LOC
            .loc_sid = IIPLH.loc_sid AND CURRENT_DATE BETWEEN IIPLH.dwh_valid_from AND IIPLH.dwh_valid_to
        WHERE LOC.wh_store_mark = 'B'
         AND LOC.global_loc_ctry_cd = 'ZV') OR CASE
         WHEN CURRENT_DATE < CLIENT_MIGRATION.migration_dat_valid_from OR CURRENT_DATE > CLIENT_MIGRATION.migration_dat_valid_to
           
         THEN 1
         ELSE 0
         END = 1 /* entries for status_id_hq will be filtered out (reason not clear) */ AND (ITM.client_id, ITM.item_sid
         ) IN (SELECT (client_id, item_sid)
         FROM (SELECT t10.client_id,
            t10.item_sid,
            t10.wh_id,
            t10.orig_item_nr,
            t10.case_size,
            t10.item_status,
            t10.item_active_fg,
            t10.item_inactive_fg,
            t10.item_status_saleable,
            t10.item_saleable_fg,
            COUNT(t10.case_size) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr RANGE BETWEEN
             UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS hq_cnt_all,
            COUNT(t10.case_size) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr, CAST(t10.case_size AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS hq_cnt_per_case_size,
            SUM(t10.item_active_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr RANGE BETWEEN
             UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sum_item_active_hq,
            SUM(t10.item_inactive_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr RANGE BETWEEN
             UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sum_item_inactive_hq,
            SUM(t10.item_saleable_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr RANGE BETWEEN
             UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sum_item_saleable_hq,
             CASE
             WHEN (SUM(t10.item_active_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
             THEN 1
             ELSE 0
             END AS item_active_hq_fg,
             CASE
             WHEN (SUM(t10.item_inactive_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
             THEN 1
             ELSE 0
             END AS item_inactive_hq_fg,
             CASE
             WHEN (SUM(t10.item_saleable_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr
                RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
             THEN 1
             ELSE 0
             END AS item_saleable_hq_fg,
            SUM(t10.item_active_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr, CAST(t10.case_size AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sum_item_active_per_case_size,
            SUM(t10.item_inactive_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr, CAST(t10.case_size AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sum_item_inactive_per_case_size,
            SUM(t10.item_saleable_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr, CAST(t10.case_size AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sum_item_saleable_per_case_size,
             CASE
             WHEN (SUM(t10.item_active_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr, CAST(t10.case_size AS STRING)
                  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
             THEN 1
             ELSE 0
             END AS item_active_per_case_size_fg,
             CASE
             WHEN (SUM(t10.item_inactive_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr, CAST(t10.case_size AS STRING)
                  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
             THEN 1
             ELSE 0
             END AS item_inactive_per_case_size_fg,
             CASE
             WHEN (SUM(t10.item_saleable_fg) OVER (PARTITION BY CAST(t10.client_id AS STRING), t10.orig_item_nr, CAST(t10.case_size AS STRING)
                  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
             THEN 1
             ELSE 0
             END AS item_saleable_per_case_size_fg
           FROM (SELECT ITM_SUB.client_id,
              ITM_SUB.item_sid,
              FIND_ITEM_SID.src_orig_wh_nr AS wh_id,
              FIND_ITEM_SID.src_orig_item_nr AS orig_item_nr,
              ROUND(SAFE_CAST(ITM_SUB.src_case_size AS BIGNUMERIC), 0) AS case_size,
              WAWI_ITM_ITEM_WH_SUB.item_status,
               CASE
               WHEN WAWI_ITM_ITEM_WH_SUB.item_status BETWEEN 5 AND 11
               THEN 1
               ELSE 0
               END AS item_active_fg,
               CASE
               WHEN WAWI_ITM_ITEM_WH_SUB.item_status NOT BETWEEN 5 AND 11
               THEN 1
               ELSE 0
               END AS item_inactive_fg,
               CASE
               WHEN WAWI_ITM_ITEM_WH_SUB.item_status BETWEEN 5 AND 13
               THEN WAWI_ITM_ITEM_WH_SUB.item_status
               ELSE CAST(- 999 AS BIGNUMERIC)
               END AS item_status_saleable,
               CASE
               WHEN WAWI_ITM_ITEM_WH_SUB.item_status BETWEEN 5 AND 13
               THEN 1
               ELSE 0
               END AS item_saleable_fg
             FROM ldl_p_lew_core_ac.v_item_1 AS ITM_SUB
              INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS WAWI_ITM_ITEM_WH_SUB ON ITM_SUB.client_id =
                  WAWI_ITM_ITEM_WH_SUB.client_id AND ITM_SUB.item_sid = WAWI_ITM_ITEM_WH_SUB.item_sid AND
                 WAWI_ITM_ITEM_WH_SUB.item_status BETWEEN 5 AND 13
                 /* old interface version considered only ITEM_STATUS 5-13 */ AND CURRENT_DATE BETWEEN
                WAWI_ITM_ITEM_WH_SUB.dat_rec_start AND WAWI_ITM_ITEM_WH_SUB.dat_rec_end
                /* Subsequent view determines one ITEM_SID per ORIG_ITEM_NR by applying the "6-Stufen-Logik" */
                /* changed from LDL.p_lew_mart_wfm_ac.v_find_item_sid_1 in version 2.7 */
              INNER JOIN ldl_p_lew_precore_ac.v_item_map_key_oin_wh_hist_1 AS FIND_ITEM_SID ON ITM_SUB.client_id =
                  FIND_ITEM_SID.client_id AND ITM_SUB.item_sid = FIND_ITEM_SID.item_sid AND WAWI_ITM_ITEM_WH_SUB.wh_loc_sid
                  = FIND_ITEM_SID.loc_sid_wh AND CURRENT_DATE BETWEEN FIND_ITEM_SID.dwh_valid_from AND FIND_ITEM_SID.dwh_valid_to
                /* only items from WAWI countries */
              INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS CLIENT_MIGRATION0 ON ITM_SUB.client_id =
                CLIENT_MIGRATION0.client_id AND (CURRENT_DATE < CLIENT_MIGRATION0.migration_dat_valid_from OR
                  CURRENT_DATE > CLIENT_MIGRATION0.migration_dat_valid_to)
             GROUP BY ITM_SUB.client_id,
              ITM_SUB.item_sid,
              wh_id,
              orig_item_nr,
              case_size,
              WAWI_ITM_ITEM_WH_SUB.item_status,
              item_active_fg,
              item_inactive_fg,
              item_status_saleable,
              item_saleable_fg) AS t10) AS sub_wawi_itm_wh_data
         QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), orig_item_nr ORDER BY
               item_active_per_case_size_fg IS NULL, item_active_per_case_size_fg, hq_cnt_per_case_size IS NULL,
               hq_cnt_per_case_size, item_saleable_fg IS NULL, item_saleable_fg, item_status_saleable IS NULL,
               item_status_saleable, item_sid IS NULL, item_sid)) = 1) AND WAWI_ITM.status_id_hq NOT IN (1, 2, 15))
  QUALIFY dat_valid_from_ = (MAX(dat_valid_from_) OVER (PARTITION BY country_lidl_cd, CAST(item_nr AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS wfm_item_data;