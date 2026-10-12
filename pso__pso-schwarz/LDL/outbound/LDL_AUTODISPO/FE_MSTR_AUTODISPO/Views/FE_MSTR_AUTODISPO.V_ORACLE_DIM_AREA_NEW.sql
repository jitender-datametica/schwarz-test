CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_area_new (dic_area_id, dic_active, mod_date,
dic_area_nr, dic_area_wh, country, dic_area_name, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS
SELECT *
FROM ldl_autodispo_core.t_oracle_v_dic_area_new
UNION ALL
SELECT DA.dic_area_id,
 DA.dic_active,
 DA.mod_date,
 DA.dic_area_nr,
 W.ware_id AS dic_area_wh,
 DA.country,
 DA.dic_area_name,
 DA.source_extraction_tmsp,
 DA.snflk_insert_tmsp,
 DA.snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_dic_area AS DA
 INNER JOIN ldl_autodispo_core.t_oracle_v_dim_warehouse AS W ON DA.country = W.country
WHERE DA.country NOT IN (SELECT DISTINCT country
   FROM ldl_autodispo_core.t_oracle_v_dic_area_new);