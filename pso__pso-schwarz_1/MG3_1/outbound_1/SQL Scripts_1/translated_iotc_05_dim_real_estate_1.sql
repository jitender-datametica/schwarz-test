BEGIN TRANSACTION;


TRUNCATE TABLE core.`${TST_PREFIX}T_DIM_REAL_ESTATE_1`;


INSERT INTO core.`${TST_PREFIX}T_DIM_REAL_ESTATE_1` (resource_item_sid
 , dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, division_party_sid, division_cd, division_name,
 country_location_sid, country_cd, country_name, real_estate_nr, zip, city, street, latitude, longitude,
 dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, dwh_src_1_tmsp)
(SELECT t0.resource_item_sid,
  t0.dwh_valid_from_tmsp,
  TIMESTAMP_SUB(LEAD(t0.dwh_valid_from_tmsp, 1, CAST('9999-12-31 23:59:59.999' AS TIMESTAMP)) OVER
    (PARTITION BY t0.resource_item_sid ORDER BY t0.dwh_valid_from_tmsp IS NULL, t0.dwh_valid_from_tmsp), INTERVAL 1
   MILLISECOND) AS dwh_valid_to_tmsp,
   CURRENT_TIMESTAMP() BETWEEN t0.dwh_valid_from_tmsp AND (TIMESTAMP_SUB(LEAD(t0.dwh_valid_from_tmsp, 1, CAST('9999-12-31 23:59:59.999' AS TIMESTAMP)
      ) OVER (PARTITION BY t0.resource_item_sid ORDER BY t0.dwh_valid_from_tmsp IS NULL, t0.dwh_valid_from_tmsp),
     INTERVAL 1 MILLISECOND)) AS dwh_valid_fg,
  t0.division_party_sid,
  t0.division_cd,
  t0.division_name,
  t0.country_location_sid,
  t0.iso_country_cd,
  t0.country_name,
  t0.real_estate_nr,
  t0.zip,
  t0.city_name,
  t0.street,
  t0.latitude,
  t0.longitude,
  t0.dwh_created_tmsp,
  t0.dwh_updated_tmsp,
  t0.dwh_src_file_name,
  t0.dwh_src_1_tmsp
 FROM (SELECT re.resource_item_sid,
    re.dwh_valid_from_tmsp,
    re.division_party_sid,
    dv.division_cd,
    dv.division_name,
    re.country_location_sid,
    COALESCE(co.iso_country_cd, '-1') AS iso_country_cd,
    COALESCE(co.country_name, 'Unbekannt') AS country_name,
    re.real_estate_nr,
     CASE
     WHEN pc.zip = '-1'
     THEN 'UNBEKANNT'
     ELSE CAST(pc.zip AS STRING)
     END AS zip,
    ct.city_name,
    TRIM(sa.street_name || ' ' || COALESCE(sa.house_nr, '')) AS street,
    sa.latitude,
    sa.longitude,
    re.dwh_created_tmsp,
    re.dwh_updated_tmsp,
    re.dwh_src_file_name,
    re.dwh_src_1_tmsp,
      (LAG(TO_HEX(MD5(CAST(COALESCE(re.division_party_sid, - 1) AS STRING) || '^' || COALESCE(dv.division_cd, '-1') ||
                               '^' || COALESCE(dv.division_name, '-1') || '^' || CAST(COALESCE(re.country_location_sid, - 1) AS STRING)
                             || '^' || COALESCE(co.iso_country_cd, '-1') || '^' || COALESCE(co.country_name, '#') || '^'
                        || COALESCE(re.real_estate_nr, '#') || '^' || COALESCE(pc.zip, '#') || '^' || COALESCE(ct.city_name
                   , '#') || '^' || COALESCE(sa.street_name, '#') || '^' || COALESCE(sa.house_nr, '#') || '^' || CAST(COALESCE(sa.latitude, - 1) AS STRING)
             || '^' || CAST(COALESCE(sa.longitude, - 1) AS STRING))), 1, '#') OVER (PARTITION BY re.resource_item_sid
       ORDER BY re.dwh_valid_from_tmsp IS NULL, re.dwh_valid_from_tmsp)) <> TO_HEX(MD5(CAST(COALESCE(re.division_party_sid, - 1) AS STRING)
                               || '^' || COALESCE(dv.division_cd, '-1') || '^' || COALESCE(dv.division_name, '-1') ||
                           '^' || CAST(COALESCE(re.country_location_sid, - 1) AS STRING) || '^' || COALESCE(co.iso_country_cd
                         , '-1') || '^' || COALESCE(co.country_name, '#') || '^' || COALESCE(re.real_estate_nr, '#') ||
                   '^' || COALESCE(pc.zip, '#') || '^' || COALESCE(ct.city_name, '#') || '^' || COALESCE(sa.street_name
               , '#') || '^' || COALESCE(sa.house_nr, '#') || '^' || CAST(COALESCE(sa.latitude, - 1) AS STRING) || '^'
        || CAST(COALESCE(sa.longitude, - 1) AS STRING))) AS change_fg
   FROM szd_production_core_rel.t_real_estate_1 AS re_1
    INNER JOIN szd_production_core_rel.t_division_1 AS dv ON re.division_party_sid = dv.party_sid
    LEFT JOIN szd_production_core_rel.t_country_political_1 AS co ON re.country_location_sid = co.location_sid AND co.lang_cd
        = 'DE' AND co.dwh_valid_fg
    INNER JOIN szd_production_core_rel.t_street_address_1 AS sa ON re.street_address_location_sid = sa.location_sid AND sa
     .dwh_valid_fg
    INNER JOIN szd_production_core_rel.t_postal_code_area_1 AS pc ON sa.postal_code_area_location_sid = pc.location_sid
     AND pc.dwh_valid_fg
    INNER JOIN szd_production_core_rel.t_city_1 AS ct ON sa.city_location_sid = ct.location_sid AND ct.dwh_valid_fg
   QUALIFY (LAG(TO_HEX(MD5(CAST(COALESCE(re.division_party_sid, - 1) AS STRING) || '^' || COALESCE(dv.division_cd, '-1'
                                 ) || '^' || COALESCE(dv.division_name, '-1') || '^' || CAST(COALESCE(re.country_location_sid, - 1) AS STRING)
                             || '^' || COALESCE(co.iso_country_cd, '-1') || '^' || COALESCE(co.country_name, '#') || '^'
                        || COALESCE(re.real_estate_nr, '#') || '^' || COALESCE(pc.zip, '#') || '^' || COALESCE(ct.city_name
                   , '#') || '^' || COALESCE(sa.street_name, '#') || '^' || COALESCE(sa.house_nr, '#') || '^' || CAST(COALESCE(sa.latitude, - 1) AS STRING)
             || '^' || CAST(COALESCE(sa.longitude, - 1) AS STRING))), 1, '#') OVER (PARTITION BY re.resource_item_sid
       ORDER BY re.dwh_valid_from_tmsp IS NULL, re.dwh_valid_from_tmsp)) <> TO_HEX(MD5(CAST(COALESCE(re.division_party_sid, - 1) AS STRING)
                               || '^' || COALESCE(dv.division_cd, '-1') || '^' || COALESCE(dv.division_name, '-1') ||
                           '^' || CAST(COALESCE(re.country_location_sid, - 1) AS STRING) || '^' || COALESCE(co.iso_country_cd
                         , '-1') || '^' || COALESCE(co.country_name, '#') || '^' || COALESCE(re.real_estate_nr, '#') ||
                   '^' || COALESCE(pc.zip, '#') || '^' || COALESCE(ct.city_name, '#') || '^' || COALESCE(sa.street_name
               , '#') || '^' || COALESCE(sa.house_nr, '#') || '^' || CAST(COALESCE(sa.latitude, - 1) AS STRING) || '^'
        || CAST(COALESCE(sa.longitude, - 1) AS STRING)))) AS t0);


COMMIT TRANSACTION;