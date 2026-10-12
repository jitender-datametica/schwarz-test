CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_itemgrp_abt_1 (division_id, country_id, itemgrp_abt_id,
itemgrp_abt_desc) AS SELECT DISTINCT division_id,
 country_id,
 taxonomy_id AS itemgrp_abt_id,
 taxonomy_name AS itemgrp_abt_desc
FROM smp_production_core_rel.t_taxonomy_hierarchy_1
WHERE level = 1;