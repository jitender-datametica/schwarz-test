CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_distribution_channel_1 (dist_channel_cd, dist_channel_type_cd,
dist_country_cd) AS SELECT dist_channel_cd,
 dist_channel_type_cd,
 dist_country_cd
FROM ldl_dig_lec_share.v_dim_distribution_channel_1
UNION ALL
SELECT '-1',
 '-1',
 '-1';