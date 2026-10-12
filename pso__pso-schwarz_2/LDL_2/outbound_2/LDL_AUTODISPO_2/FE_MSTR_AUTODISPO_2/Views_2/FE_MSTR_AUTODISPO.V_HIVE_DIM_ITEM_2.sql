CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_hive_dim_item_2 (country_2, itemno, itemdesc, itemgroupno,
itemgroupdesc, subgroupno, subgroupdesc, familyno, familydesc, tax_rate, is_weighted, is_sale_withdrawn,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS SELECT *
FROM ldl_autodispo_core.t_hive_item_2
QUALIFY snflk_insert_tmsp = (MAX(snflk_insert_tmsp) OVER (PARTITION BY country_2, itemno RANGE BETWEEN UNBOUNDED PRECEDING
    AND UNBOUNDED FOLLOWING));