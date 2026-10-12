CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_item_bkp_2 (division_id, country_id, gtin_id, gtin_name,
article_id) AS SELECT division_id,
 country_id,
 gtin_id,
 gtin_name,
 article_id_ref AS article_id
FROM smp_production_core_rel.t_gtin_2 AS GTIN;