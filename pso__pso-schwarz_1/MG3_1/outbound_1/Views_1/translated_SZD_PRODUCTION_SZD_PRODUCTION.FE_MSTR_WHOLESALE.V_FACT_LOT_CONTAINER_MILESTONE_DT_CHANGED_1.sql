CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_fact_lot_container_milestone_dt_changed_1 AS WITH
 container_last_created_updated AS (SELECT MAX(milestone_dt) AS max_milestone_dt_now,
   MAX(done_dt) AS max_done_dt_now,
   COUNT(*) AS total_count_now
  FROM szd_production_core_rel.t_container_shipment_milestone_1
  WHERE container_milestone_cd IN ('eu_container_pickup_pod', 'eu_container_arrival_domestic_terminal',
     'eu_container_goods_in_warehouse', 'eu_container_return_depot')), container_last_milestone_done_before AS (SELECT
   MAX(milestone_dt) AS max_milestone_dt_before,
   MAX(done_dt) AS max_done_dt_before,
   COUNT(*) AS total_count_before
  FROM szd_production_core_rel.t_container_shipment_milestone_1
  WHERE container_milestone_cd IN ('eu_container_pickup_pod', 'eu_container_arrival_domestic_terminal',
     'eu_container_goods_in_warehouse', 'eu_container_return_depot')), container_info AS (SELECT *
  FROM container_last_created_updated AS A
   INNER JOIN (SELECT *
    FROM container_last_milestone_done_before) AS t6 ON TRUE), container_conclusion AS (SELECT CASE
    WHEN max_milestone_dt_now > max_milestone_dt_before
    THEN 'later than before'
    WHEN max_milestone_dt_now = max_milestone_dt_before
    THEN 'same as before'
    ELSE 'earlier than before'
    END AS milestone_dt_cd,
    CASE
    WHEN max_milestone_dt_now > max_milestone_dt_before
    THEN FORMAT_DATE('%F', CURRENT_DATE)
    WHEN max_milestone_dt_now = max_milestone_dt_before
    THEN FORMAT_DATE('%F', DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    ELSE NULL
    END AS milestone_dt_changed,
    CASE
    WHEN max_done_dt_now > max_done_dt_before
    THEN 'later than before'
    WHEN max_done_dt_now = max_done_dt_before
    THEN 'same as before'
    ELSE 'earlier than before'
    END AS done_dt_changed_cd,
    CASE
    WHEN max_done_dt_now > max_done_dt_before
    THEN FORMAT_DATE('%F', CURRENT_DATE)
    WHEN max_done_dt_now = max_done_dt_before
    THEN FORMAT_DATE('%F', DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    ELSE NULL
    END AS done_dt_changed,
    CASE
    WHEN total_count_now > total_count_before
    THEN total_count_now - total_count_before
    WHEN total_count_now = total_count_before
    THEN total_count_now
    ELSE total_count_now - total_count_before
    END AS total_count_changed
  FROM container_info), lot_last_created_updated AS (SELECT MAX(milestone_dt) AS max_milestone_dt_now,
   MAX(done_dt) AS max_done_dt_now,
   COUNT(*) AS total_count_now
  FROM szd_production_core_rel.t_lot_shipment_milestone_1
  WHERE lot_milestone_cd IN ('eta_in_lot', 'etd_in_lot', 'trans_ata', 'trans_atd')), lot_last_milestone_done_before AS (SELECT
   MAX(milestone_dt) AS max_milestone_dt_before,
   MAX(done_dt) AS max_done_dt_before,
   COUNT(*) AS total_count_before
  FROM szd_production_core_rel.t_lot_shipment_milestone_1
  WHERE lot_milestone_cd IN ('eta_in_lot', 'etd_in_lot', 'trans_ata', 'trans_atd')), lot_info AS (SELECT *
  FROM lot_last_created_updated AS A
   INNER JOIN (SELECT *
    FROM lot_last_milestone_done_before) AS t22 ON TRUE), lot_conclusion AS (SELECT CASE
    WHEN max_milestone_dt_now > max_milestone_dt_before
    THEN 'later then before'
    WHEN max_milestone_dt_now = max_milestone_dt_before
    THEN 'same as before'
    ELSE 'earlier than before'
    END AS milestone_dt_changed_cd,
    CASE
    WHEN max_milestone_dt_now > max_milestone_dt_before
    THEN FORMAT_DATE('%F', CURRENT_DATE)
    WHEN max_milestone_dt_now = max_milestone_dt_before
    THEN FORMAT_DATE('%F', DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    ELSE NULL
    END AS newest_milestone_dt,
    CASE
    WHEN max_done_dt_now > max_done_dt_before
    THEN 'later than before'
    WHEN max_done_dt_now = max_done_dt_before
    THEN 'same as before'
    ELSE 'earlier than before'
    END AS done_dt_changed_cd,
    CASE
    WHEN max_done_dt_now > max_done_dt_before
    THEN FORMAT_DATE('%F', CURRENT_DATE)
    WHEN max_done_dt_now = max_done_dt_before
    THEN FORMAT_DATE('%F', DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    ELSE NULL
    END AS done_dt_changed,
    CASE
    WHEN total_count_now > total_count_before
    THEN total_count_now - total_count_before
    WHEN total_count_now = total_count_before
    THEN total_count_now
    ELSE total_count_now - total_count_before
    END AS total_count_changed
  FROM lot_info) (SELECT MAX(milestone_dt_changed) AS lot_milestone_dt_changed,
   MAX(milestone_dt_changed) AS container_milestone_dt_changed
  FROM (SELECT 'container' AS milestone_src,
      CURRENT_DATE AS checked_dt,
       (SELECT CASE
         WHEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(CURRENT_TIMESTAMP() AS TIMESTAMP), 'UTC')) AS TIME)
          < '10:00:00'
         THEN '04:00:00'
         ELSE '10:00:00'
         END AS the_time) AS checked_time,
      DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) AS checked_against_dt,
      '12:00:00' AS checked_against_time,
      milestone_dt_cd,
      milestone_dt_changed,
      done_dt_changed_cd,
      done_dt_changed,
      total_count_changed
     FROM container_conclusion
     UNION ALL
     SELECT 'lot' AS milestone_src,
      CURRENT_DATE AS checked_dt,
       (SELECT CASE
         WHEN CAST(PARSE_TIMESTAMP('%c%z', FORMAT_TIMESTAMP('%c%z', CAST(CURRENT_TIMESTAMP() AS TIMESTAMP), 'UTC')) AS
           TIME) < '10:00:00'
         THEN '04:00:00'
         ELSE '10:00:00'
         END AS the_time) AS checked_time,
      DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) AS checked_against_dt,
      '12:00:00' AS checked_against_time,
      milestone_dt_changed_cd,
      newest_milestone_dt,
      done_dt_changed_cd,
      done_dt_changed,
      total_count_changed
     FROM lot_conclusion) AS t31);