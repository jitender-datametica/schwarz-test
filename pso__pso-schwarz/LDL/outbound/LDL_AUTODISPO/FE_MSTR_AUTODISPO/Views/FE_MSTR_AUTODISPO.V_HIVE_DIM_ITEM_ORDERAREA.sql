CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_hive_dim_item_orderarea (country, itemno, wh, oa, oa_desc,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_hive_order_area;