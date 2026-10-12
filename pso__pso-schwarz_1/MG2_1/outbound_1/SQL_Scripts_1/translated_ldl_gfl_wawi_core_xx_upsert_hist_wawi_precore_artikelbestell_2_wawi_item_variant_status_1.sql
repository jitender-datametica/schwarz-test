UPDATE ldl_data_production_core_rel.t_wawi_item_variant_status_1 SET
 dwh_valid_fg = CURRENT_TIMESTAMP() BETWEEN t_wawi_item_variant_status.dwh_valid_from_tmsp AND
  t_wawi_item_variant_status.dwh_valid_to_tmsp    --set to 1 or 0 
WHERE dwh_valid_fg <> (CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp); --when it is not correct


UPDATE ldl_data_production_core_rel.t_wawi_item_variant_status_1 SET
 wawi_item_variant_status_type_id = - 1
WHERE DATE(dwh_valid_from_tmsp) = DATE '1900-01-01' AND DATE(dwh_valid_from_tmsp) <> DATE '9999-12-31' 
AND COALESCE(wawi_item_variant_status_type_id, - 999) <> - 1;--if there is only one profile from 1900 to 9999-12-31, it must not be set to status_1 Unknown