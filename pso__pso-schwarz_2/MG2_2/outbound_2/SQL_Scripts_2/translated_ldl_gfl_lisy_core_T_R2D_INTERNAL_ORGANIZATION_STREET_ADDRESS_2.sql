TRUNCATE TABLE ldl_data_production_etl.t_r2d_internal_organization_street_address_2;


INSERT INTO ldl_data_production_etl.t_r2d_internal_organization_street_address_2 (int_org_sid, dwh_valid_from_tmsp,
 dwh_valid_to_tmsp, iso_country_cd, country_name, city_name, district_name, zip, street_name, house_nr, lon, lat,
 reporting_country_cd, reporting_country_name)
WITH int_org_addr AS (SELECT io.int_org_sid,
    GREATEST(io.dwh_valid_from_tmsp, pa.dwh_valid_from_tmsp, sa.dwh_valid_from_tmsp) AS val_from,
    LEAST(io.dwh_valid_to_tmsp, pa.dwh_valid_to_tmsp, sa.dwh_valid_to_tmsp) AS val_to,
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
     WHEN io.int_org_nr LIKE 'MT%'
     THEN 'MT'
     ELSE sa.reporting_country_cd
     END AS rep_country_cd,
     CASE
     WHEN io.int_org_nr LIKE 'MT%'
     THEN 'Malta'
     ELSE rc.reporting_country_name
     END AS rep_country_name,
    TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' || IFNULL(sa.country_name, 'Unbekannt') || '#&#'
                        || IFNULL(sa.city_name, '@') || '#&#' || IFNULL(sa.district_name, '@') || '#&#' || IFNULL(sa.zip
                     , '@') || '#&#' || IFNULL(sa.street_name, '@') || '#&#' || IFNULL(CAST(sa.house_nr AS STRING), '@'
                 ) || '#&#' || IFNULL(CAST(sa.lon AS STRING), '@') || '#&#' || IFNULL(CAST(sa.lat AS STRING), '@') ||
           '#&#' || IFNULL(CASE
            WHEN io.int_org_nr LIKE 'MT%'
            THEN 'MT'
            ELSE sa.reporting_country_cd
            END, '@') || '#&#' || IFNULL(CASE
          WHEN io.int_org_nr LIKE 'MT%'
          THEN 'Malta'
          ELSE rc.reporting_country_name
          END, 'Unbekannt')) AS BYTES)) AS row_hash_for_diff,
    LAG(TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' || IFNULL(sa.country_name, 'Unbekannt') ||
                          '#&#' || IFNULL(sa.city_name, '@') || '#&#' || IFNULL(sa.district_name, '@') || '#&#' ||
                     IFNULL(sa.zip, '@') || '#&#' || IFNULL(sa.street_name, '@') || '#&#' || IFNULL(CAST(sa.house_nr AS STRING)
                  , '@') || '#&#' || IFNULL(CAST(sa.lon AS STRING), '@') || '#&#' || IFNULL(CAST(sa.lat AS STRING), '@'
              ) || '#&#' || IFNULL(CASE
             WHEN io.int_org_nr LIKE 'MT%'
             THEN 'MT'
             ELSE sa.reporting_country_cd
             END, '@') || '#&#' || IFNULL(CASE
           WHEN io.int_org_nr LIKE 'MT%'
           THEN 'Malta'
           ELSE rc.reporting_country_name
           END, 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(io.int_org_sid AS STRING) ORDER BY GREATEST(io.dwh_valid_from_tmsp
        , pa.dwh_valid_from_tmsp, sa.dwh_valid_from_tmsp) IS NULL, GREATEST(io.dwh_valid_from_tmsp, pa.dwh_valid_from_tmsp
        , sa.dwh_valid_from_tmsp)) AS prev_row_hash_for_diff,
     CASE
     WHEN TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' || IFNULL(sa.country_name, 'Unbekannt') ||
                           '#&#' || IFNULL(sa.city_name, '@') || '#&#' || IFNULL(sa.district_name, '@') || '#&#' ||
                      IFNULL(sa.zip, '@') || '#&#' || IFNULL(sa.street_name, '@') || '#&#' || IFNULL(CAST(sa.house_nr AS STRING)
                   , '@') || '#&#' || IFNULL(CAST(sa.lon AS STRING), '@') || '#&#' || IFNULL(CAST(sa.lat AS STRING), '@'
               ) || '#&#' || IFNULL(CASE
              WHEN io.int_org_nr LIKE 'MT%'
              THEN 'MT'
              ELSE sa.reporting_country_cd
              END, '@') || '#&#' || IFNULL(CASE
            WHEN io.int_org_nr LIKE 'MT%'
            THEN 'Malta'
            ELSE rc.reporting_country_name
            END, 'Unbekannt')) AS BYTES)) = (LAG(TO_HEX(CAST(SHA256(IFNULL(LOWER(sa.iso_country_cd), '@') || '#&#' ||
                              IFNULL(sa.country_name, 'Unbekannt') || '#&#' || IFNULL(sa.city_name, '@') || '#&#' ||
                          IFNULL(sa.district_name, '@') || '#&#' || IFNULL(sa.zip, '@') || '#&#' || IFNULL(sa.street_name
                       , '@') || '#&#' || IFNULL(CAST(sa.house_nr AS STRING), '@') || '#&#' || IFNULL(CAST(sa.lon AS STRING)
                   , '@') || '#&#' || IFNULL(CAST(sa.lat AS STRING), '@') || '#&#' || IFNULL(CASE
                WHEN io.int_org_nr LIKE 'MT%'
                THEN 'MT'
                ELSE sa.reporting_country_cd
                END, '@') || '#&#' || IFNULL(CASE
              WHEN io.int_org_nr LIKE 'MT%'
              THEN 'Malta'
              ELSE rc.reporting_country_name
              END, 'Unbekannt')) AS BYTES))) OVER (PARTITION BY CAST(io.int_org_sid AS STRING) ORDER BY GREATEST(io.dwh_valid_from_tmsp
           , pa.dwh_valid_from_tmsp, sa.dwh_valid_from_tmsp) IS NULL, GREATEST(io.dwh_valid_from_tmsp, pa.dwh_valid_from_tmsp
           , sa.dwh_valid_from_tmsp)))
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_internal_organization_2 AS io
    INNER JOIN ldl_data_production_core_rel.t_party_address_2 AS pa ON io.int_org_sid = pa.party_sid AND pa.addr_type_cd =
         'STAD' AND pa.addr_usg_type_cd = 'SA_MN' AND io.dwh_valid_to_tmsp >= pa.dwh_valid_from_tmsp AND io.dwh_valid_from_tmsp
       <= pa.dwh_valid_to_tmsp
    INNER JOIN ldl_data_production_core_rel.t_street_address_2 AS sa ON pa.addr_sid = sa.street_addr_sid AND sa.dwh_valid_from_tmsp
        <= LEAST(io.dwh_valid_to_tmsp, pa.dwh_valid_to_tmsp) AND sa.dwh_valid_to_tmsp >= GREATEST(io.dwh_valid_from_tmsp
       , pa.dwh_valid_from_tmsp)
    INNER JOIN ldl_data_production_core_rel.t_reporting_country_2 AS rc ON sa.reporting_country_cd = rc.reporting_country_cd
     ), io_addr_with_groups AS (SELECT int_org_sid,
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
    SUM(has_change_fg) OVER (PARTITION BY CAST(int_org_sid AS STRING) ORDER BY val_from IS NULL, val_from, has_change_fg
       IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM int_org_addr AS io_addr) (SELECT int_org_sid,
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
   FROM io_addr_with_groups
   GROUP BY int_org_sid,
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