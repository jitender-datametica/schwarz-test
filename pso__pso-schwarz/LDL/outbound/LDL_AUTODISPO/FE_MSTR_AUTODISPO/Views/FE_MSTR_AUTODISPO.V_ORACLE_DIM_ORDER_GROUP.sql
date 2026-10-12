CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_dim_order_group (country, dog_wh, dog_name, dog_item,
dog_active, mod_date, dog_calculationmethod, dog_store, source_extraction_tmsp) AS SELECT country,
 dog_wh AS wh,
 dog_name,
 dog_item,
 dog_active,
 mod_date,
 dog_calculationmethod,
 dog_store AS store,
 source_extraction_tmsp
FROM ldl_autodispo_core.t_oracle_v_dim_order_group
QUALIFY (ROW_NUMBER() OVER (PARTITION BY country, dog_item, CAST(dog_store AS STRING) ORDER BY mod_date IS NULL DESC,
      mod_date DESC)) = 1;