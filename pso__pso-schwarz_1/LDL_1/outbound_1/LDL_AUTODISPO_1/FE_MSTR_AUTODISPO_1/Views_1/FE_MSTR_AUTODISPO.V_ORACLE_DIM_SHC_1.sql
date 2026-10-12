-- LDL_AUTODISPO_DEVELOPMENT.FE_MSTR_AUTODISPO.V_ORACLE_DIM_SHC_1 source


CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_shc_1 AS SELECT sh_qty_correction_value,
 mod_date,
 country_1,
 sh_qty_wawi,
 sh_qty_correction_percentage,
 sh_aoc_shc_unit_id,
 sh_wawi_shc_unit_id,
 sh_item_nr,
 sh_store_nr,
 sh_qty_aoc,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp,
  CASE
  WHEN COALESCE(sh_qty_aoc, - 1) <> - 1
  THEN sh_aoc_shc_unit_id
  ELSE sh_wawi_shc_unit_id
  END AS sh_unit_id,
 COALESCE(sh_qty_aoc, sh_qty_wawi) AS sh_quantity
FROM ldl_autodispo_core.t_oracle_v_dim_shc_1;