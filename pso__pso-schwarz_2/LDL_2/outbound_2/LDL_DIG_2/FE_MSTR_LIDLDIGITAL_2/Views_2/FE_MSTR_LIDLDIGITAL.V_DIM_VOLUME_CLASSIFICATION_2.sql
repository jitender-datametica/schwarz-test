CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_volume_classification_2 (volume_class_cd, volume_class_descr) AS
SELECT volume_class_cd,
 volume_class_descr
FROM ldl_dig_lec_share.v_dim_volume_classification_2
UNION ALL
SELECT '-1',
 '';