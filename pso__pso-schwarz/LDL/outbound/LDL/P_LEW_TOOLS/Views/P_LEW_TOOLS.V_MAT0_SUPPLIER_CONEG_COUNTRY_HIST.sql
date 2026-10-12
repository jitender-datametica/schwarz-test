CREATE OR REPLACE VIEW ldl_p_lew_tools.v_mat0_supplier_coneg_country_hist AS SELECT MAINTAB.client_id,
 MAINTAB.sup_sid,
 MAINTAB.country_sid_conegot,
 MAINTAB.country_cd_conegot,
 MAINTAB.deleted_fg,
  CASE
  WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
  THEN ''
  ELSE TRIM(CAST(MAINTAB.country_sid_conegot AS STRING))
  END AS country_sid_conegot_vc,
  CASE
  WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
  THEN ''
  ELSE TRIM(CAST(MAINTAB.country_cd_conegot AS STRING))
  END AS country_cd_conegot_vc,
  CASE
  WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
  THEN 0
  ELSE 1
  END AS real_country_fg,
 MAINTAB.dwh_valid_from,
 MAINTAB.dwh_valid_to,
 DATE_SUB(intvls.dwh_valid_from, INTERVAL 1 DAY) AS schnitt_peri_start,
 intvls.dwh_valid_to AS schnitt_peri_end,
   FORMAT_DATE('%F', DATE_SUB(intvls.dwh_valid_from, INTERVAL 1 DAY)) || ',' || FORMAT_DATE('%F', intvls.dwh_valid_to)
 AS peri,
  CAST(MAINTAB.dwh_valid_from AS STRING) || MAINTAB.country_cd_conegot AS order_crit,
 ROW_NUMBER() OVER (PARTITION BY CAST(MAINTAB.client_id AS STRING), CAST(MAINTAB.sup_sid AS STRING), DATE_SUB(intvls.dwh_valid_from
     ,INTERVAL 1 DAY), intvls.dwh_valid_to ORDER BY CASE
     WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
     THEN 0
     ELSE 1
     END IS NULL, CASE
     WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
     THEN 0
     ELSE 1
     END, MAINTAB.country_sid_conegot IS NULL, MAINTAB.country_sid_conegot) AS relevant_unq_row,
  CASE
  WHEN (SUM(CASE
      WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
      THEN 0
      ELSE 1
      END) OVER (PARTITION BY CAST(MAINTAB.client_id AS STRING), CAST(MAINTAB.sup_sid AS STRING), DATE_SUB(intvls.dwh_valid_from
        ,INTERVAL 1 DAY), intvls.dwh_valid_to RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1
  THEN 'MULTIPLE'
  WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(MAINTAB.client_id AS STRING), CAST(MAINTAB.sup_sid AS STRING), DATE_SUB(intvls
        .dwh_valid_from, INTERVAL 1 DAY), intvls.dwh_valid_to ORDER BY CASE
        WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
        THEN 0
        ELSE 1
        END IS NULL, CASE
        WHEN MAINTAB.deleted_fg = 1 OR MAINTAB.country_sid_conegot = 0
        THEN 0
        ELSE 1
        END, MAINTAB.country_sid_conegot IS NULL, MAINTAB.country_sid_conegot)) = 1
  THEN 'UNIQUE'
  ELSE 'NOT RELEVANT'
  END AS map_type
FROM ldl_p_lew_core_ac.v_supplier_coneg_country_hist AS MAINTAB
 INNER JOIN (SELECT client_id,
   sup_sid,
   dwh_valid_from,
   COALESCE(DATE_SUB(MIN(dwh_valid_from) OVER (PARTITION BY CAST(client_id AS STRING), CAST(sup_sid AS STRING) ORDER BY
        dwh_valid_from IS NULL, dwh_valid_from ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL 1 DAY), PARSE_DATE('%d.%m.%Y'
     , '30.12.9999')) AS dwh_valid_to
  FROM (SELECT DISTINCT client_id,
      sup_sid,
      dwh_valid_from
     FROM ldl_p_lew_core_ac.v_supplier_coneg_country_hist
     UNION DISTINCT
     SELECT DISTINCT client_id,
      sup_sid,
      DATE_ADD(dwh_valid_to, INTERVAL 1 DAY)
     FROM ldl_p_lew_core_ac.v_supplier_coneg_country_hist) AS a
  WHERE dwh_valid_from <> PARSE_DATE('%Y%m%d', '99991231')) AS intvls ON MAINTAB.client_id = intvls.client_id AND
     MAINTAB.sup_sid = intvls.sup_sid AND MAINTAB.dwh_valid_from <= intvls.dwh_valid_to AND MAINTAB.dwh_valid_to >=
   intvls.dwh_valid_from;