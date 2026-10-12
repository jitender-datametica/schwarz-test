CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_area_new_2 (dic_area_id, dic_active, mod_date,
dic_area_nr, dic_area_wh, country_2, dic_area_name, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS
SELECT *
FROM ldl_autodispo_core.t_oracle_v_dic_area_new_2
UNION ALL
SELECT DA.dic_area_id,
 DA.dic_active,
 DA.mod_date,
 DA.dic_area_nr,
 W.ware_id AS dic_area_wh,
 DA.country_2,
 DA.dic_area_name,
 DA.source_extraction_tmsp,
 DA.snflk_insert_tmsp,
 DA.snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_dic_area_2 AS DA
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_warehouse_2 AS W ON DA.country_2 = W.country_2
WHERE DA.country_2 NOT IN (SELECT DISTINCT country_2
   FROM ldl_autodispo_core.t_oracle_v_dic_area_new_2);