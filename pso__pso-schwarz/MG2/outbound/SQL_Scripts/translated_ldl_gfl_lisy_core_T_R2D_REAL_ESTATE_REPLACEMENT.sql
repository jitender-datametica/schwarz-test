TRUNCATE TABLE ldl_data_production_etl.t_r2d_real_estate_replacement;


INSERT INTO ldl_data_production_etl.t_r2d_real_estate_replacement (real_estate_sid, dwh_valid_from_tmsp,
 dwh_valid_to_tmsp, replacement_real_estate_sid, replacement_real_estate_nr, replacement_real_estate_name,
 real_estate_replacement_type_cd, real_estate_replacement_type_descr)
WITH repl AS (SELECT rr.real_estate_sid,
    rr.replacement_real_estate_sid,
    GREATEST(rr.dwh_valid_from_tmsp, r.dwh_valid_from_tmsp) AS val_from,
    LEAST(rr.dwh_valid_to_tmsp, r.dwh_valid_to_tmsp) AS val_to,
    r.real_estate_nr AS replacement_real_estate_nr,
    r.real_estate_name AS replacement_real_estate_name,
    rert.real_estate_replacement_type_cd,
    rert.real_estate_replacement_type_descr,
    TO_HEX(CAST(SHA256(IFNULL(CAST(rr.replacement_real_estate_sid AS STRING), CAST(- 1 AS STRING)) || '#&#' || IFNULL(LOWER(r
                .real_estate_nr), '@') || '#&#' || IFNULL(LOWER(r.real_estate_name), 'Unbekannt') || '#&#' || IFNULL(LOWER(rert
            .real_estate_replacement_type_cd), '@') || '#&#' || IFNULL(LOWER(rert.real_estate_replacement_type_descr),
         'Unbekannt')) AS BYTES)) AS row_hash_for_diff,
    LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(rr.replacement_real_estate_sid AS STRING), CAST(- 1 AS STRING)) || '#&#' ||
               IFNULL(LOWER(r.real_estate_nr), '@') || '#&#' || IFNULL(LOWER(r.real_estate_name), 'Unbekannt') || '#&#'
           || IFNULL(LOWER(rert.real_estate_replacement_type_cd), '@') || '#&#' || IFNULL(LOWER(rert.real_estate_replacement_type_descr
           ), 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(rr.real_estate_sid AS STRING) ORDER BY GREATEST(rr.dwh_valid_from_tmsp
        , r.dwh_valid_from_tmsp) IS NULL, GREATEST(rr.dwh_valid_from_tmsp, r.dwh_valid_from_tmsp)) AS
    prev_row_hash_for_diff,
     CASE
     WHEN TO_HEX(CAST(SHA256(IFNULL(CAST(rr.replacement_real_estate_sid AS STRING), CAST(- 1 AS STRING)) || '#&#' ||
                IFNULL(LOWER(r.real_estate_nr), '@') || '#&#' || IFNULL(LOWER(r.real_estate_name), 'Unbekannt') || '#&#'
              || IFNULL(LOWER(rert.real_estate_replacement_type_cd), '@') || '#&#' || IFNULL(LOWER(rert.real_estate_replacement_type_descr
            ), 'Unbekannt')) AS BYTES)) = (LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(rr.replacement_real_estate_sid AS STRING)
                    , CAST(- 1 AS STRING)) || '#&#' || IFNULL(LOWER(r.real_estate_nr), '@') || '#&#' || IFNULL(LOWER(r.real_estate_name
                  ), 'Unbekannt') || '#&#' || IFNULL(LOWER(rert.real_estate_replacement_type_cd), '@') || '#&#' ||
            IFNULL(LOWER(rert.real_estate_replacement_type_descr), 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(rr.real_estate_sid AS STRING)
          ORDER BY GREATEST(rr.dwh_valid_from_tmsp, r.dwh_valid_from_tmsp) IS NULL, GREATEST(rr.dwh_valid_from_tmsp, r.dwh_valid_from_tmsp
           )))
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_real_estate_replacement AS rr
    INNER JOIN ldl_data_production_core_rel.t_real_estate AS r ON rr.replacement_real_estate_sid = r.real_estate_sid AND
       rr.dwh_valid_from_tmsp <= r.dwh_valid_to_tmsp AND rr.dwh_valid_to_tmsp >= r.dwh_valid_from_tmsp
    INNER JOIN ldl_data_production_core_rel.t_real_estate_replacement_type AS rert ON rr.real_estate_replacement_type_cd
       = rert.real_estate_replacement_type_cd AND rert.lang_cd = 'DE'), repl_with_groups AS (SELECT real_estate_sid,
    replacement_real_estate_sid,
    val_from,
    val_to,
    replacement_real_estate_nr,
    replacement_real_estate_name,
    real_estate_replacement_type_cd,
    real_estate_replacement_type_descr,
    row_hash_for_diff,
    prev_row_hash_for_diff,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(real_estate_sid AS STRING) ORDER BY val_from IS NULL, val_from,
       has_change_fg IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM repl AS t0) (SELECT real_estate_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    replacement_real_estate_sid,
    replacement_real_estate_nr,
    replacement_real_estate_name,
    real_estate_replacement_type_cd,
    real_estate_replacement_type_descr
   FROM repl_with_groups
   GROUP BY real_estate_sid,
    replacement_real_estate_sid,
    replacement_real_estate_nr,
    replacement_real_estate_name,
    real_estate_replacement_type_cd,
    real_estate_replacement_type_descr,
    group_id);