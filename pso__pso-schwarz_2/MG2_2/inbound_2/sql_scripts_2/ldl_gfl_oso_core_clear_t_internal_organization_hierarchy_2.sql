/* remove OLD records which commes from NOT OSO */
 delete
   from core_rel.t_internal_organization_hierarchy_2  
  where (INT_ORG_SID, INT_ORG_HIERARCHY_TYPE_CD) in 
(select INT_ORG_SID, INT_ORG_HIERARCHY_TYPE_CD 
   from ETL.T_TCACHE_OSO_INTERNAL_ORGANIZATION_HIERARCHY_2)
    and DWH_NODE_CD <> 'OSO' 
    and DWH_NODE_CD <> 'LISY'
;
