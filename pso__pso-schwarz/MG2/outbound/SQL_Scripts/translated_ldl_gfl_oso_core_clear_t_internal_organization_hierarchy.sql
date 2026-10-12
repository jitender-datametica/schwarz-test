/* remove OLD records which commes from NOT OSO */
 


DELETE FROM ldl_data_production_core_rel.t_internal_organization_hierarchy
WHERE (int_org_sid, int_org_hierarchy_type_cd) IN (SELECT (int_org_sid, int_org_hierarchy_type_cd)
    FROM ldl_data_production_etl.t_tcache_oso_internal_organization_hierarchy) AND dwh_node_cd <> 'LISY' AND dwh_node_cd
   <> 'OSO';