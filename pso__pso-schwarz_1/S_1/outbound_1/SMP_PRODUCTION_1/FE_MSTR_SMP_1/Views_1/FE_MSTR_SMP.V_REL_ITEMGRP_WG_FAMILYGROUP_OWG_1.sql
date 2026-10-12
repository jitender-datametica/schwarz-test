CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_rel_itemgrp_wg_familygroup_owg_1 (division_id, country_id,
subitemgrp_hwg, familygrp_owg) AS SELECT T1.division_id,
 T1.country_id,
 T1.taxonomy_id AS subitemgrp_hwg,
 T2.taxonomy_id AS familygrp_owg
FROM smp_production_core_rel.t_taxonomy_hierarchy_1 AS T1_1
 INNER JOIN smp_production_core_rel.t_taxonomy_hierarchy_1 AS T2 ON T1.country_id = T2.country_id AND T1.division_id = T2
    .division_id AND T1.taxonomy_id = T2.taxonomy_parent_id
WHERE T1.level = 2
 AND T2.level = 3;