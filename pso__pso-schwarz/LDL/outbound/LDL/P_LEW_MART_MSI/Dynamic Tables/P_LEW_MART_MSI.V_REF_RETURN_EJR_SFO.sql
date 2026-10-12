CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ref_return_ejr_sfo
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
-- A blank value (for dummy lines) has to be changed to NULL. NULL values will be replaced by the frontend tool with an dummy description (e.g. "Ohne Angabe")

SELECT client_id,
 wh_id,
 return_receipttype_id,
 return_reason_cd_ejr_sfo,
 return_reason_cd_ejr_sfo_desc,
 sysind
FROM (SELECT R.client_id,
    WH.src_wh_id AS wh_id,
    1 AS return_receipttype_id,
    ROUND(CAST(R.return_reason_cd_ejr AS BIGNUMERIC), 0) AS return_reason_cd_ejr_sfo,
     CASE
     WHEN R.comment_string = ''
     THEN NULL
     ELSE R.comment_string
     END AS return_reason_cd_ejr_sfo_desc,
    1 AS sysind
   FROM ldl_p_lew_core_ac.v_wawi_ref_ejr_return_text AS R
    INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_act AS W ON TRUE
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON W.client_id = WH.client_id AND W.wh_loc_sid = WH.loc_sid_wh AND WH
      .dwh_actual_fg = 1
   WHERE R.client_id = W.client_id -- The German description has to be used

    AND R.language_id = 7
   UNION ALL
   SELECT C.client_id,
    WH.src_wh_id AS wh_id,
    2 AS return_receipttype_id,
    C.claim_reason_id AS return_reason_cd_ejr_sfo,
    C.claim_reason_descr AS return_reason_cd_ejr_sfo_desc,
    1 AS sysind
   FROM ldl_p_lew_core_ac.v_ref_claim_reason AS C
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON C.client_id = WH.client_id AND C.loc_sid_wh = WH.loc_sid_wh AND WH
      .dwh_actual_fg = 1
   UNION ALL
   SELECT RRD.client_id,
    WH.src_wh_id AS wh_id,
    2 AS return_receipttype_id,
    ROUND(CAST(RRD.return_reason_cd AS BIGNUMERIC), 0) AS return_reason_cd_ejr_sfo,
    RRD.return_reason_descr AS return_reason_cd_ejr_sfo_desc,
    2 AS sysind
   FROM ldl_p_lew_core_ac.v_ref_return_reason_descr AS RRD
    INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_act AS W ON RRD.client_id = W.client_id
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON W.client_id = WH.client_id AND W.wh_loc_sid = WH.loc_sid_wh AND WH
      .dwh_actual_fg = 1 /* Exisitiert nicht im Core, nicht mehr relevant */
   WHERE RRD.lang_cd = 'DE'
   UNION ALL
   SELECT W2.client_id,
    WH2.src_wh_id AS wh_id,
    2 AS return_receipttype_id,
    CAST(- 1 AS BIGNUMERIC) AS return_reason_cd_ejr_sfo,
    CAST(NULL AS STRING) AS return_reason_cd_ejr_sfo_desc,
    2 AS sysind
   FROM ldl_p_lew_core_ac.v_wawi_org_wh_act AS W2
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH2 ON W2.client_id = WH2.client_id AND W2.wh_loc_sid = WH2.loc_sid_wh
     AND WH2.dwh_actual_fg = 1
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per AS MI3 ON W2.client_id = MI3.client_id AND MI3.migration_dat_valid_from
       < DATE '2222-02-02') AS a
GROUP BY client_id,
 wh_id,
 return_receipttype_id,
 return_reason_cd_ejr_sfo,
 return_reason_cd_ejr_sfo_desc,
 sysind;


/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_mart_pit.t_advert_week_item_period", "p_lew_mart_pit.t_advert_week_item_medium", "p_lew_mart_pit.t_advert_week_period", "p_lew_mart_pit.v_pit_advert_medium", "p_lew_mart_pit.t_pit_action_type" ****/