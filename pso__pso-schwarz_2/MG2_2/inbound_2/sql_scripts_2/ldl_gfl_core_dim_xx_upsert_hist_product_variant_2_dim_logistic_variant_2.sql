INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  logistic_variant_sid,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  logistic_variant_nr,
  logistic_variant_name,
  logistic_variant_type_cd,
  logistic_variant_type_descr,
  prod_variant_status_cd,
  prod_variant_status_descr,
  case_size_cnt,
  weight_based_fg,
  length_meas,
  width_meas,
  height_meas,
  size_uom_cd,
  net_weight_meas,
  gross_weight_meas,
  weight_uom_cd,
  units_per_pallet_cnt,
  units_per_pallet_layer_cnt,
  pallet_type_cd,
  pallet_type_descr,
  prod_sid,
  prod_nr,
  prod_name,
  item_fam_sid,
  item_fam_nr,
  item_fam_name,
  sub_item_grp_sid,
  sub_item_grp_nr,
  sub_item_grp_name,
  int_item_grp_sid,
  int_item_grp_nr,
  int_item_grp_name,
  pillar_sid,
  pillar_nr,
  pillar_name,
  main_pillar_sid,
  main_pillar_nr,
  main_pillar_name,
  dwh_mapping_tmsp,
  dwh_load_id,
  dwh_node_cd,
  tf_error_fg,
  error_descr,
  record_id,
  filename
)
SELECT 
  pv.prod_variant_sid	AS	  logistic_variant_sid,
  pv.dwh_valid_from_tmsp AS dwh_valid_from_tmsp,
  pv.dwh_valid_to_tmsp AS dwh_valid_to_tmsp,
  pv.dwh_valid_fg AS dwh_valid_fg,
  SUBSTRING(prod_variant_nr, 1, 20)	AS	  logistic_variant_nr,
  pv.prod_variant_name	AS	  logistic_variant_name,
  COALESCE(pv.logistic_variant_type_cd, '@')	AS	  logistic_variant_type_cd,
  COALESCE(lvt.logistic_variant_type_descr, 'Unbekannt')	AS	  logistic_variant_type_descr,
  '@'	AS	  prod_variant_status_cd,
  'Unbekannt'	AS	  prod_variant_status_descr,
  COALESCE(pv.case_size_cnt, 1)	AS	  case_size_cnt,
  COALESCE(weight_based_fg, False)	AS	  weight_based_fg,
  lvs.length_meas	AS	  length_meas,
  lvs.width_meas	AS	  width_meas,
  lvs.height_meas	AS	  height_meas,
  COALESCE(size_uom_cd, '@')	AS	  size_uom_cd,
  lvs.net_weight_meas	AS	  net_weight_meas,
  lvs.gross_weight_meas	AS	  gross_weight_meas,
  COALESCE(weight_uom_cd, '@')	AS	  weight_uom_cd,
  lvs.units_per_pallet_cnt	AS	  units_per_pallet_cnt,
  lvs.units_per_pallet_layer_cnt	AS	  units_per_pallet_layer_cnt,
  COALESCE(lvs.pallet_type_cd, '@')	AS	  pallet_type_cd,
  COALESCE(pt.pallet_type_descr, 'Unbekannt')	AS	  pallet_type_descr,
  COALESCE(pv.prod_sid, -1)	AS	  prod_sid,
  COALESCE(p.prod_nr, '@')	AS	  prod_nr,
  COALESCE(p.prod_name, 'Unbekannt')	AS	  prod_name,
  COALESCE(ifg.prod_grp_sid, -1)	AS	  item_fam_sid,
  COALESCE(ifg.prod_grp_nr, '@')	AS	  item_fam_nr,
  COALESCE(ifg.prod_grp_name, 'Unbekannt')	AS	  item_fam_name,
  COALESCE(sig.prod_grp_sid, -1)	AS	  sub_item_grp_sid,
  COALESCE(sig.prod_grp_nr, '@')	AS	  sub_item_grp_nr,
  COALESCE(sig.prod_grp_name, 'Unbekannt')	AS	  sub_item_grp_name,
  COALESCE(igi.prod_grp_sid, -1)	AS	  int_item_grp_sid,
  COALESCE(igi.prod_grp_nr, '@')	AS	  int_item_grp_nr,
  COALESCE(igi.prod_grp_name, 'Unbekannt')	AS	  int_item_grp_name,
  COALESCE(pil.prod_grp_sid, -1)	AS	  pillar_sid,
  COALESCE(pil.prod_grp_nr, '@')	AS	  pillar_nr,
  COALESCE(pil.prod_grp_name, 'Unbekannt')	AS	  pillar_name,
  COALESCE(mpil.prod_grp_sid, -1)	AS	  main_pillar_sid,
  COALESCE(mpil.prod_grp_nr, '@')	AS	  main_pillar_nr,
  COALESCE(mpil.prod_grp_name, 'Unbekannt')	AS	  main_pillar_name,
  pv.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  ${LOAD_ID} dwh_load_id,
  'CORE_REL' dwh_node_cd,
  0 tf_error_fg,
  '' error_descr,
  0 record_id,
  'core_rel' filename
FROM core_rel.t_product_variant_2 AS pv
LEFT OUTER JOIN core_rel.t_logistic_variant_type_2 AS lvt
    ON  pv.logistic_variant_type_cd = lvt.logistic_variant_type_cd
    AND lvt.lang_cd = 'DE'
LEFT OUTER JOIN core_rel.t_logistic_variant_size_2 AS lvs
    ON  pv.prod_variant_sid = lvs.prod_variant_sid
    AND lvs.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_pallet_type_2 AS pt
    ON  lvs.pallet_type_cd = pt.pallet_type_cd
    AND pt.lang_cd = 'DE'
LEFT OUTER JOIN core_rel.t_product_2 AS p
    ON  pv.prod_sid = p.prod_sid
    AND p.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_to_product_group_2 AS pifg
    ON  p.prod_sid = pifg.prod_sid
    AND pifg.prod_grp_type_cd = 'IFG'
    AND pifg.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_2 AS ifg
    ON  pifg.prod_grp_sid = ifg.prod_grp_sid
    AND ifg.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS ifgh
    ON  ifg.prod_grp_sid = ifgh.prod_grp_sid
    AND ifgh.prod_grp_hierarchy_type_cd = 'IGH'
    AND ifgh.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_2 AS sig
    ON  ifgh.parent_prod_grp_sid = sig.prod_grp_sid
    AND sig.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS sigh
    ON  ifgh.parent_prod_grp_sid = sigh.prod_grp_sid
    AND sigh.prod_grp_hierarchy_type_cd = 'IGH'
    AND sigh.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_2 AS igi
    ON  sigh.parent_prod_grp_sid = igi.prod_grp_sid
    AND igi.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_to_product_group_2 AS ppil
    ON  p.prod_sid = ppil.prod_sid
    AND ppil.prod_grp_type_cd = 'P'
    AND ppil.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_2 AS pil
    ON  ppil.prod_grp_sid = pil.prod_grp_sid
    AND pil.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_hierarchy_2 AS pilh
    ON  pil.prod_grp_sid = pilh.prod_grp_sid
    AND pilh.prod_grp_hierarchy_type_cd = 'PH'
    AND pilh.dwh_valid_fg = True
LEFT OUTER JOIN core_rel.t_product_group_2 AS mpil
    ON  pilh.parent_prod_grp_sid = mpil.prod_grp_sid
    AND mpil.dwh_valid_fg = True
WHERE pv.prod_variant_type_cd = 'LOGISTIC' AND pv.dwh_valid_fg = True
;
