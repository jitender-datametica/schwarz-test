TRUNCATE TABLE ldl_data_production_core_dim.t_dim_internal_organization_status_type_2;


INSERT INTO ldl_data_production_core_dim.t_dim_internal_organization_status_type_2 (int_org_status_cd,
 int_org_status_descr, int_org_status_descr_de, int_org_status_descr_en, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id
 , dwh_node_cd)
VALUES ('@', 'Unbekannt', 'Unbekannt', 'Unknown', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), - 1, 'MANUAL');


INSERT INTO ldl_data_production_core_dim.t_dim_internal_organization_status_type_2 (int_org_status_cd,
 int_org_status_descr, int_org_status_descr_de, int_org_status_descr_en, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id
 , dwh_node_cd)
(SELECT int_org_status_cd,
  int_org_status_descr,
  int_org_status_descr_de,
  int_org_status_descr_en,
  dwh_created_tmsp,
  dwh_created_tmsp5,
  dwh_load_id,
  dwh_node_cd
 FROM (SELECT party_status_type_cd AS int_org_status_cd,
    MAX(CASE
      WHEN lang_cd = 'DE'
      THEN party_status_type_descr
      ELSE NULL
      END) AS int_org_status_descr,
    MAX(CASE
      WHEN lang_cd = 'DE'
      THEN party_status_type_descr
      ELSE NULL
      END) AS int_org_status_descr_de,
    MAX(CASE
      WHEN lang_cd = 'EN'
      THEN party_status_type_descr
      ELSE NULL
      END) AS int_org_status_descr_en,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp5,
    - 1 AS dwh_load_id,
    'P_LEW_CORE' AS dwh_node_cd
   FROM ldl_data_production_core_rel.t_party_status_type_2
   GROUP BY int_org_status_cd) AS t1_2
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_dim.t_dim_internal_organization_status_type_2
   WHERE int_org_status_cd = t1.int_org_status_cd)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY int_org_status_cd)) = 1);