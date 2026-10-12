CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_refresh_status_inv_2 (client_id
OPTIONS(description='Client id - calculated based on the country_2 code'), wh_id OPTIONS(description='Warehouse id'),
inv_dwh_updated OPTIONS(description='Latest update for T073 table per warehouse'), inv_dwh_updated_glb
OPTIONS(description='Latest refresh for T073 table per warehouse'), inv_update_status
OPTIONS(description='Time between Current Date and latest update for T073 table per warehouse (in days)'),
inh_dwh_updated OPTIONS(description='Latest update for T072 table per warehouse'), inh_dwh_updated_glb
OPTIONS(description='Latest refresh for T072 table per warehouse'), inh_update_status
OPTIONS(description='Time between Current Date and latest update for T072 table per warehouse (in days)'),
stc_dwh_updated OPTIONS(description='Latest update for T067 table per warehouse'), stc_dwh_updated_glb
OPTIONS(description='Latest refresh for T067 table per warehouse'), stc_update_status
OPTIONS(description='Time between Current Date and latest update for T067 table per warehouse (in days)'),
da_dwh_updated OPTIONS(description='Latest update for SAPEWM Difference Analyzer per warehouse'), da_dwh_updated_glb
OPTIONS(description='Latest refresh for SAPEWM Difference Analyzer per warehouse'), da_update_status
OPTIONS(description='Time between Current Date and latest update for SAPEWM Difference Analyzer per warehouse (in days)'),
acc_dwh_updated OPTIONS(description='Latest update for T090 table per warehouse'), acc_dwh_updated_glb
OPTIONS(description='Latest refresh for T090 table per warehouse'), acc_update_status
OPTIONS(description='Time between Current Date and latest update for T090 table per warehouse (in days)'),
bsd_dwh_updated OPTIONS(description='Latest update for Bestandartikel_2 table per warehouse'), bsd_dwh_updated_glb
OPTIONS(description='Latest refresh for Bestandartikel_2 table per warehouse'), bsd_update_status
OPTIONS(description='Time between Current Date and latest update for Bestandartikel_2 table per warehouse (in days)'),
sv_dwh_updated OPTIONS(description='Latest update for T1001 table per warehouse'), sv_dwh_updated_glb
OPTIONS(description='Latest refresh for T1001 table per warehouse'), sv_update_status
OPTIONS(description='Time between Current Date and latest update for T1001 table per warehouse (in days)'),
mi_dwh_updated OPTIONS(description='Latest update for T178 table per warehouse'), mi_dwh_updated_glb
OPTIONS(description='Latest refresh for T178 table per warehouse'), mi_update_status
OPTIONS(description='Time between Current Date and latest update for T178 table per warehouse (in days)'),
is_dwh_updated OPTIONS(description='Latest update for T117 table per warehouse'), is_dwh_updated_glb
OPTIONS(description='Latest refresh for T117 table per warehouse'), is_update_status
OPTIONS(description='Time between Current Date and latest update for T117 table per warehouse (in days)')) AS WITH RWH
 AS (SELECT client_id,
   wh_id
  FROM ldl_logop_fe_mstr_logop.v_ref_wh_2), T073 AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND wh_id = 600
    THEN 60
    WHEN client_id = 18 AND wh_id = 20
    THEN 4
    WHEN client_id = 21 AND wh_id = 20
    THEN 22
    ELSE wh_id
    END AS wh_id,
   MAX(mod_date) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS inv_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS inv_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS inv_update_status
  FROM ldl_logop_data.t_wawi_inventorydet_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg), T072 AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   MAX(mod_date) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS inh_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_nr AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS inh_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_nr AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS inh_update_status
  FROM ldl_logop_data.t_wawi_inventory_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg), T067 AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND wh_id = 600
    THEN 60
    WHEN client_id = 18 AND wh_id = 20
    THEN 4
    WHEN client_id = 21 AND wh_id = 20
    THEN 22
    ELSE wh_id
    END AS wh_id,
   MAX(mod_date) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS stc_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS stc_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS stc_update_status
  FROM ldl_logop_data.t_wawi_stock_corr_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg), TEWMDA AS (SELECT DISTINCT client_id,
   wh_id,
   PARSE_DATETIME('%F %H:%M:%S', CAST(posted_date AS STRING) || ' ' || CAST(posted_time AS STRING)) AS posted_date_tmsp
   ,
   MAX(PARSE_DATETIME('%F %H:%M:%S', CAST(posted_date AS STRING) || ' ' || CAST(posted_time AS STRING))) OVER (PARTITION BY CAST(client_id AS STRING)
      , CAST(wh_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS da_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS da_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS da_update_status
  FROM ldl_logop_data.t_sapewm_differenceanalyzer_2), T090 AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   MAX(form_dt) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_nr AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING) AS acc_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_nr AS STRING) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS acc_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_nr AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS acc_update_status
  FROM ldl_logop_data.t_wawi_whaccount_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND form_type IN (10, 11, 12, 40, 41, 44, 45, 46, 54, 55, 65, 80, 81, 130, 131, 135, 138, 140, 141, 145, 148, 150,
     151, 160, 161)
   AND CAST(day_end_dt AS DATE) BETWEEN DATE '2024-03-01' AND (CURRENT_DATE)
   AND NOT deleted_fg), BSTD AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   MAX(datum) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS bsd_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS bsd_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS bsd_update_status
  FROM ldl_logop_data.t_wawi_bestandartikel_act_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg), T1001 AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   MAX(cal_dt) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS sv_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS sv_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS sv_update_status
  FROM ldl_logop_data.t_wawi_stock_value_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND stock_area = 2
   AND NOT deleted_fg), T178 AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND wh_nr = 600
    THEN 60
    WHEN client_id = 18 AND wh_nr = 20
    THEN 4
    WHEN client_id = 21 AND wh_nr = 20
    THEN 22
    ELSE wh_nr
    END AS wh_id,
   MAX(ins_date) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS mi_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS mi_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS mi_update_status
  FROM ldl_logop_data.t_wawi_missing_items_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND missing_until IS NULL
   AND status_2 < 40
   AND NOT deleted_fg), T117 AS (SELECT DISTINCT client_id,
    CASE
    WHEN client_id = 13 AND warehouseno = 600
    THEN 60
    WHEN client_id = 18 AND warehouseno = 20
    THEN 4
    WHEN client_id = 21 AND warehouseno = 20
    THEN 22
    ELSE warehouseno
    END AS wh_id,
   MAX(updatedon) OVER (PARTITION BY CAST(client_id AS STRING), warehouseno RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS is_dwh_updated,
   MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), warehouseno RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS is_dwh_updated_glb,
   DATETIME_DIFF(CAST(CURRENT_DATE AS DATETIME), MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING),
       warehouseno RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING), DAY) AS is_update_status
  FROM ldl_logop_data.t_wawi_itemstatus_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
   AND NOT deleted_fg) (SELECT a.client_id,
   a.wh_id,
   b.inv_dwh_updated,
   b.inv_dwh_updated_glb,
   b.inv_update_status,
   c.inh_dwh_updated,
   c.inh_dwh_updated_glb,
   c.inh_update_status,
   d.stc_dwh_updated,
   d.stc_dwh_updated_glb,
   d.stc_update_status,
   e.da_dwh_updated,
   e.da_dwh_updated_glb,
   e.da_update_status,
   f.acc_dwh_updated,
   f.acc_dwh_updated_glb,
   f.acc_update_status,
   g.bsd_dwh_updated,
   g.bsd_dwh_updated_glb,
   g.bsd_update_status,
   h.sv_dwh_updated,
   h.sv_dwh_updated_glb,
   h.sv_update_status,
   i.mi_dwh_updated,
   i.mi_dwh_updated_glb,
   i.mi_update_status,
   j.is_dwh_updated,
   j.is_dwh_updated_glb,
   j.is_update_status
  FROM RWH AS a
   LEFT JOIN T073 AS b ON a.client_id = b.client_id AND a.wh_id = b.wh_id
   LEFT JOIN T072 AS c ON a.client_id = c.client_id AND a.wh_id = c.wh_id
   LEFT JOIN T067 AS d ON a.client_id = d.client_id AND a.wh_id = d.wh_id
   LEFT JOIN TEWMDA AS e ON a.client_id = e.client_id AND a.wh_id = e.wh_id
   LEFT JOIN T090 AS f ON a.client_id = f.client_id AND a.wh_id = f.wh_id
   LEFT JOIN BSTD AS g ON a.client_id = g.client_id AND a.wh_id = g.wh_id
   LEFT JOIN T1001 AS h ON a.client_id = h.client_id AND a.wh_id = h.wh_id
   LEFT JOIN T178 AS i ON a.client_id = i.client_id AND a.wh_id = i.wh_id
   LEFT JOIN T117 AS j ON a.client_id = j.client_id AND a.wh_id = j.wh_id);