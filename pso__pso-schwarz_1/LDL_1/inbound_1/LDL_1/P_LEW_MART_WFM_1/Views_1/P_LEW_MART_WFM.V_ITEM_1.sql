CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_1
AS
SELECT DISTINCT
     country_lidl_cd                                                            AS country_lidl_cd
     ,MAX(src_subitemgrp_cd  ) Over (PARTITION BY country_lidl_cd, item_nr)     AS src_subitemgrp_cd
     ,MAX(src_familygrp_cd   ) Over (PARTITION BY country_lidl_cd, item_nr)     AS src_familygrp_cd
     ,MAX(vat_id             ) Over (PARTITION BY country_lidl_cd, item_nr)     AS vat_id
     ,MAX(status_id_hq       ) Over (PARTITION BY country_lidl_cd, item_nr)     AS status_id_hq
     ,item_nr                                                                   AS item_nr
     ,MAX(orig_item_nr_int   ) Over (PARTITION BY country_lidl_cd, item_nr)     AS orig_item_nr_int
     ,MAX(smallest_orderunit ) Over (PARTITION BY country_lidl_cd, item_nr)     AS smallest_orderunit
     ,dat_valid_from_                                                           AS dat_valid_from
     ,MAX(smallest_unit      ) Over (PARTITION BY country_lidl_cd, item_nr)     AS smallest_unit
     ,MAX(weight_item_fg     ) Over (PARTITION BY country_lidl_cd, item_nr)     AS weight_item_fg
     ,MAX(dangerous_goods_fg ) Over (PARTITION BY country_lidl_cd, item_nr)     AS dangerous_goods_fg
     ,MAX(list_type          ) Over (PARTITION BY country_lidl_cd, item_nr)     AS list_type
     ,MAX(brand_type_mark    ) Over (PARTITION BY country_lidl_cd, item_nr)     AS brand_type_mark
     ,MAX(val_deposit        ) Over (PARTITION BY country_lidl_cd, item_nr)     AS val_deposit
     ,buying_list_type_id_                                                      AS buying_list_type_id             -- 2025-10-17, Change by Daniel Vering, AP0297866, Add buying_list_type_id 
     ,item_sid_                                                                 AS item_sid                        -- 2025-11-03, Change by Daniel Vering, AP0273402, Add item_sid + item_custom_need_* 
     ,custom_need_type_cd_                                                      AS item_custom_need_type_cd           -- AP0273402
     ,custom_need_type_desc_                                                    AS item_custom_need_type_desc         -- AP0273402
     ,custom_need_subtype_cd_                                                   AS item_custom_need_subtype_cd        -- AP0273402
     ,custom_need_subtype_desc_                                                 AS item_custom_need_subtype_desc      -- AP0273402

FROM
     (SELECT
          clnt.src_country_lidl_cd                                                                                                                                                   AS country_lidl_cd
          ,CAST(itm_hier.src_subitemgrp_cd AS INTEGER)                                                                                                                               AS src_subitemgrp_cd
          ,CAST(STRTOK(itm_hier.src_familygrp_cd, '.', 2) AS INTEGER)                                                                                                                AS src_familygrp_cd
          ,COALESCE(itm_vat.vat_id, wawi_itm.vat_id)                                                                                                                                 AS vat_id
          ,TO_NUMBER(Trim(COALESCE(CASE WHEN SUBSTR( itm_hist.state_bges_cd, 1, 1) = 'S' THEN '45' ELSE itm_hist.state_bges_cd END ,wawi_itm.status_id_hq)))                         AS status_id_hq

          --TRY_CAST(Coalesce(itm.config_item_cd,itm.src_orig_item_nr,itm.src_matnr) AS BIGINT) AS item_nr,
          --TRY_CAST(Coalesce(itm.item_eks_cd, wawi_itm.orig_item_nr_int) AS BIGINT)           AS orig_item_nr_int,
 
          ,TO_NUMBER(COALESCE(itm.config_item_cd,itm.src_orig_item_nr,itm.src_matnr))                                                                                                AS item_nr
          ,TO_NUMBER(COALESCE(itm.item_eks_cd, wawi_itm.orig_item_nr_int))                                                                                                           AS orig_item_nr_int
 
          ,CASE WHEN (CURRENT_DATE < client_migration.migration_dat_valid_from  OR CURRENT_DATE > client_migration.migration_dat_valid_to) THEN 1 ELSE 0 END                         AS is_wawi_country
          ,CAST(CASE WHEN is_wawi_country = 0 THEN NULL ELSE wawi_itm.smallest_orderunit END AS SMALLINT)                                                                            AS smallest_orderunit
          ,COALESCE(itm.src_dat_valid_from,itm_hist.dwh_valid_from)                                                                                                                  AS dat_valid_from_
          ,CAST(CASE WHEN is_wawi_country = 0 THEN NULL ELSE wawi_itm.smallest_unit END AS VARCHAR(10))                                                                              AS smallest_unit
          ,CAST(COALESCE(scale_area.weight_item_fg, wawi_itm.weight_fg, 0) AS DECIMAL(10,0))                                                                                         AS weight_item_fg
          ,CAST(CASE WHEN (itm_hist.hazardous_material_cd IS NULL AND (wawi_itm.dangerous_goods_fg IS NULL OR wawi_itm.dangerous_goods_fg = 0)) 
                         THEN 0 ELSE 1 END  AS BYTEINT)                                                                                                                              AS dangerous_goods_fg
          ,CASE WHEN is_wawi_country = 1 THEN ( CASE WHEN wawi_itm.buying_list_type_id IN (7,8,16) 
                                                       THEN 'A' 
                                                             WHEN wawi_itm.buying_list_type_id IN (1,2,3,4,5,6,9,10,13,14,15,17) 
                                                                 THEN 'S' ELSE NULL END) 
                                                       ELSE itm_list_type.list_type 
                                                       END                                                                                                                           AS list_type
          ,CASE WHEN is_wawi_country = 1 
                    THEN ( CASE WHEN wawi_itm.buying_list_type_id IN (1,3,5,7,9,11) THEN 'M' WHEN wawi_itm.buying_list_type_id IN (2,4,6,8,10,12) THEN 'EM' 
                           WHEN wawi_itm.buying_list_type_id IN (13,14,15,16,17,18) THEN 'HM' ELSE NULL END )
                    ELSE Coalesce(itm_brand.brand_type_mark, 'HM') END                                                                                                               AS brand_type_mark
          ,CAST(CASE WHEN is_wawi_country = 0 THEN NULL ELSE wawi_itm.val_deposit END  AS DECIMAL(9,2))                                                                              AS val_deposit
          ,wawi_itm.buying_list_type_id                                                                                                                                              AS buying_list_type_id_      -- 2025-10-17, Change by Daniel Vering, APxx, Add buying_list_type_id 
          ,TO_NUMBER(itm.item_sid)                                                                                                                                                   AS item_sid_                 -- 2025-11-03, Change by Daniel Vering, AP0273402, Add item_sid + item_custom_need_* 
          ,mrtitm.mdm_cust_need_type_cd                                                                                                                                              AS custom_need_type_cd_ 
          ,mrtitm.mdm_cust_need_type_name                                                                                                                                            AS custom_need_type_desc_ 
          ,mrtitm.mdm_cust_need_subtype_cd                                                                                                                                           AS custom_need_subtype_cd_ 
          ,mrtitm.mdm_cust_need_subtype_name                                                                                                                                         AS custom_need_subtype_desc_


     /* core table as base quantity */
     FROM p_lew_core_ac.v_item_1 AS itm

     /* 2025-11-03 by Daniel Vering - AP0273402 Join custom_needs information - Bedürfniswelten */
     LEFT JOIN 
     (SELECT
         mrtitm.client_id
        ,mrtitm.item_id
        ,CASE WHEN mrtitm.mdm_cust_need_type_cd LIKE '%#NA#%' THEN 'None' ELSE mrtitm.mdm_cust_need_type_cd END             AS mdm_cust_need_type_cd
        ,COALESCE(refmdm.mdm_cust_need_type_name, 'None')                                                                   AS mdm_cust_need_type_name
        ,CASE WHEN mrtitm.mdm_cust_need_subtype_cd LIKE '%#NA#%' THEN 'None' ELSE mrtitm.mdm_cust_need_subtype_cd END       AS mdm_cust_need_subtype_cd
        ,COALESCE(refmdmsub.mdm_cust_need_subtype_name, 'None')                                                             AS mdm_cust_need_subtype_name    

        FROM p_lew_mart_lead.v_itm_item_1 AS mrtitm

        LEFT JOIN p_lew_core.t_ref_mdm_customer_need_type_1 refmdm
        ON refmdm.mdm_cust_need_type_cd = mrtitm.mdm_cust_need_type_cd
        
        LEFT JOIN p_lew_core.t_ref_mdm_customer_need_subtype_1 refmdmsub
        ON refmdmsub.mdm_cust_need_subtype_cd = mrtitm.mdm_cust_need_subtype_cd
  
     ) AS mrtitm
     ON itm.client_id = mrtitm.client_id AND itm.item_sid = mrtitm.item_id


    
     /* fetching client information for country_lidl_cd */
     INNER JOIN p_lew_core_ac.v_client_1 AS clnt
     ON itm.client_id = clnt.client_id
     
     /* fetching client migration data for identifying WAWI countries */
     INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS client_migration
     ON itm.client_id = client_migration.client_id
     
     /* fetching historical item_1 information */
     INNER JOIN p_lew_core_ac.v_item_hist_1 AS itm_hist
     ON itm.client_id = itm_hist.client_id
     AND itm.item_sid = itm_hist.item_sid
     AND Current_Date BETWEEN itm_hist.dwh_valid_from AND itm_hist.dwh_valid_to

     /* fetching information of the item_1 hierarchy_1 from a view with consolidated logic */
     INNER JOIN p_lew_bil_ac.v_item_hierarchy_1 AS itm_hier
     ON itm.client_id = itm_hier.client_id
     AND itm.item_sid = itm_hier.item_sid
     
     /* fetching item_1 information which are only available for wawi countries */
     LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 AS wawi_itm
     ON itm.client_id = wawi_itm.client_id
     AND itm.item_sid = wawi_itm.item_sid
     
     /* fetching information if it is a weight wise sold item_1 */
     LEFT OUTER JOIN
     (SELECT
          client_id
         ,item_sid
         ,CASE WHEN MAX(scale_area) IN (1000,1001) THEN 1 ELSE 0 END AS weight_item_fg

     FROM p_lew_core_ac.v_item_pos_control_hist_1
     
     WHERE Current_Date BETWEEN dwh_valid_from AND dwh_valid_to
     GROUP BY client_id,item_sid

     ) AS scale_area

     ON itm.client_id = scale_area.client_id AND itm.item_sid = scale_area.item_sid

     /* fetching information of the item_1 listing type for sap items */
     LEFT OUTER JOIN p_lew_bil_ac.v_item_listing_type_asis_1 AS itm_list_type
     ON itm.client_id = itm_list_type.client_id AND itm.item_sid = itm_list_type.item_sid

     /* fetching brand_1 information */
     LEFT OUTER JOIN
     (SELECT DISTINCT
          p.client_id
          ,p.item_sid
          ,b.brand_descr
          ,CASE WHEN b.brand_descr='M'  THEN 'M' WHEN b.brand_descr<>'M' THEN 'EM' ELSE 'HM' END brand_type_mark

          FROM p_lew_core_ac.v_pinfo_header_1 AS p

          INNER JOIN p_lew_core_ac.v_pinfo_header_hist_1 AS ph
          ON p.pinfo_sid = ph.pinfo_sid AND p.client_id = ph.client_id AND Current_Date BETWEEN ph.dwh_valid_from AND ph.dwh_valid_to AND ph.deleted_fg = 0

     INNER JOIN p_lew_core_ac.v_pinfo_detail_hist_1 AS pd_1
     ON p.pinfo_sid = pd.pinfo_sid AND p.client_id = pd.client_id AND Current_Date BETWEEN pd.dwh_valid_from AND pd.dwh_valid_to AND pd.deleted_fg = 0

     INNER JOIN p_lew_core_ac.v_brand_descr_1 AS b
     ON b.brand_sid = pd.brand_sid AND b.client_id = pd.client_id AND b.lang_cd = 'DE'

     QUALIFY Rank() Over
     (PARTITION BY p.client_id, p.item_sid ORDER BY Coalesce(ph.main_supplier_fg, 0) DESC NULLS LAST, p.sap_creation_dt DESC NULLS LAST, p.src_infnr DESC NULLS LAST, b.brand_sid) = 1) AS itm_brand
     ON itm.client_id = itm_brand.client_id
     AND itm.item_sid = itm_brand.item_sid

     /* fetching tax information */
     LEFT OUTER JOIN p_lew_bil_ac.v_item_vat_act_1 AS itm_vat
     ON itm.client_id = itm_vat.client_id AND itm.item_sid = itm_vat.item_sid

     WHERE /* only numerical item_1 numbers greater than 0 */ TRY_CAST(Coalesce(itm.config_item_cd,itm.src_orig_item_nr,itm.src_matnr) AS BIGINT) >= 0
     AND  (
               (
               /* filter only for SAP countries */
               is_wawi_country = 0

               /* only Verkaufs- and Beschaffungsvariante will be in the result set */
               AND itm.log_var_cd IN ('2','3')

               /* filter items considering location_1 restrictions */
               AND (itm.client_id, itm.item_sid) IN
              
                    (SELECT
                         iiplh.client_id
                         ,iiplh.item_sid
                     
                     FROM p_lew_core_ac.v_location_1 AS loc

                     INNER JOIN p_lew_core_ac.v_item_info_per_location_hist_1 AS iiplh
                     ON loc.client_id = iiplh.client_id AND loc.loc_sid = iiplh.loc_sid AND Current_Date BETWEEN iiplh.dwh_valid_from AND iiplh.dwh_valid_to
                    
                     WHERE loc.wh_store_mark = 'B' AND loc.global_loc_ctry_cd = 'ZV'
                    )
               )
          OR   (
          /* filter only for WAWI countries */
               is_wawi_country = 1

               /* entries for status_id_hq will be filtered out (reason not clear) */
               AND wawi_itm.status_id_hq NOT IN (1,2,15)

               /* restrictions regarding item_status */
               AND (itm.client_id, itm.item_sid) IN
                    (SELECT
                         sub_wawi_itm_hq_data.client_id
                         ,sub_wawi_itm_hq_data.item_sid
                     FROM
                         (SELECT
                              client_id
                              ,item_sid
                              ,wh_id
                              ,orig_item_nr
                              ,case_size
                              ,item_status
                              ,item_active_fg
                              ,item_inactive_fg
                              ,item_status_saleable
                              ,item_saleable_fg
                              ,hq_cnt_all
                              ,hq_cnt_per_case_size
                              ,sum_item_active_hq
                              ,sum_item_inactive_hq
                              ,sum_item_saleable_hq
                              ,item_active_hq_fg
                              ,item_inactive_hq_fg
                              ,item_saleable_hq_fg
                              ,sum_item_active_per_case_size
                              ,sum_item_inactive_per_case_size
                              ,sum_item_saleable_per_case_size
                              ,item_active_per_case_size_fg
                              ,item_inactive_per_case_size_fg
                              ,item_saleable_per_case_size_fg
                         FROM
                              (SELECT
                                   itm_sub.client_id                                                                                                        AS client_id
                                   ,itm_sub.item_sid                                                                                                        AS item_sid
                                   ,find_item_sid.src_orig_wh_nr                                                                                            AS wh_id
                                   ,find_item_sid.src_orig_item_nr                                                                                          AS orig_item_nr
                                   ,TRY_CAST(itm_sub.src_case_size AS INTEGER)                                                                              AS case_size
                                   ,wawi_itm_item_wh_sub.item_status                                                                                        AS item_status
                                   ,CASE WHEN wawi_itm_item_wh_sub.item_status BETWEEN 5 AND 11 THEN 1 ELSE 0 END                                           AS item_active_fg
                                   ,CASE WHEN wawi_itm_item_wh_sub.item_status NOT BETWEEN 5 AND 11 THEN 1 ELSE 0 END                                       AS item_inactive_fg
                                   ,CASE WHEN wawi_itm_item_wh_sub.item_status BETWEEN 5 AND 13 THEN wawi_itm_item_wh_sub.item_status ELSE -999 END         AS item_status_saleable
                                   ,CASE WHEN wawi_itm_item_wh_sub.item_status BETWEEN 5 AND 13 THEN 1 ELSE 0 END                                           AS item_saleable_fg
                                   ,COUNT(case_size) Over (PARTITION BY itm_sub.client_id, orig_item_nr)                                                    AS hq_cnt_all
                                   ,COUNT(case_size) Over (PARTITION BY itm_sub.client_id, orig_item_nr, case_size)                                         AS hq_cnt_per_case_size
                                   ,Sum(item_active_fg) Over (PARTITION BY itm_sub.client_id, orig_item_nr)                                                 AS sum_item_active_hq
                                   ,Sum(item_inactive_fg) Over (PARTITION BY itm_sub.client_id, orig_item_nr)                                               AS sum_item_inactive_hq
                                   ,Sum(item_saleable_fg) Over (PARTITION BY itm_sub.client_id, orig_item_nr)                                               AS sum_item_saleable_hq
                                   ,CASE WHEN sum_item_active_hq > 0 THEN 1 ELSE 0 END                                                                      AS item_active_hq_fg
                                   ,CASE WHEN sum_item_inactive_hq > 0 THEN 1 ELSE 0 END                                                                    AS item_inactive_hq_fg
                                   ,CASE WHEN sum_item_saleable_hq > 0 THEN 1 ELSE 0 END                                                                    AS item_saleable_hq_fg
                                   ,Sum(item_active_fg) Over (PARTITION BY itm_sub.client_id, orig_item_nr, case_size)                                      AS sum_item_active_per_case_size
                                   ,Sum(item_inactive_fg) Over (PARTITION BY itm_sub.client_id, orig_item_nr, case_size)                                    AS sum_item_inactive_per_case_size
                                   ,Sum(item_saleable_fg) Over (PARTITION BY itm_sub.client_id, orig_item_nr, case_size)                                    AS sum_item_saleable_per_case_size
                                   ,CASE WHEN sum_item_active_per_case_size > 0 THEN 1 ELSE 0 END                                                           AS item_active_per_case_size_fg
                                   ,CASE WHEN sum_item_inactive_per_case_size > 0 THEN 1 ELSE 0 END                                                         AS item_inactive_per_case_size_fg
                                   ,CASE WHEN sum_item_saleable_per_case_size > 0 THEN 1 ELSE 0 END                                                         AS item_saleable_per_case_size_fg
          
                              FROM p_lew_core_ac.v_item_1 AS itm_sub

                              INNER JOIN p_lew_core_ac.v_wawi_itm_item_wh_1 AS wawi_itm_item_wh_sub
                              ON itm_sub.client_id = wawi_itm_item_wh_sub.client_id
                              AND itm_sub.item_sid  = wawi_itm_item_wh_sub.item_sid
                              AND wawi_itm_item_wh_sub.item_status BETWEEN 5 AND 13 /* old interface version considered only ITEM_STATUS 5-13 */
                              AND Current_Date BETWEEN wawi_itm_item_wh_sub.dat_rec_start AND wawi_itm_item_wh_sub.dat_rec_end

                              /* Subsequent view determines one ITEM_SID per ORIG_ITEM_NR by applying the "6-Stufen-Logik" */
                              /* changed from p_lew_mart_wfm_ac.v_find_item_sid_1 in version 2.7 */
                              INNER JOIN p_lew_precore_ac.v_item_map_key_oin_wh_hist_1 AS find_item_sid
                              ON itm_sub.client_id = find_item_sid.client_id AND itm_sub.item_sid  = find_item_sid.item_sid AND wawi_itm_item_wh_sub.wh_loc_sid = find_item_sid.loc_sid_wh
                              AND CURRENT_DATE BETWEEN find_item_sid.dwh_valid_from AND find_item_sid.dwh_valid_to

                              /* only items from WAWI countries */
                              INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS client_migration
                              ON itm_sub.client_id = client_migration.client_id  AND (Current_Date < client_migration.migration_dat_valid_from OR Current_Date > client_migration.migration_dat_valid_to)

                              GROUP BY 1,2,3,4,5,6,7,8,9,10 
     
                              ) sub_wawi_itm_wh_data

                         QUALIFY Row_Number() Over 
                         (PARTITION BY sub_wawi_itm_wh_data.client_id, sub_wawi_itm_wh_data.orig_item_nr
               
                         ORDER BY  sub_wawi_itm_wh_data.item_active_per_case_size_fg DESC NULLS LAST, sub_wawi_itm_wh_data.hq_cnt_per_case_size DESC NULLS LAST
                                  ,sub_wawi_itm_wh_data.item_saleable_fg DESC NULLS LAST, sub_wawi_itm_wh_data.item_status_saleable DESC NULLS LAST
                                  ,sub_wawi_itm_wh_data.item_sid DESC NULLS LAST) = 1
                         ) AS sub_wawi_itm_hq_data
                    )
               )
          )

          QUALIFY dat_valid_from_ = Max(dat_valid_from_) Over (PARTITION BY country_lidl_cd, item_nr)

     ) AS wfm_item_data
;




