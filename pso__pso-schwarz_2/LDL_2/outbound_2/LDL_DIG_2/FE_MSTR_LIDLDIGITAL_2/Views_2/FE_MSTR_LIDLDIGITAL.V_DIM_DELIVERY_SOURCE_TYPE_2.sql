CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_delivery_source_type_2 (delivery_src_type_cd,
delivery_src_type_descr, delivery_src_type_grp, delivery_src_type_descr_dbr) AS SELECT delivery_src_type_cd,
 delivery_src_type_descr,
 delivery_src_type_descr AS delivery_src_type_grp,
  CASE
  WHEN delivery_src_type_cd = 'DIG'
  THEN 'Sonst'
  WHEN delivery_src_type_cd = 'LAG'
  THEN 'Lager'
  WHEN delivery_src_type_cd = 'STR'
  THEN 'Strecke'
  WHEN delivery_src_type_cd = 'Sonst'
  THEN 'Sonst'
  ELSE '-1'
  END AS delivery_src_type_descr_dbr
FROM ldl_dig_lec_share.v_dim_delivery_source_type_2
UNION ALL
SELECT '-1',
 '',
 '',
 'Sonst';