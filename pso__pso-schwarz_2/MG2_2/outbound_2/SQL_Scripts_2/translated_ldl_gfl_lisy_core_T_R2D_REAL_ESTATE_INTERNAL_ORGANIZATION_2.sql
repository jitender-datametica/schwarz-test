TRUNCATE TABLE ldl_data_production_etl.t_r2d_real_estate_internal_organization_2;


INSERT INTO ldl_data_production_etl.t_r2d_real_estate_internal_organization_2 (real_estate_sid, int_org_sid,
 dwh_valid_from_tmsp, dwh_valid_to_tmsp, curr_int_org_nr, int_org_name, int_org_type_cd, int_org_type_descr,
 store_real_estate_type_cd, store_real_estate_type_descr)
WITH reio AS (SELECT iore.real_estate_sid,
    io.int_org_sid,
    GREATEST(iore.dwh_valid_from_tmsp, io.dwh_valid_from_tmsp, IFNULL(re.dwh_valid_from_tmsp, iore.dwh_valid_from_tmsp)
     ) AS val_from,
    LEAST(iore.dwh_valid_to_tmsp, io.dwh_valid_to_tmsp, IFNULL(re.dwh_valid_to_tmsp, iore.dwh_valid_to_tmsp)) AS val_to
    ,
    io.int_org_nr AS curr_int_org_nr,
    io.int_org_name,
    io.int_org_type_cd,
    iot.int_org_type_descr,
     CASE
     WHEN (COUNT(ret.real_estate_type_cd) OVER (PARTITION BY CAST(iore.int_org_sid AS STRING), iore.dwh_valid_from_tmsp
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1
     THEN 'BOTH'
     ELSE IFNULL(ret.real_estate_type_cd, '@')
     END AS store_real_estate_type_cd,
     CASE
     WHEN (COUNT(ret.real_estate_type_cd) OVER (PARTITION BY CAST(iore.int_org_sid AS STRING), iore.dwh_valid_from_tmsp
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 1
     THEN 'Filiale und Sonderverkauf'
     ELSE IFNULL(ret.real_estate_type_descr, 'Unbekannt')
     END AS store_real_estate_type_descr,
    TO_HEX(CAST(SHA256(IFNULL(CAST(io.int_org_sid AS STRING), CAST(- 1 AS STRING)) || '#&#' || IFNULL(LOWER(io.int_org_nr
                    ), '@') || '#&#' || IFNULL(LOWER(io.int_org_name), 'Unbekannt') || '#&#' || IFNULL(LOWER(io.int_org_type_cd
                ), '@') || '#&#' || IFNULL(LOWER(iot.int_org_type_descr), 'Unbekannt') || '#&#' || IFNULL(LOWER(ret.real_estate_type_cd
            ), '@') || '#&#' || IFNULL(LOWER(ret.real_estate_type_descr), 'Unbekannt')) AS BYTES)) AS row_hash_for_diff
    ,
    LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(io.int_org_sid AS STRING), CAST(- 1 AS STRING)) || '#&#' || IFNULL(LOWER(io.int_org_nr
                     ), '@') || '#&#' || IFNULL(LOWER(io.int_org_name), 'Unbekannt') || '#&#' || IFNULL(LOWER(io.int_org_type_cd
                 ), '@') || '#&#' || IFNULL(LOWER(iot.int_org_type_descr), 'Unbekannt') || '#&#' || IFNULL(LOWER(ret.real_estate_type_cd
             ), '@') || '#&#' || IFNULL(LOWER(ret.real_estate_type_descr), 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(iore.real_estate_sid AS STRING)
       ORDER BY GREATEST(iore.dwh_valid_from_tmsp, io.dwh_valid_from_tmsp, IFNULL(re.dwh_valid_from_tmsp, iore.dwh_valid_from_tmsp
         )) IS NULL, GREATEST(iore.dwh_valid_from_tmsp, io.dwh_valid_from_tmsp, IFNULL(re.dwh_valid_from_tmsp, iore.dwh_valid_from_tmsp
         ))) AS prev_row_hash_for_diff,
     CASE
     WHEN TO_HEX(CAST(SHA256(IFNULL(CAST(io.int_org_sid AS STRING), CAST(- 1 AS STRING)) || '#&#' || IFNULL(LOWER(io.int_org_nr
                      ), '@') || '#&#' || IFNULL(LOWER(io.int_org_name), 'Unbekannt') || '#&#' || IFNULL(LOWER(io.int_org_type_cd
                  ), '@') || '#&#' || IFNULL(LOWER(iot.int_org_type_descr), 'Unbekannt') || '#&#' || IFNULL(LOWER(ret.real_estate_type_cd
              ), '@') || '#&#' || IFNULL(LOWER(ret.real_estate_type_descr), 'Unbekannt')) AS BYTES)) = (LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(io.int_org_sid AS STRING)
                        , CAST(- 1 AS STRING)) || '#&#' || IFNULL(LOWER(io.int_org_nr), '@') || '#&#' || IFNULL(LOWER(io
                      .int_org_name), 'Unbekannt') || '#&#' || IFNULL(LOWER(io.int_org_type_cd), '@') || '#&#' || IFNULL(LOWER(iot
                  .int_org_type_descr), 'Unbekannt') || '#&#' || IFNULL(LOWER(ret.real_estate_type_cd), '@') || '#&#' ||
            IFNULL(LOWER(ret.real_estate_type_descr), 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(iore.real_estate_sid AS STRING)
          ORDER BY GREATEST(iore.dwh_valid_from_tmsp, io.dwh_valid_from_tmsp, IFNULL(re.dwh_valid_from_tmsp, iore.dwh_valid_from_tmsp
            )) IS NULL, GREATEST(iore.dwh_valid_from_tmsp, io.dwh_valid_from_tmsp, IFNULL(re.dwh_valid_from_tmsp, iore.dwh_valid_from_tmsp
            ))))
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_internal_organization_real_estate_2 AS iore
    INNER JOIN ldl_data_production_core_rel.t_internal_organization_2 AS io ON iore.int_org_sid = io.int_org_sid AND iore
        .dwh_valid_to_tmsp >= io.dwh_valid_from_tmsp AND iore.dwh_valid_from_tmsp <= io.dwh_valid_to_tmsp AND iore.int_org_real_estate_usg_type_cd
       = 'USED_BY'
    INNER JOIN ldl_data_production_core_rel.t_internal_organization_type_2 AS iot ON io.int_org_type_cd = iot.int_org_type_cd
       AND iot.lang_cd = 'DE'
    LEFT JOIN ldl_data_production_core_rel.t_real_estate_2 AS re_2 ON iore.real_estate_sid = re.real_estate_sid AND re.dwh_valid_from_tmsp
        <= LEAST(iore.dwh_valid_to_tmsp, io.dwh_valid_to_tmsp) AND re.dwh_valid_to_tmsp >= GREATEST(iore.dwh_valid_from_tmsp
       , io.dwh_valid_from_tmsp)
    LEFT JOIN ldl_data_production_core_rel.t_real_estate_type_2 AS ret ON re.real_estate_type_cd = ret.real_estate_type_cd
       AND ret.lang_cd = 'DE'), reio_with_groups AS (SELECT real_estate_sid,
    int_org_sid,
    val_from,
    val_to,
    curr_int_org_nr,
    int_org_name,
    int_org_type_cd,
    int_org_type_descr,
    store_real_estate_type_cd,
    store_real_estate_type_descr,
    row_hash_for_diff,
    prev_row_hash_for_diff,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(real_estate_sid AS STRING) ORDER BY val_from IS NULL, val_from,
       has_change_fg IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM reio AS t0) (SELECT real_estate_sid,
    int_org_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    curr_int_org_nr,
    int_org_name,
    int_org_type_cd,
    int_org_type_descr,
    store_real_estate_type_cd,
    store_real_estate_type_descr
   FROM reio_with_groups
   GROUP BY real_estate_sid,
    int_org_sid,
    curr_int_org_nr,
    int_org_name,
    int_org_type_cd,
    int_org_type_descr,
    store_real_estate_type_cd,
    store_real_estate_type_descr,
    group_id);