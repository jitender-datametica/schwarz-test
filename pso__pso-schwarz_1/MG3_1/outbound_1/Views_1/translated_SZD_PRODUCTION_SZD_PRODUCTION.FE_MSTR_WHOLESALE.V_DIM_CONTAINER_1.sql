CREATE OR REPLACE VIEW szd_production_fe_mstr_wholesale.v_dim_container_1 (container_resource_sid, dwh_valid_to_tmsp,
dwh_valid_fg, dwh_valid_from_tmsp, container_status_cd, container_id, container_nr, seal_nr, is_spare_units_fg,
is_spare_parts_fg, is_gas_filled_fg, container_iso_type_cd, teu_qty, consolidated_lot_nr, consolidated_lot_nr_cnt,
dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, dwh_src_tmsp) AS SELECT resource_item_sid AS
 container_resource_sid,
 dwh_valid_to_tmsp,
  CASE
  WHEN dwh_valid_fg IS NOT NULL
  THEN CASE
   WHEN dwh_valid_fg
   THEN 1
   ELSE 0
   END
  ELSE NULL
  END AS dwh_valid_fg,
 dwh_valid_from_tmsp,
 container_status_cd,
 container_id,
 container_nr,
 seal_nr,
 spare_units_fg AS is_spare_units_fg,
 spare_parts_fg AS is_spare_parts_fg,
 gas_filled_fg AS is_gas_filled_fg,
 container_iso_type_cd,
 teu_qty,
 lot_numbers_in_container_txt AS consolidated_lot_nr,
 lot_numbers_in_container_cnt AS consolidated_lot_nr_cnt,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_file_name,
 dwh_src_1_tmsp AS dwh_src_tmsp
FROM szd_production_core.t_dim_container_1
WHERE dwh_valid_fg
 AND container_status_cd = 'A'
UNION ALL
SELECT -1,
 CAST(NULL AS TIMESTAMP),
 1,
 CAST(NULL AS TIMESTAMP),
 '-1',
 '-1',
 '-1',
 '-1',
 CAST(NULL AS BOOL),
 CAST(NULL AS BOOL),
 CAST(NULL AS BOOL),
 '-1',
 CAST(NULL AS BIGNUMERIC),
 SUBSTR(CAST(NULL AS STRING), 1, 1000),
 CAST(NULL AS BIGNUMERIC),
 CAST(NULL AS TIMESTAMP),
 CAST(NULL AS TIMESTAMP),
 SUBSTR(CAST(NULL AS STRING), 1, 500),
 CAST(NULL AS TIMESTAMP);