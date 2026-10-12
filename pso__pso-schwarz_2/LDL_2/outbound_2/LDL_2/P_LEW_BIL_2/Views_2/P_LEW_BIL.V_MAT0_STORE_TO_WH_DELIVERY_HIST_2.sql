CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat0_store_to_wh_delivery_hist_2 AS
WITH intervals AS (
  SELECT 
    client_id,
    loc_sid_store,
    dwh_valid_from,
    COALESCE(
      DATE_SUB(
        MIN(dwh_valid_from) OVER (
          PARTITION BY CAST(client_id AS STRING), CAST(loc_sid_store AS STRING)
          ORDER BY dwh_valid_from IS NULL, dwh_valid_from 
          ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING
        ), 
        INTERVAL 1 DAY
      ),
      PARSE_DATE('%Y%m%d', '99991231')
    ) AS dwh_valid_to
  FROM (
    SELECT DISTINCT 
      client_id,
      loc_sid_store,
      dwh_valid_from
    FROM ldl_p_lew_core_ac.v_store_to_wh_delivery_hist_2
    UNION DISTINCT
    SELECT DISTINCT 
      client_id,
      loc_sid_store,
      DATE_ADD(dwh_valid_to, INTERVAL 1 DAY)
    FROM ldl_p_lew_core_ac.v_store_to_wh_delivery_hist_2
  ) AS a
  WHERE dwh_valid_from <> PARSE_DATE('%Y%m%d', '99991231')
),
joined_data AS (
  SELECT 
    MAINTAB.client_id,
    MAINTAB.loc_sid_store,
    MAINTAB.deleted_fg,
    MAINTAB.loc_sid_wh,
    MAINTAB.priority,
    MAINTAB.item_grp_cd,
    intvls.dwh_valid_from,
    intvls.dwh_valid_to,
    
    MAX(MAINTAB.loc_sid_wh) OVER (
      PARTITION BY 
        CAST(MAINTAB.client_id AS STRING), 
        CAST(MAINTAB.loc_sid_store AS STRING), 
        CAST(MAINTAB.priority AS STRING), 
        CAST(MAINTAB.deleted_fg AS STRING), 
        intvls.dwh_valid_from 
      ORDER BY 
        MAINTAB.dwh_valid_from IS NULL DESC, 
        MAINTAB.dwh_valid_from DESC, 
        MAINTAB.dwh_valid_to IS NULL DESC, 
        MAINTAB.dwh_valid_to DESC 
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS max_loc_sid_wh_val,
    CAST(999 - MAINTAB.priority AS STRING) || 
      CAST(FORMAT_DATE('%Y%m%d', DATE(MAINTAB.active_from_dt)) AS STRING) || 
      CAST(FORMAT_DATE('%Y%m%d', DATE(MAINTAB.active_to_dt)) AS STRING) AS sort_key
  FROM ldl_p_lew_core_ac.v_store_to_wh_delivery_hist_2 AS MAINTAB
  INNER JOIN intervals AS intvls 
    ON MAINTAB.client_id = intvls.client_id 
    AND MAINTAB.loc_sid_store = intvls.loc_sid_store 
    AND MAINTAB.dwh_valid_from <= intvls.dwh_valid_to 
    AND MAINTAB.dwh_valid_to >= intvls.dwh_valid_from
)
SELECT 
  client_id,
  loc_sid_store,
  
  COUNT(DISTINCT NULLIF(CASE
    WHEN deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
    ELSE 'P' || TRIM(CAST(priority AS STRING)) || '-WH_SID:' || TRIM(CAST(loc_sid_wh AS STRING))
  END, '')) AS cnt_wh_same_prio,
  
  COUNT(DISTINCT NULLIF(NULLIF(CASE
    WHEN deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
    ELSE CASE
      WHEN item_grp_cd = '@ALL' THEN '(NO_IGRP)'
      ELSE TRIM('(IGRP:' || TRIM(item_grp_cd)) || ')'
    END
  END, '(NO_IGRP)'), '')) AS cnt_igrp,
  
  MAX(NULLIF(NULLIF(CASE
    WHEN deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
    ELSE CASE
      WHEN item_grp_cd = '@ALL' THEN '(NO_IGRP)'
      ELSE TRIM('(IGRP:' || TRIM(item_grp_cd)) || ')'
    END
  END, '(NO_IGRP)'), '')) AS max_item_grp_cd,
  
  LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(
    STRING_AGG(
      TRIM(
        CASE WHEN deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
             ELSE 'P' || TRIM(CAST(priority AS STRING)) || '-WH_SID:' || TRIM(CAST(loc_sid_wh AS STRING))
        END || 
        CASE WHEN deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
             ELSE CASE WHEN item_grp_cd = '@ALL' THEN '(NO_IGRP)'
                       ELSE TRIM('(IGRP:' || TRIM(item_grp_cd)) || ')'
                  END
        END
      ) || ',' 
      ORDER BY sort_key IS NULL, sort_key
    ), 
  ' ', ''), ',,', ','), ',,', ','), ','), ',') AS loc_sid_wh_rawinfo_list,
  
  LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(
    STRING_AGG(
      TRIM(
        CASE WHEN loc_sid_wh <> max_loc_sid_wh_val OR deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
             ELSE TRIM(CAST(max_loc_sid_wh_val AS STRING))
        END
      ) || ',' 
      ORDER BY sort_key IS NULL, sort_key
    ), 
  ' ', ''), ',,', ','), ',,', ','), ','), ',') AS loc_sid_wh_list,
  
  LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(
    STRING_AGG(
      TRIM(
        CASE WHEN loc_sid_wh <> max_loc_sid_wh_val OR deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
             ELSE TRIM(CAST(priority AS STRING))
        END
      ) || ',' 
      ORDER BY sort_key IS NULL, sort_key
    ), 
  ' ', ''), ',,', ','), ',,', ','), ','), ',') AS priority_list,
  
  CASE WHEN NULLIF(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(
    STRING_AGG(
      TRIM(
        CASE WHEN deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
             ELSE 'P' || TRIM(CAST(priority AS STRING)) || '-WH_SID:' || TRIM(CAST(loc_sid_wh AS STRING))
        END || 
        CASE WHEN deleted_fg = 1 OR loc_sid_wh = 0 THEN ''
             ELSE CASE WHEN item_grp_cd = '@ALL' THEN '(NO_IGRP)'
                       ELSE TRIM('(IGRP:' || TRIM(item_grp_cd)) || ')'
                  END
        END
      ) || ',' 
      ORDER BY sort_key IS NULL, sort_key
    ), 
  ' ', ''), ',,', ','), ',,', ','), ','), ','), '') IS NULL 
  THEN 1
  ELSE MIN(deleted_fg)
  END AS deleted_fg,
  
  dwh_valid_from,
  dwh_valid_to
  
FROM joined_data
GROUP BY 
  client_id,
  loc_sid_store,
  dwh_valid_from,
  dwh_valid_to;