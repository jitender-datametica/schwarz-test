CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_item_familygroup_owg_1 (division_id, country_id,
itemfamilygrp_owg_id, itemfamilygrp_owg_desc) AS SELECT DISTINCT division_id,
 country_id,
 taxonomy_id AS itemfamilygrp_owg_id,
 taxonomy_name AS itemfamilygrp_owg_desc
FROM smp_production_core_rel.t_taxonomy_hierarchy_1
WHERE level = 3;