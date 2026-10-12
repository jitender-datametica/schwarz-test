CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_dim_subitemgrp_hwg_1 (division_id, country_id, subitemgrp_hwg_id,
subitemgrp_hwg_desc) AS SELECT DISTINCT division_id,
 country_id,
 taxonomy_id AS subitemgrp_hwg_id,
 taxonomy_name AS subitemgrp_hwg_desc
FROM smp_production_core_rel.t_taxonomy_hierarchy_1
WHERE level = 2;