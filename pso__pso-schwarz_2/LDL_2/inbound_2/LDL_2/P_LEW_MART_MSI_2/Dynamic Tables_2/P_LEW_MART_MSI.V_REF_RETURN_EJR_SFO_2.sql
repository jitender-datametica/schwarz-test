CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_RETURN_EJR_SFO_2 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
2022-01-12 Martin Murtenthaler    AP0103419_INT-B-172  New column sysind (necessary for a lookup), 
                                  as return_reason_cd_ejr can have a different description
                                  coming either from ELWIS or from WAWI 
*/
SELECT
   client_id
  ,wh_id
  ,return_receipttype_id
  ,return_reason_cd_ejr_sfo
  ,return_reason_cd_ejr_sfo_desc
  ,sysind
FROM
(
  SELECT
     r.client_id
    ,wh.src_wh_id                               AS wh_id
    ,CAST(1 AS NUMBER(38))                      AS return_receipttype_id
    ,CAST(r.return_reason_cd_ejr AS NUMBER(38)) AS return_reason_cd_ejr_sfo
     -- A blank value (for dummy_2 lines) has to be changed to NULL. NULL values will be replaced by the frontend tool with an dummy_2 description (e.g. "Ohne Angabe")
    ,CASE WHEN r.comment_string = '' THEN NULL ELSE r.comment_string END AS return_reason_cd_ejr_sfo_desc
    ,1                                          AS sysind
  FROM p_lew_core_ac.v_wawi_ref_ejr_return_text_2  r

  CROSS JOIN  p_lew_core_ac.v_wawi_org_wh_act_2 w

  INNER JOIN p_lew_bil_ac.v_warehouse_2 wh
  ON w.client_id = wh.client_id  
    AND w.wh_loc_sid = wh.loc_sid_wh
    AND wh.dwh_actual_fg = 1 

  WHERE r.client_id = w.client_id
    -- The German description has to be used
    AND r.language_id = 7

  UNION ALL

  SELECT
     c.client_id
    ,wh.src_wh_id          AS wh_id
    ,CAST(2 AS NUMBER(38)) AS return_receipttype_id
    ,c.claim_reason_id     AS return_reason_cd_ejr_sfo
    ,c.claim_reason_descr  AS return_reason_cd_ejr_sfo_desc
    ,1                     AS sysind
  FROM p_lew_core_ac.v_ref_claim_reason_2 c

  INNER JOIN p_lew_bil_ac.v_warehouse_2 wh
   ON c.client_id = wh.client_id  
     AND c.loc_sid_wh = wh.loc_sid_wh
     AND wh.dwh_actual_fg = 1

  UNION ALL

  SELECT
     rrd.client_id
    ,wh.src_wh_id                    AS wh_id
    ,CAST(2 AS NUMBER(38))           AS return_receipttype_id
    ,TO_NUMBER(rrd.return_reason_cd) AS return_reason_cd_ejr_sfo
    ,rrd.return_reason_descr         AS return_reason_cd_ejr_sfo_desc
    ,2                               AS sysind
  FROM p_lew_core_ac.v_ref_return_reason_descr_2 AS rrd

  INNER JOIN p_lew_core_ac.v_wawi_org_wh_act_2 w
  ON rrd.client_id = w.client_id

  INNER JOIN p_lew_bil_ac.v_warehouse_2 wh
  ON w.client_id = wh.client_id  
    AND w.wh_loc_sid = wh.loc_sid_wh
    AND wh.dwh_actual_fg = 1

/* Exisitiert nicht im Core, nicht mehr relevant */
  WHERE  rrd.lang_cd = 'DE'

  UNION ALL

  SELECT
     w2.client_id
    ,wh2.src_wh_id                AS wh_id
    ,CAST(2 AS NUMBER(38))        AS return_receipttype_id
    ,CAST(-1 AS NUMBER(38))       AS return_reason_cd_ejr_sfo
    ,CAST(NULL AS VARCHAR(1))     AS return_reason_cd_ejr_sfo_desc
    ,2                            AS sysind
  FROM p_lew_core_ac.v_wawi_org_wh_act_2 w2

  INNER JOIN p_lew_bil_ac.v_warehouse_2 wh2
  ON w2.client_id = wh2.client_id
    AND w2.wh_loc_sid = wh2.loc_sid_wh
    AND wh2.dwh_actual_fg = 1

  INNER JOIN p_lew_core_ac.v_client_migration_per_2 mi3
  ON w2.client_id = mi3.client_id
    AND mi3.migration_dat_valid_from < DATE'2222-02-02'
) a
GROUP BY
   client_id 
  ,wh_id 
  ,return_receipttype_id
  ,return_reason_cd_ejr_sfo
  ,return_reason_cd_ejr_sfo_desc
  ,sysind;

/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_mart_pit.t_advert_week_item_period_2", "p_lew_mart_pit.t_advert_week_item_medium_2", "p_lew_mart_pit.t_advert_week_period_2", "p_lew_mart_pit.v_pit_advert_medium_2", "p_lew_mart_pit.t_pit_action_type_2" ****/

