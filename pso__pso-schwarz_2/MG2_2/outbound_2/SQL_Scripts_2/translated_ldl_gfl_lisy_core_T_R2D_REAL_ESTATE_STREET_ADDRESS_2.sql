TRUNCATE TABLE ldl_data_production_etl.t_r2d_real_estate_street_address_2;


INSERT INTO ldl_data_production_etl.t_r2d_real_estate_street_address_2 (real_estate_sid, dwh_valid_from_tmsp,
 dwh_valid_to_tmsp, iso_country_cd, country_name, city_name, district_name, zip, street_name, house_nr, lon, lat,
 reporting_country_cd, reporting_country_name)
WITH re_addr AS (SELECT re.real_estate_sid,
    GREATEST(re.dwh_valid_from_tmsp, rea.dwh_valid_from_tmsp, sa.dwh_valid_from_tmsp) AS val_from,
    LEAST(re.dwh_valid_to_tmsp, rea.dwh_valid_to_tmsp, sa.dwh_valid_to_tmsp) AS val_to,
    sa.iso_country_cd,
    sa.country_name,
    sa.city_name,
    sa.district_name,
    sa.zip,
    sa.street_name,
    sa.house_nr,
    sa.lon,
    sa.lat,
     CASE
     WHEN re.real_estate_nr LIKE 'MT%'
     THEN 'MT'
     ELSE sa.reporting_country_cd
     END AS rep_country_cd,
     CASE
     WHEN re.real_estate_nr LIKE 'MT%'
     THEN 'Malta'
     ELSE rc.reporting_country_name
     END AS rep_country_name,
    TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' || IFNULL(LOWER(sa.country_name), 'Unbekannt') ||
                         '#&#' || IFNULL(LOWER(sa.city_name), '@') || '#&#' || IFNULL(LOWER(sa.district_name), '@') ||
                     '#&#' || IFNULL(LOWER(sa.zip), '@') || '#&#' || IFNULL(LOWER(sa.street_name), '@') || '#&#' ||
                IFNULL(LOWER(CAST(sa.house_nr AS STRING)), '@') || '#&#' || IFNULL(CAST(sa.lon AS STRING), '@') || '#&#'
              || IFNULL(CAST(sa.lat AS STRING), '@') || '#&#' || IFNULL(LOWER(CASE
             WHEN re.real_estate_nr LIKE 'MT%'
             THEN 'MT'
             ELSE sa.reporting_country_cd
             END), '@') || '#&#' || IFNULL(LOWER(CASE
           WHEN re.real_estate_nr LIKE 'MT%'
           THEN 'Malta'
           ELSE rc.reporting_country_name
           END), 'Unbekannt')) AS BYTES)) AS row_hash_for_diff,
    LAG(TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' || IFNULL(LOWER(sa.country_name), 'Unbekannt'
                            ) || '#&#' || IFNULL(LOWER(sa.city_name), '@') || '#&#' || IFNULL(LOWER(sa.district_name),
                        '@') || '#&#' || IFNULL(LOWER(sa.zip), '@') || '#&#' || IFNULL(LOWER(sa.street_name), '@') ||
                  '#&#' || IFNULL(LOWER(CAST(sa.house_nr AS STRING)), '@') || '#&#' || IFNULL(CAST(sa.lon AS STRING),
                '@') || '#&#' || IFNULL(CAST(sa.lat AS STRING), '@') || '#&#' || IFNULL(LOWER(CASE
              WHEN re.real_estate_nr LIKE 'MT%'
              THEN 'MT'
              ELSE sa.reporting_country_cd
              END), '@') || '#&#' || IFNULL(LOWER(CASE
            WHEN re.real_estate_nr LIKE 'MT%'
            THEN 'Malta'
            ELSE rc.reporting_country_name
            END), 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(re.real_estate_sid AS STRING) ORDER BY GREATEST(re.dwh_valid_from_tmsp
        , rea.dwh_valid_from_tmsp, sa.dwh_valid_from_tmsp) IS NULL, GREATEST(re.dwh_valid_from_tmsp, rea.dwh_valid_from_tmsp
        , sa.dwh_valid_from_tmsp)) AS prev_row_hash_for_diff,
     CASE
     WHEN TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' || IFNULL(LOWER(sa.country_name),
                             'Unbekannt') || '#&#' || IFNULL(LOWER(sa.city_name), '@') || '#&#' || IFNULL(LOWER(sa.district_name
                          ), '@') || '#&#' || IFNULL(LOWER(sa.zip), '@') || '#&#' || IFNULL(LOWER(sa.street_name), '@')
                   || '#&#' || IFNULL(LOWER(CAST(sa.house_nr AS STRING)), '@') || '#&#' || IFNULL(CAST(sa.lon AS STRING)
                 , '@') || '#&#' || IFNULL(CAST(sa.lat AS STRING), '@') || '#&#' || IFNULL(LOWER(CASE
               WHEN re.real_estate_nr LIKE 'MT%'
               THEN 'MT'
               ELSE sa.reporting_country_cd
               END), '@') || '#&#' || IFNULL(LOWER(CASE
             WHEN re.real_estate_nr LIKE 'MT%'
             THEN 'Malta'
             ELSE rc.reporting_country_name
             END), 'Unbekannt')) AS BYTES)) = (LAG(TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' ||
                              IFNULL(LOWER(sa.country_name), 'Unbekannt') || '#&#' || IFNULL(LOWER(sa.city_name), '@')
                           || '#&#' || IFNULL(LOWER(sa.district_name), '@') || '#&#' || IFNULL(LOWER(sa.zip), '@') ||
                       '#&#' || IFNULL(LOWER(sa.street_name), '@') || '#&#' || IFNULL(LOWER(CAST(sa.house_nr AS STRING)
                      ), '@') || '#&#' || IFNULL(CAST(sa.lon AS STRING), '@') || '#&#' || IFNULL(CAST(sa.lat AS STRING)
                 , '@') || '#&#' || IFNULL(LOWER(CASE
                 WHEN re.real_estate_nr LIKE 'MT%'
                 THEN 'MT'
                 ELSE sa.reporting_country_cd
                 END), '@') || '#&#' || IFNULL(LOWER(CASE
               WHEN re.real_estate_nr LIKE 'MT%'
               THEN 'Malta'
               ELSE rc.reporting_country_name
               END), 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(re.real_estate_sid AS STRING) ORDER BY GREATEST(re_2
           .dwh_valid_from_tmsp, rea.dwh_valid_from_tmsp, sa.dwh_valid_from_tmsp) IS NULL, GREATEST(re.dwh_valid_from_tmsp
           , rea.dwh_valid_from_tmsp, sa.dwh_valid_from_tmsp)))
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_real_estate_2 AS re_2
    INNER JOIN ldl_data_production_core_rel.t_real_estate_address_2 AS rea ON re.real_estate_sid = rea.real_estate_sid AND
         rea.addr_type_cd = 'STAD' AND rea.addr_usg_type_cd = 'SA_MN' AND re.dwh_valid_to_tmsp >= rea.dwh_valid_from_tmsp
        AND re.dwh_valid_from_tmsp <= rea.dwh_valid_to_tmsp
    INNER JOIN ldl_data_production_core_rel.t_street_address_2 AS sa ON rea.addr_sid = sa.street_addr_sid AND sa.dwh_valid_from_tmsp
        <= LEAST(re.dwh_valid_to_tmsp, rea.dwh_valid_to_tmsp) AND sa.dwh_valid_to_tmsp >= GREATEST(re.dwh_valid_from_tmsp
       , rea.dwh_valid_from_tmsp)
    INNER JOIN ldl_data_production_core_rel.t_reporting_country_2 AS rc ON sa.reporting_country_cd = rc.reporting_country_cd
     ), re_addr_with_groups AS (SELECT real_estate_sid,
    val_from,
    val_to,
    iso_country_cd,
    country_name,
    city_name,
    district_name,
    zip,
    street_name,
    house_nr,
    lon,
    lat,
    rep_country_cd,
    rep_country_name,
    row_hash_for_diff,
    prev_row_hash_for_diff,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(real_estate_sid AS STRING) ORDER BY val_from IS NULL, val_from,
       has_change_fg IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM re_addr AS t0) (SELECT real_estate_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    iso_country_cd,
    country_name,
    city_name,
    district_name,
    zip,
    street_name,
    house_nr,
    lon,
    lat,
    rep_country_cd AS reporting_country_cd,
    rep_country_name AS reporting_country_name
   FROM re_addr_with_groups
   GROUP BY real_estate_sid,
    iso_country_cd,
    country_name,
    city_name,
    district_name,
    zip,
    street_name,
    house_nr,
    lon,
    lat,
    reporting_country_cd,
    reporting_country_name,
    group_id);