CREATE OR REPLACE FUNCTION ldl_production_p_lew_mart_pit.f_gethistsourcesystemid(
  p_sourcesystemname STRING,
  p_repdate DATE
)
RETURNS INT64
AS (
  IFNULL(
    (
      SELECT MAX(x.source_system_id)
      FROM (
        SELECT
          sc.source_system_id
        FROM
          ldl_production_p_lew_mart_pit.t_cntl_dim_source_system_1 AS sc
        WHERE
          sc.deleted_fg = 0
          AND sc.reject_fg = 0
          AND UPPER(TRIM(sc.source_system_name)) LIKE CONCAT('%', UPPER(TRIM(p_sourcesystemname)), '%')
          AND (
            (p_repdate IS NULL AND sc.current_fg = 1)
            OR (p_repdate BETWEEN sc.valid_from_dt AND sc.valid_to_dt)
          )
        QUALIFY
          ROW_NUMBER() OVER (
            PARTITION BY sc.source_system_id, sc.valid_from_dt, sc.deleted_fg
            ORDER BY sc.dwh_updated_ts
          ) = 1
      ) x
    ),
    -1
  )
);
