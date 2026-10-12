/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_MAT_GEN_ITEM_HIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  10.12.2021    Ao, Lin                      Change flooring result for case_size calculation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_gen_item_hist_2 (client_id, item_sid, item_sid_config, orig_item_nr,
orig_item_nr_int, item_familygroup_id, subitemgroup_id, int_subitemgroup_id, item_actiongroup_id,
item_sub_actiongroup_id, case_size, src_country_lidl_cd, language_iso_cd, valid_from, valid_until, buying_employee_skey
, buying_employee_name, brand_name, itemstatus_cd, packagetype_desc, case_euro, case_plu_fg, plu_nr, buying_list_type_id
, buying_list_type_desc, unitsize, vat_id, smallest_unit, weight_fg, dangerous_goods_fg, deleted_fg, dwh_updated,
dwh_created, dwh_load_id, load_id, src_id) AS -- To identify WAWI or ELWIS client

-- Filter for items, which have a log_var_cd - if they are SAP-Items only. We can detect SAP-Only-Items by looking in table x_lew_core_ac.v_client_migration_per_2

SELECT a.client_id,
 a.item_sid,
 a.item_sid_config,
 a.orig_item_nr,
 a.orig_item_nr_int,
 a.item_familygroup_id,
 a.subitemgroup_id,
 a.int_subitemgroup_id,
 a.item_actiongroup_id,
 a.item_sub_actiongroup_id,
 a.case_size,
 T.src_country_lidl_cd,
 LANG.language_iso_cd,
 a.valid_from,
 a.valid_until,
 a.buying_employee_skey,
 a.buying_employee_name,
 a.brand_name,
 a.itemstatus_cd,
 a.packagetype_desc,
 a.case_euro,
 a.case_plu_fg,
 a.plu_nr,
 a.buying_list_type_id,
 a.buying_list_type_desc,
 a.unitsize,
 a.vat_id,
 a.smallest_unit,
 a.weight_fg,
 a.dangerous_goods_fg,
 a.deleted_fg,
 a.dwh_updated,
 a.dwh_created,
 a.dwh_load_id,
 a.load_id,
 a.src_id
FROM (SELECT A.client_id,
   A.item_sid,
   A.item_sid_config,
   ROUND(SAFE_CAST(COALESCE(A.src_orig_item_nr, A.config_item_cd, A.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.orig_item_nr_int
    ELSE COALESCE(ROUND(SAFE_CAST(A.item_eks_cd AS BIGNUMERIC), 0), - 1)
    END AS orig_item_nr_int,
   COALESCE(K.src_familygrp_id, K.item_fam_grp_sid) AS item_familygroup_id,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.subitemgroup_id
    ELSE ROUND(CAST(E.src_matkl AS BIGNUMERIC), 0)
    END AS subitemgroup_id,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.int_subitemgroup_id
    ELSE COALESCE(ROUND(SAFE_CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0), - 2000)
    END AS int_subitemgroup_id,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.item_actiongroup_id
    ELSE CAST(- 1 AS BIGNUMERIC)
    END AS item_actiongroup_id,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.item_sub_actiongroup_id
    ELSE CAST(- 1 AS BIGNUMERIC)
    END AS item_sub_actiongroup_id,
   CAST(COALESCE(WAWI.case_size_dec, CAST(FLOOR(umg.conv_to_base_numerator / CASE
         WHEN umg.conv_to_base_denominator = 0
         THEN NULL
         ELSE umg.conv_to_base_denominator
         END) AS INTEGER), umg2.conv_to_base_numerator, WAWI.case_size) AS BIGNUMERIC) AS case_size,
   ih.dwh_valid_from AS valid_from,
   ih.dwh_valid_to AS valid_until,
   COALESCE(pg.pur_grp_nat_sid, CASE
     WHEN CMP.active_fg = 0
     THEN COALESCE(WAWI.buyer_id, 9999)
     ELSE 1
     END) AS buying_employee_skey,
   COALESCE(pg.pur_grp_nat_name, CASE
     WHEN CMP.active_fg = 0
     THEN COALESCE(WAWI.buyer_name, '--')
     ELSE '#' || 'NA' || '#'
     END) AS buying_employee_name,
   NULLIF(NULLIF(COALESCE(IBR.brand_descr, WAWI.brand_2, '--'), '-'), '--') AS brand_name,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.status_id_hq
    ELSE 4
    END AS itemstatus_cd,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.packagetype_desc
    ELSE '#' || 'NA' || '#'
    END AS packagetype_desc,
   COALESCE(pf.pallet_factor, WAWI.case_euro, - 1) AS case_euro,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.case_plu_fg
    ELSE CAST(- 1 AS BIGNUMERIC)
    END AS case_plu_fg,
    CASE
    WHEN CMP.active_fg = 0
    THEN CASE
     WHEN WAWI.item_plu_nr IS NOT NULL
     THEN WAWI.item_plu_nr
     ELSE '0'
     END
    ELSE CASE
     WHEN igh.gtin IS NOT NULL
     THEN igh.gtin
     ELSE '-1'
     END
    END AS plu_nr,
    CASE
    WHEN CMP.active_fg = 0
    THEN CAST(WAWI.buying_list_type_id AS BIGNUMERIC)
    ELSE CAST(CASE
      WHEN IBR.brand_type_mark = 'EM' AND ilt.list_type = 'A'
      THEN 8 -- Aktionsartikel EM

      WHEN IBR.brand_type_mark = 'M' AND ilt.list_type = 'A'
      THEN 7 -- Aktionsartikel M

      WHEN IBR.brand_type_mark = 'EM' AND ilt.list_type = 'S'
      THEN 2 -- Normalsortiment EM

      WHEN IBR.brand_type_mark = 'M' AND ilt.list_type = 'S'
      THEN 1 -- Normalsortiment M

      WHEN IBR.brand_type_mark = 'EM' AND ilt.list_type = '-'
      THEN - 2 -- EM ohne Listungsart

      WHEN IBR.brand_type_mark = 'M' AND ilt.list_type = '-'
      THEN - 3 -- M ohne Listungsart

      WHEN IBR.brand_type_mark IS NULL AND ilt.list_type = 'A'
      THEN - 4 -- Aktionsartikel ohne Markenart

      WHEN IBR.brand_type_mark IS NULL AND ilt.list_type = 'S'
      THEN - 5 -- Normalsortiment ohne Markenart

      ELSE - 1 -- Dummy_2-Artikelart

      END AS BIGNUMERIC)
    END AS buying_list_type_id,
    CASE
    WHEN CMP.active_fg = 0 AND WAWI.client_id IS NOT NULL
    THEN WAWI.buying_list_type_desc
    ELSE CASE
     WHEN IBR.brand_type_mark = 'EM' AND ilt.list_type = 'A'
     THEN 'Aktionsartikel EM'
     WHEN IBR.brand_type_mark = 'M' AND ilt.list_type = 'A'
     THEN 'Aktionsartikel M'
     WHEN IBR.brand_type_mark = 'EM' AND ilt.list_type = 'S'
     THEN 'Normalsortiment EM'
     WHEN IBR.brand_type_mark = 'M' AND ilt.list_type = 'S'
     THEN 'Normalsortiment M'
     WHEN IBR.brand_type_mark = 'EM' AND ilt.list_type = '-'
     THEN 'EM ohne Listungsart'
     WHEN IBR.brand_type_mark = 'M' AND ilt.list_type = '-'
     THEN 'M ohne Listungsart'
     WHEN IBR.brand_type_mark IS NULL AND ilt.list_type = 'A'
     THEN 'Aktionsartikel ohne Markenart'
     WHEN IBR.brand_type_mark IS NULL AND ilt.list_type = 'S'
     THEN 'Normalsortiment ohne Markenart'
     ELSE 'Dummy_2-Artikelart'
     END
    END AS buying_list_type_desc,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.unitsize
    ELSE uom.unitsize
    END AS unitsize,
   WAWI.vat_id,
    CASE
    WHEN CMP.active_fg = 0
    THEN CASE
     WHEN WAWI.smallest_unit IS NULL
     THEN '#' || 'NA' || '#'
     ELSE WAWI.smallest_unit
     END
    ELSE '#' || 'NA' || '#'
    END AS smallest_unit,
    CASE
    WHEN CMP.active_fg = 0
    THEN CASE
     WHEN WAWI.weight_fg IS NULL
     THEN 0
     ELSE WAWI.weight_fg
     END
    ELSE CAST(CASE
      WHEN UPPER(TRIM(I.src_msehi)) = 'KG'
      THEN 1
      ELSE 0
      END AS BIGNUMERIC)
    END AS weight_fg,
    CASE
    WHEN CMP.active_fg = 0
    THEN WAWI.dangerous_goods_fg
    ELSE CAST(- 1 AS BIGNUMERIC)
    END AS dangerous_goods_fg,
   ih.deleted_fg,
   A.dwh_updated,
   A.dwh_created,
   A.dwh_load_id,
   CAST(- 1 AS BIGNUMERIC) AS load_id,
   2 AS src_id
  FROM ldl_p_lew_core_ac.v_item_2 AS A
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS CMP ON A.client_id = CMP.client_id
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS WAWI ON A.client_id = WAWI.client_id AND A.item_sid = WAWI.item_sid
     
   INNER JOIN (SELECT client_id,
     item_sid,
     dwh_valid_from,
     dwh_valid_to,
     pur_grp_nat_sid,
     item_grp_sid,
     item_fam_grp_sid,
     deleted_fg
    FROM ldl_p_lew_core_ac.v_item_hist_2 AS IH2) AS ih ON A.client_id = ih.client_id AND A.item_sid = ih.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_item_group_2 AS E ON A.client_id = E.client_id AND ih.item_grp_sid = E.item_grp_sid
   LEFT JOIN (SELECT UM.client_id,
     UM.item_sid,
     UM.log_var_cd,
     UMH.conv_to_base_numerator,
     UMH.conv_to_base_denominator
    FROM ldl_p_lew_core_ac.v_item_unit_of_measurement_2 AS UM
     INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist_2 AS UMH ON UM.client_id = UMH.client_id AND UM.item_sid
           = UMH.item_sid AND UM.uom_sid = UMH.uom_sid AND CURRENT_DATE BETWEEN UMH.dwh_valid_from AND UMH.dwh_valid_to
      AND UMH.deleted_fg = 0
    WHERE UM.log_var_cd IS NOT NULL
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(UM.client_id AS STRING), CAST(UM.item_sid AS STRING), UM.log_var_cd
        ORDER BY UMH.conv_to_base_numerator IS NULL, UMH.conv_to_base_numerator, UMH.conv_to_base_denominator IS NULL,
          UMH.conv_to_base_denominator)) = 1) AS umg ON A.client_id = umg.client_id AND A.item_sid = umg.item_sid AND A
      .log_var_cd = umg.log_var_cd AND (A.log_var_cd <> '1' OR A.config_item_cd IS NOT NULL)
   LEFT JOIN (SELECT UM0.client_id,
     UM0.item_sid,
     0 AS conv_to_base_numerator
    FROM ldl_p_lew_core_ac.v_item_unit_of_measurement_2 AS UM0
     INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist_2 AS UMH0 ON UM0.client_id = UMH0.client_id AND UM0.item_sid
           = UMH0.item_sid AND UM0.uom_sid = UMH0.uom_sid AND CURRENT_DATE BETWEEN UMH0.dwh_valid_from AND UMH0.dwh_valid_to
         AND UMH0.deleted_fg = 0
    WHERE UM0.log_var_cd IS NOT NULL
    GROUP BY UM0.client_id,
     UM0.item_sid) AS umg2 ON A.client_id = umg2.client_id AND A.item_sid = umg2.item_sid
   LEFT JOIN (SELECT IH.client_id,
     IH.item_sid,
     IH.pur_grp_nat_sid,
     PG.pur_grp_nat_name
    FROM ldl_p_lew_core_ac.v_item_hist_2 AS IH
     LEFT JOIN ldl_p_lew_core_ac.v_purchase_group_nat_2 AS PG ON IH.client_id = PG.client_id AND IH.pur_grp_nat_sid = PG.pur_grp_nat_sid
       
    WHERE PG.pur_grp_nat_sid IS NOT NULL
    GROUP BY IH.client_id,
     IH.item_sid,
     IH.pur_grp_nat_sid,
     PG.pur_grp_nat_name) AS pg ON A.client_id = pg.client_id AND A.item_sid = pg.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_item_hist_2 AS BB ON A.client_id = BB.client_id AND BB.item_sid = COALESCE(A.item_sid_config
       , A.item_sid) AND CURRENT_DATE BETWEEN BB.dwh_valid_from AND BB.dwh_valid_to -- AND bb.deleted_fg = 0

   LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_2 AS K ON BB.client_id = K.client_id AND BB.item_fam_grp_sid = K.item_fam_grp_sid
     
   LEFT JOIN ldl_p_lew_core_ac.v_item_familygroup_hist_2 AS KH ON BB.client_id = KH.client_id AND BB.item_fam_grp_sid = KH
      .item_fam_grp_sid AND CURRENT_DATE BETWEEN KH.dwh_valid_from AND KH.dwh_valid_to -- AND kh.deleted_fg=0

   LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_2 AS SIG ON KH.client_id = SIG.client_id AND KH.sub_item_grp_sid = SIG.sub_item_grp_sid
     
   LEFT JOIN ldl_p_lew_core_ac.v_unit_of_measurement_2 AS I ON BB.client_id = I.client_id AND BB.uom_sid_base = I.uom_sid
   LEFT JOIN ldl_p_lew_bil_ac.v_item_brand_asis_2 AS IBR ON A.client_id = IBR.client_id AND A.item_sid = IBR.item_sid
   LEFT JOIN (SELECT client_id,
     item_sid,
     list_type
    FROM (SELECT *
      FROM (SELECT A0.client_id,
         A0.item_sid,
         COALESCE(A0.list_type_mark, '-') AS list_type,
         COUNT(*) AS counti
        FROM ldl_p_lew_core_ac.v_item_listing_type_hist_2 AS A0
         INNER JOIN ldl_p_lew_core_ac.v_location_2 AS B ON A0.loc_sid = B.loc_sid AND B.wh_store_mark = 'A' AND B.global_loc_type_cd
            = '0'
         INNER JOIN ldl_p_lew_core_ac.v_location_hist_2 AS C ON B.loc_sid = C.loc_sid AND C.demand_plan_active_fg = 1 AND
            CURRENT_DATE BETWEEN C.dwh_valid_from AND C.dwh_valid_to AND C.deleted_fg = 0
        WHERE CURRENT_DATE BETWEEN A0.dwh_valid_from AND A0.dwh_valid_to
         AND A0.deleted_fg = 0
        GROUP BY A0.client_id,
         A0.item_sid,
         list_type) AS x
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING) ORDER BY counti
            IS NULL, counti)) = 1) AS t13) AS ilt ON A.client_id = ilt.client_id AND A.item_sid = ilt.item_sid
     -- added to get better plu_nr for SAP clients

   LEFT JOIN (SELECT IH0.client_id,
     IH0.item_sid,
     TRIM(CAST(IGH.gtin AS STRING)) AS gtin
    FROM ldl_p_lew_core_ac.v_item_hist_2 AS IH0
     INNER JOIN ldl_p_lew_core_ac.v_item_gtin_hist_2 AS IGH ON IH0.client_id = IGH.client_id AND IH0.item_sid = IGH.item_sid
            AND IH0.uom_sid_base = IGH.uom_sid AND CURRENT_DATE BETWEEN IH0.dwh_valid_from AND IH0.dwh_valid_to AND
        CURRENT_DATE BETWEEN IGH.dwh_valid_from AND IGH.dwh_valid_to AND IGH.gtin_type_mark IN ('ZP')
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(IH0.client_id AS STRING), CAST(IH0.item_sid AS STRING) ORDER BY IGH.seq_nr
          IS NULL, IGH.seq_nr)) = 1) AS igh ON A.client_id = igh.client_id AND A.item_sid = igh.item_sid
   LEFT JOIN (SELECT A1.client_id,
     A1.item_sid,
      CASE
      WHEN D.gross_content_val <> 1
      THEN TRIM(SUBSTR(CAST(D.gross_content_val /* MSC-WARNING - MSCEWI1033 - FORMAT 'FN9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ** */ AS STRING)
           , 1, 19)) || 'x' || TRIM(SUBSTR(CAST(D.pack_cont_qty /* MSC-WARNING - MSCEWI1033 - FORMAT 'FN9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ** */ AS STRING)
          , 1, 19)) || CAST(U.src_msehi AS STRING)
      ELSE TRIM(SUBSTR(CAST(D.pack_cont_qty /* MSC-WARNING - MSCEWI1033 - FORMAT 'FN9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ** */ AS STRING)
         , 1, 19)) || CAST(U.src_msehi AS STRING)
      END AS unitsize
    FROM ldl_p_lew_core_ac.v_item_sort_box_hist_2 AS A1
     INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS D ON A1.client_id = D.client_id AND A1.item_sid = D.item_sid AND
       CURRENT_DATE BETWEEN D.dwh_valid_from AND D.dwh_valid_to
     LEFT JOIN ldl_p_lew_core_ac.v_unit_of_measurement_2 AS U ON D.client_id = U.client_id AND D.uom_sid_packaging = U.uom_sid
       
    WHERE CURRENT_DATE BETWEEN A1.dwh_valid_from AND A1.dwh_valid_to
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(A1.client_id AS STRING), CAST(A1.item_sid AS STRING) ORDER BY unitsize
          IS NULL, unitsize)) = 1) AS uom ON A.client_id = uom.client_id AND A.item_sid -- palletfactor for SAP clients

     = uom.item_sid
   LEFT JOIN (SELECT A2.client_id,
     A2.item_sid,
     MAX(A2.pallet_factor) AS pallet_factor,
     MAX(A2.case_factor) AS case_factor
    FROM ldl_p_lew_core_ac.v_item_info_per_location_hist_2 AS A2
     INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS M2 ON A2.client_id = M2.client_id AND A2.dwh_valid_from
       BETWEEN M2.migration_dat_valid_from AND M2.migration_dat_valid_to
    WHERE (A2.pallet_factor IS NOT NULL OR A2.case_factor IS NOT NULL)
     AND CURRENT_DATE BETWEEN A2.dwh_valid_from AND A2.dwh_valid_to
     AND A2.deleted_fg = 0
    GROUP BY A2.client_id,
     A2.item_sid) AS pf ON A.client_id = pf.client_id AND A.item_sid = pf.item_sid
  WHERE COALESCE(CAST(A.src_case_size AS BIGNUMERIC), 0) <> - 1
   AND CASE
    WHEN CMP.active_fg = 1
    THEN A.log_var_cd
    ELSE '1'
    END IS NOT NULL) AS a
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS C0 ON a.client_id = C0.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS T ON C0.country_sid = T.country_sid -- Ermittlung Sprachcode

 INNER JOIN ldl_p_lew_core_ac.v_report_language_2 AS RLANG ON T.lang_sid = RLANG.lang_sid -- Ermittlung WAWI Language ID

 INNER JOIN ldl_p_lew_core_ac.v_map_lang_spras_2 AS LANG ON TRIM(LANG.sap_lang_cd) = TRIM(RLANG.iso_cd) AND TRIM(T.src_country_lidl_cd
    ) = TRIM(LANG.language_iso_cd);