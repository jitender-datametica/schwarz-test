CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_buyprice_sap_1 AS /* Base data is purchase info header */
/* CROSS JOIN for getting loc_sid, pur_org_sid and pinfo_type_cd */
/* only exchange rates having set a special rate flag */
/* UNION part includes same currency pairs vice versa, because the definition of exchange rates
   is only defined in one direction and the underlying table contains not(!) a full definition.
   That means you will not find for every currency pair a vice versa definition with a reciprocal
   value for the exchange rate:
      - therefore curr_sid_from and curr_sid_to are switched as well as curr_cd_from and curr_cd_to
      - reciprocal (Kehrwert) of exchange_rate because from-currency and to-currency are switched */
/* only exchange rates having set a special rate flag */
/* CROSS JOIN for selecting WH_ID, filter for wh_store_mark 'B': only warehouse data */ /* Land_1 */ /* WHID */
/* ORIG_ITEM_NR */ /* Supplier_nr */ /* valid_from of condition */ SELECT CLNT.src_country_lidl_cd AS land_1,
 COALESCE(LOC.src_wh_id, - 1) AS whid,
 ROUND(CAST(COALESCE(ITM.config_item_cd, ITM.src_orig_item_nr, ITM.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
  CASE
  WHEN SUPL.src_orig_supplier_nr IS NULL OR CAST(SUPL.src_orig_supplier_nr AS FLOAT64) = - 999
  THEN ROUND(CAST(SUPL.src_lifnr AS BIGNUMERIC), 0)
  ELSE ROUND(CAST(SUPL.src_orig_supplier_nr AS BIGNUMERIC), 0)
  END AS supplier_nr,
 purch_info_hist_mod.dwh_valid_from AS valid_from,
 purch_info_hist_mod.dwh_valid_to AS valid_until,
  PURCH_COND_HIST.condition_val / COALESCE(x_rate.corrected_x_rate, 1) AS buyprice,
 PURCH_COND_HIST.condition_val AS buyprice_orig,
  CASE
  WHEN LENGTH(PURCH_COND_HIST.curr_cd) = 4
  THEN SUBSTR(PURCH_COND_HIST.curr_cd, 1, 3)
  ELSE PURCH_COND_HIST.curr_cd
  END AS currency_iso
FROM ldl_p_lew_core_ac.v_pinfo_header_1 AS HEAD
 INNER JOIN ldl_p_lew_core_ac.v_pinfo_detail_hist_1 AS DTL ON HEAD.client_id = DTL.client_id AND HEAD.pinfo_sid = DTL.pinfo_sid
     AND CURRENT_DATE BETWEEN DTL.dwh_valid_from AND DTL.dwh_valid_to
   /* CROSS JOIN for getting all warehouses of a country_1 if loc_sid in pinfo_detail_hist is negative (dummy_1) */
 LEFT JOIN (SELECT client_id,
   loc_sid_wh,
   src_werks,
   src_wh_id
  FROM ldl_p_lew_bil_ac.v_warehouse_1
  WHERE deleted_fg = 0
   AND bges_active_fg = 1
   AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to) AS wh ON DTL.client_id = wh.client_id AND DTL.loc_sid < 0
   /* CROSS JOIN for selecting pur_cond_sid and validity_1 period of condition; LEFT OUTER CROSS JOIN with v_warehouse_1 to resolve negative loc_sids */
   
 INNER JOIN (SELECT PURCH_INFO_HIST.client_id,
   PURCH_INFO_HIST.sup_sid,
   PURCH_INFO_HIST.item_sid,
   PURCH_INFO_HIST.pur_org_sid,
   PURCH_INFO_HIST.loc_sid,
   PURCH_INFO_HIST.pur_cond_sid,
   PURCH_INFO_HIST.cond_type_cd,
   PURCH_INFO_HIST.einfo_type_cd,
   PURCH_INFO_HIST.application_cd,
   PURCH_INFO_HIST.general_purchase_info_fg,
   PURCH_INFO_HIST.active_from_dt,
   PURCH_INFO_HIST.active_to_dt,
   PURCH_INFO_HIST.deleted_fg,
   PURCH_INFO_HIST.dwh_valid_from,
   PURCH_INFO_HIST.dwh_valid_to,
   PURCH_INFO_HIST.dwh_load_id,
   PURCH_INFO_HIST.dwh_created,
   PURCH_INFO_HIST.dwh_updated,
   COALESCE(wh_2.loc_sid_wh, PURCH_INFO_HIST.loc_sid) AS loc_sid_mod
  FROM ldl_p_lew_core_ac.v_purchase_info_hist_1 AS PURCH_INFO_HIST
   LEFT JOIN (SELECT client_id,
     loc_sid_wh,
     src_werks,
     src_wh_id
    FROM ldl_p_lew_bil_ac.v_warehouse_1
    WHERE deleted_fg = 0
     AND bges_active_fg = 1
     AND CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to) AS wh_2 ON PURCH_INFO_HIST.client_id = wh_2.client_id AND
     PURCH_INFO_HIST.loc_sid < 0) AS purch_info_hist_mod ON HEAD.client_id = purch_info_hist_mod.client_id AND HEAD.item_sid
         = purch_info_hist_mod.item_sid AND HEAD.sup_sid = purch_info_hist_mod.sup_sid AND DTL.pur_org_sid =
      purch_info_hist_mod.pur_org_sid AND DTL.pinfo_type_cd = purch_info_hist_mod.einfo_type_cd AND COALESCE(wh.loc_sid_wh
     , DTL.loc_sid) = purch_info_hist_mod.loc_sid_mod AND CURRENT_DATE BETWEEN purch_info_hist_mod.dwh_valid_from AND
   purch_info_hist_mod.dwh_valid_to /* CROSS JOIN for selecting purchase price (condition_val) */
 INNER JOIN ldl_p_lew_core_ac.v_purchase_condition_hist_1 AS PURCH_COND_HIST ON purch_info_hist_mod.client_id =
     PURCH_COND_HIST.client_id AND purch_info_hist_mod.pur_cond_sid = PURCH_COND_HIST.pur_cond_sid AND CURRENT_DATE
    BETWEEN PURCH_COND_HIST.dwh_valid_from AND PURCH_COND_HIST.dwh_valid_to /* CROSS JOIN for selecting country_1 code */
  AND PURCH_COND_HIST.condition_val IS NOT NULL
 INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLNT ON HEAD.client_id = CLNT.client_id
  /* CROSS JOIN for determination of the exchange rate from currency of condition
   to currency of Lidl country_1 currency, i.e. currency from client record.
   Only those exchange rates are to be selected with a special rate flag
   in the corresponding exchange_rate_type - record.
   Without already deleted records only originally negative exchange rates
   are resulting.
   To get realistic exchange rates there is a select condition on
   technical and functional validity_1 period.
   Condidering this, normally not more than one actual valid result should
   exist per combination of client, source and target currency. Preventively
   a MAX() function is used to get only one result in this case. */
  
 LEFT JOIN (SELECT X_RATE_HIST.client_id,
    X_RATE_HIST.curr_sid_from AS orig_curr_sid,
    X_RATE_HIST.curr_cd_from AS orig_curr_cd,
    X_RATE_HIST.curr_sid_to AS target_curr_sid,
    X_RATE_HIST.curr_cd_to AS target_curr_cd,
    MAX(X_RATE_HIST.exchange_rate * - 1) AS corrected_x_rate
   FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS X_RATE_HIST
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS X_RATE_TYPE ON X_RATE_HIST.client_id = X_RATE_TYPE.client_id
      AND X_RATE_HIST.x_rate_type_sid = X_RATE_TYPE.x_rate_type_sid AND X_RATE_TYPE.special_rate_fg = 1
      /* only technical and functional valid exchange rates */
   WHERE CURRENT_DATE BETWEEN X_RATE_HIST.dwh_valid_from AND X_RATE_HIST.dwh_valid_to
    AND CURRENT_DATE BETWEEN X_RATE_HIST.active_from_dt AND X_RATE_HIST.active_to_dt /* only non deleted records */
    AND X_RATE_HIST.deleted_fg = 0 /* only records with exchange_rate not equal to zero */
    AND X_RATE_HIST.exchange_rate <> 0
     /* Determine the highest valid exchange rate (considering sign) respectively for the combination of client, target and source currency */
     
   GROUP BY X_RATE_HIST.client_id,
    orig_curr_sid,
    orig_curr_cd,
    target_curr_sid,
    target_curr_cd
   UNION DISTINCT
   SELECT Y_RATE_HIST.client_id,
    Y_RATE_HIST.curr_sid_to AS orig_curr_sid,
    Y_RATE_HIST.curr_cd_to AS orig_curr_cd,
    Y_RATE_HIST.curr_sid_from AS target_curr_sid,
    Y_RATE_HIST.curr_cd_from AS target_curr_cd,
    MAX(1 / Y_RATE_HIST.exchange_rate * - 1) AS corrected_y_rate
   FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS Y_RATE_HIST
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS Y_RATE_TYPE ON Y_RATE_HIST.client_id = Y_RATE_TYPE.client_id
      AND Y_RATE_HIST.x_rate_type_sid = Y_RATE_TYPE.x_rate_type_sid AND Y_RATE_TYPE.special_rate_fg = 1
      /* only technical and functional valid exchange rates */
   WHERE CURRENT_DATE BETWEEN Y_RATE_HIST.dwh_valid_from AND Y_RATE_HIST.dwh_valid_to
    AND CURRENT_DATE BETWEEN Y_RATE_HIST.active_from_dt AND Y_RATE_HIST.active_to_dt /* only non deleted records */
    AND Y_RATE_HIST.deleted_fg = 0 /* only records with exchange_rate not equal to zero */
    AND Y_RATE_HIST.exchange_rate <> 0
     /* Determine the highest valid exchange rate (considering sign) respectively for the combination of client, target and source currency */
     
   GROUP BY Y_RATE_HIST.client_id,
    orig_curr_sid,
    orig_curr_cd,
    target_curr_sid,
    target_curr_cd) AS x_rate ON PURCH_COND_HIST.client_id = x_rate.client_id AND PURCH_COND_HIST.curr_sid = x_rate.orig_curr_sid
     AND CLNT.curr_sid = x_rate.target_curr_sid
   /* CROSS JOIN for selecting item_1 information, filter for log_var_cd 3: only purchase items */
 INNER JOIN ldl_p_lew_core_ac.v_item_1 AS ITM ON HEAD.client_id = ITM.client_id AND HEAD.item_sid = ITM.item_sid AND CAST(ITM.log_var_cd AS FLOAT64)
   = 3 /* CROSS JOIN for selecting item_grp_sid (see below) as groups plants, fruit and vegetables have to be ignored */
   
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_1 AS ITM_HIST ON ITM.client_id = ITM_HIST.client_id AND ITM.item_sid = ITM_HIST
    .item_sid AND CURRENT_DATE BETWEEN ITM_HIST.dwh_valid_from AND ITM_HIST.dwh_valid_to
   /* CROSS JOIN for selecting item_1 group as groups plants, fruit and vegetables have to be ignored */
 INNER JOIN ldl_p_lew_core_ac.v_item_group_1 AS ITM_GRP ON ITM_HIST.client_id = ITM_GRP.client_id AND ITM_HIST.item_grp_sid
     = ITM_GRP.item_grp_sid /* item_1 groups plants, fruit and vegetables have to be ignored for WFM */ AND ITM_GRP.src_matkl
    NOT IN ('10', '11', '12', '13')
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON HEAD.client_id = LOC.client_id AND COALESCE(wh.loc_sid_wh, DTL.loc_sid
     ) = LOC.loc_sid AND LOC.wh_store_mark = 'B' /* CROSS JOIN for selecting supplier_nr */
 INNER JOIN ldl_p_lew_core_ac.v_supplier_1 AS SUPL ON HEAD.client_id = SUPL.client_id AND HEAD.sup_sid = SUPL.sup_sid
   /* CROSS JOIN for restriction to select data only from migrated countries (preventively) */
 INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS SAP_MIGRATION_CLIENT ON HEAD.client_id = SAP_MIGRATION_CLIENT.client_id
    AND CURRENT_DATE BETWEEN SAP_MIGRATION_CLIENT.migration_dat_valid_from AND SAP_MIGRATION_CLIENT.migration_dat_valid_to
   
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CLNT.src_country_lidl_cd, CAST(COALESCE(LOC.src_wh_id, - 1) AS STRING), CAST(ROUND(ROUND(CAST(COALESCE(ITM.config_item_cd, ITM.src_orig_item_nr, ITM.src_matnr) AS BIGNUMERIC)
         , 0), 0) AS STRING), CAST(CASE
        WHEN SUPL.src_orig_supplier_nr IS NULL OR CAST(SUPL.src_orig_supplier_nr AS FLOAT64) = - 999
        THEN ROUND(ROUND(CAST(SUPL.src_lifnr AS BIGNUMERIC), 0), 0)
        ELSE ROUND(ROUND(CAST(SUPL.src_orig_supplier_nr AS BIGNUMERIC), 0), 0)
        END AS STRING), purch_info_hist_mod.dwh_valid_from ORDER BY (PURCH_COND_HIST.condition_val / COALESCE(x_rate.corrected_x_rate
         , 1)) IS NULL, PURCH_COND_HIST.condition_val / COALESCE(x_rate.corrected_x_rate, 1), PURCH_COND_HIST.dwh_valid_from
      IS NULL, PURCH_COND_HIST.dwh_valid_from)) = 1 /* ORDER BY Buyprice and technical valid_from */
  /* ORDER BY Buyprice and technical valid_from */;