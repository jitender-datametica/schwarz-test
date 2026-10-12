CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_rel_wg_itemfamily_owg (division_id, country_id, wg, familygrp_owg)
AS SELECT T1.division_id,
 T1.country_id,
 T2.taxonomy_id AS wg,
 T1.taxonomy_id AS familygrp_owg
FROM smp_production_core_rel.t_taxonomy_hierarchy AS T1
 INNER JOIN smp_production_core_rel.t_taxonomy_hierarchy AS T2 ON T1.country_id = T2.country_id AND T1.division_id = T2
    .division_id AND T1.taxonomy_id = T2.taxonomy_parent_id
WHERE T1.level IN (3, 4)
UNION ALL
SELECT division_id,
 country_id,
 CAST(NULL AS STRING) AS wg,
 taxonomy_id AS familygrp_owg
FROM smp_production_core_rel.t_taxonomy_hierarchy AS T1
WHERE level IN (3)
 AND division_id = 'LDL';