BEGIN TRANSACTION;
-- at least one of the values from source is not the same as target
MERGE INTO ldl_data_production_core_rel.t_internal_organization_2 AS trg
USING (
  SELECT
    int_org.int_org_sid,
    int_org.dwh_valid_from_tmsp,
    MIN(open_dt) OVER (
      PARTITION BY CAST(int_org.int_org_sid AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS min_open_dt,
    MIN(DATE(planned_open_dt)) OVER (
      PARTITION BY CAST(int_org.int_org_sid AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS min_planned_open_dt,
    LAST_VALUE(DATE(close_dt)) OVER (
      PARTITION BY CAST(int_org.int_org_sid AS STRING)
      ORDER BY (close_dt IS NULL), close_dt
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS max_close_dt
  FROM ldl_data_production_core_rel.t_internal_organization_2 AS int_org
  WHERE int_org.int_org_type_cd = 'STORE'
) AS src
ON trg.int_org_sid = src.int_org_sid
   AND trg.dwh_valid_from_tmsp = src.dwh_valid_from_tmsp
WHEN MATCHED
  AND NOT (
       trg.open_dt        = src.min_open_dt
    AND trg.planned_open_dt = src.min_planned_open_dt
    AND trg.close_dt       = src.max_close_dt
  )
THEN UPDATE SET
  open_dt        = src.min_open_dt,
  planned_open_dt = src.min_planned_open_dt,
  close_dt        = src.max_close_dt
;
COMMIT;