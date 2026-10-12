INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  igl_isocode2,
  address1_city,
  igl_ortsteil,
  address1_postalcode,
  street_addr_nk,
  street_addr_key_type_cd,
  country_key_type_cd,
  iso_country_cd,
  country_name,
  city_key_type_cd,
  city_name,
  district_nk,
  district_key_type_cd,
  district_name,
  postal_cd_area_key_type_cd,
  zip,
  street_name,
  house_nr,
  reporting_country_key_type_cd,
  reporting_country_cd,
  lon,
  lat,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT
    src.igl_isocode2 AS igl_isocode2,
    src.address1_city AS address1_city,
    src.igl_ortsteil AS igl_ortsteil,
    src.address1_postalcode AS address1_postalcode,
    CONCAT(
      COALESCE(src.igl_isocode2, ''),
      '|',
      COALESCE(src.address1_city, ''),
      '|',
      COALESCE(src.igl_ortsteil, ''),
      '|',
      COALESCE(src.address1_postalcode, ''),
      '|',
      COALESCE(src.address1_line1, ''),
      '|',
      COALESCE(src.address1_line2, ''),
      '|',
      CAST(COALESCE(src.address1_longitude, numeric '0') AS string),
      '|',
      CAST(COALESCE(src.address1_latitude, numeric '0') AS string)
    ) AS street_addr_nk,
    'STAD' AS street_addr_key_type_cd,
    'CTRY' AS country_key_type_cd,
    CASE
      WHEN src.igl_isocode2 = 'NI' THEN 'GB'
      ELSE src.igl_isocode2
    END AS iso_country_cd,
    CASE
      WHEN src.igl_isocode2 = 'NI' THEN 'Vereinigtes Königreich'
      ELSE ctry.country_name
    END AS country_name,
    'CITY' AS city_key_type_cd,
    src.address1_city AS city_name,
    CASE
      WHEN src.igl_ortsteil IS NOT NULL THEN CONCAT(
             COALESCE(src.igl_isocode2, ''),
             '|',
             COALESCE(src.address1_city, ''),
             '|',
             COALESCE(src.igl_ortsteil, '')
           )
      ELSE NULL
    END AS district_nk,
    'DSTR' AS district_key_type_cd,
    src.igl_ortsteil AS district_name,
    'ZIP' AS postal_cd_area_key_type_cd,
    src.address1_postalcode AS zip,
    src.address1_line1 AS street_name,
    src.address1_line2 AS house_nr,
    'REP_CTRY' AS reporting_country_key_type_cd,
    src.igl_isocode2 AS reporting_country_cd,
    src.address1_longitude AS lon,
    src.address1_latitude AS lat,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    CURRENT_DATE() AS dwh_mapping_tmsp,
    numeric '0' AS tf_error_fg,
    numeric '0' AS deleted_fg,
    numeric '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM
  etl_process.t_${src_input_table} AS src
  LEFT OUTER JOIN core_rel.t_country AS ctry
    ON src.igl_isocode2 = ctry.iso_country_cd
WHERE src.igl_isocode2 IS NOT NULL
  AND src.address1_city IS NOT NULL
  AND deleted <> 'x'
-- "Grossebersdorf" is same as "Großebersdorf" when converted to UPPER
-- so we eliminate such duplicates of NK by taking the longer ( "ss" instead of "ß")
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY CONCAT(
                 reporting_country_cd,
                 '|',
                 UPPER(COALESCE(city_name, '')),
                 '|',
                 UPPER(COALESCE(district_name, '')),
                 '|',
                 UPPER(COALESCE(zip, '')),
                 '|',
                 UPPER(COALESCE(street_name, '')),
                 '|',
                 UPPER(COALESCE(house_nr, '')),
                 '|',
                 CAST(COALESCE(lon, record_id) AS string),
                 '|',
                 CAST(COALESCE(lat, record_id) AS string)
               )
  ORDER BY IF(
           LENGTH(
             CONCAT(
               reporting_country_cd,
               '|',
               UPPER(COALESCE(city_name, '')),
               '|',
               UPPER(COALESCE(district_name, '')),
               '|',
               UPPER(COALESCE(zip, '')),
               '|',
               UPPER(COALESCE(street_name, '')),
               '|',
               UPPER(COALESCE(house_nr, '')),
               '|',
               CAST(COALESCE(lon, record_id) AS string),
               '|',
               CAST(COALESCE(lat, record_id) AS string)
             )
           ) IS NULL,
           0,
           1
         ) DESC,
         CAST(
           LENGTH(
             CONCAT(
               reporting_country_cd,
               '|',
               UPPER(COALESCE(city_name, '')),
               '|',
               UPPER(COALESCE(district_name, '')),
               '|',
               UPPER(COALESCE(zip, '')),
               '|',
               UPPER(COALESCE(street_name, '')),
               '|',
               UPPER(COALESCE(house_nr, '')),
               '|',
               CAST(COALESCE(lon, record_id) AS string),
               '|',
               CAST(COALESCE(lat, record_id) AS string)
             )
           ) AS bignumeric
         ),
         IF(sinkmodifiedon IS NULL, 0, 1),
         sinkmodifiedon DESC
) = numeric '1'
;
