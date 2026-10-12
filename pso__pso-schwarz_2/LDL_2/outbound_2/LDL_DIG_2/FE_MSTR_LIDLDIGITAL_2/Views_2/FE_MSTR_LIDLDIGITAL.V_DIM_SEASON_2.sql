CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_season_2 (season_nr, season_start_mon_dt_nr, season_end_mon_dt_nr
, season_name) AS SELECT season_nr,
 season_start_mon_dt_nr,
 season_end_mon_dt_nr,
 season_name
FROM ldl_dig_lec_share.v_dim_season_2
UNION ALL
SELECT '-1',
 ROUND(CAST('1' AS BIGNUMERIC), 0),
 ROUND(CAST('1' AS BIGNUMERIC), 0),
 '';