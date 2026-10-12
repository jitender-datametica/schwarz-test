INSERT INTO ldl_data_production_core_rel.t_internal_organization_hierarchy (int_org_sid, int_org_hierarchy_type_cd,
 dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, parent_int_org_sid, dwh_created_tmsp, dwh_updated_tmsp,
 dwh_load_id, dwh_node_cd)
(SELECT int_org_sid,
  int_org_hierarchy_type_cd,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  parent_int_org_sid,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_load_id,
  dwh_node_cd
 FROM (SELECT int_org_sid,
    int_org_hierarchy_type_cd,
    CAST(dwh_valid_from_tmsp AS TIMESTAMP) AS dwh_valid_from_tmsp,
    CAST(dwh_valid_to_tmsp AS TIMESTAMP) AS dwh_valid_to_tmsp,
    dwh_valid_fg,
    parent_int_org_sid,
    dwh_created_tmsp,
    dwh_updated_tmsp,
    dwh_load_id,
    dwh_node_cd
   FROM (((SELECT k_st.party_sid AS int_org_sid,
         'CNTRY_ORG_STORE' AS int_org_hierarchy_type_cd,
         PARSE_DATETIME('%F', '1900-01-01') AS dwh_valid_from_tmsp,
         '9999-12-31 23:59:59.999999999' AS dwh_valid_to_tmsp,
         TRUE AS dwh_valid_fg,
         k_cntr.party_sid AS parent_int_org_sid,
         CURRENT_TIMESTAMP() AS dwh_created_tmsp,
         CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
         - 1 AS dwh_load_id,
         'MANUAL' AS dwh_node_cd
        FROM ldl_data_production_meta.t_party_key AS k_st
         INNER JOIN ldl_data_production_meta.t_party_key AS k_cntr ON k_cntr.party_nat_key_nr = SUBSTR(k_st.party_nat_key_nr
              , 1, 2) AND k_cntr.party_key_type_cd = 'COUNTRY' AND k_cntr.dwh_valid_fg AND SUBSTR(k_st.party_nat_key_nr
            , 1, 2) NOT IN ('MT', 'LU', 'CS')
         LEFT JOIN ldl_data_production_core_rel.t_internal_organization AS io_st ON k_st.party_sid = io_st.int_org_sid
           AND io_st.int_org_type_cd = 'STORE' AND io_st.dwh_node_cd <> 'MANUAL (NKC)'
         LEFT JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy AS ioh ON k_st.party_sid = ioh.int_org_sid
             AND k_cntr.party_sid = ioh.parent_int_org_sid AND ioh.int_org_hierarchy_type_cd = 'CNTRY_ORG_STORE'
        WHERE k_st.party_key_type_cd = 'STORE'
         AND io_st.int_org_sid IS NULL
         AND ioh.int_org_sid IS NULL
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(k_st.party_sid AS STRING) ORDER BY k_st.dwh_created_tmsp IS NULL,
              k_st.dwh_created_tmsp)) = 1
        UNION DISTINCT
        SELECT k_st.party_sid AS int_org_sid,
         'CNTRY_ORG_STORE' AS int_org_hierarchy_type_cd,
         PARSE_DATETIME('%F', '1900-01-01') AS dwh_valid_from_tmsp,
         '9999-12-31 23:59:59.999999999' AS dwh_valid_to_tmsp,
         TRUE AS dwh_valid_fg,
         k_cntr.party_sid AS parent_int_org_sid,
         CURRENT_TIMESTAMP() AS dwh_created_tmsp,
         CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
         - 1 AS dwh_load_id,
         'MANUAL' AS dwh_node_cd
        FROM ldl_data_production_meta.t_party_key AS k_st
         INNER JOIN ldl_data_production_meta.t_party_key AS k_cntr ON k_cntr.party_nat_key_nr = 'BE' AND SUBSTR(k_st.party_nat_key_nr
              , 1, 2) = 'LU' AND k_cntr.party_key_type_cd = 'COUNTRY' AND k_cntr.dwh_valid_fg
         LEFT JOIN ldl_data_production_core_rel.t_internal_organization AS io_st ON k_st.party_sid = io_st.int_org_sid
           AND io_st.int_org_type_cd = 'STORE' AND io_st.dwh_node_cd <> 'MANUAL (NKC)'
         LEFT JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy AS ioh ON k_st.party_sid = ioh.int_org_sid
             AND k_cntr.party_sid = ioh.parent_int_org_sid AND ioh.int_org_hierarchy_type_cd = 'CNTRY_ORG_STORE'
        WHERE k_st.party_key_type_cd = 'STORE'
         AND io_st.int_org_sid IS NULL
         AND ioh.int_org_sid IS NULL
        QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(k_st.party_sid AS STRING) ORDER BY k_st.dwh_created_tmsp IS NULL,
              k_st.dwh_created_tmsp)) = 1)
       UNION DISTINCT
       SELECT k_st.party_sid AS int_org_sid,
        'CNTRY_ORG_STORE' AS int_org_hierarchy_type_cd,
        PARSE_DATETIME('%F', '1900-01-01') AS dwh_valid_from_tmsp,
        '9999-12-31 23:59:59.999999999' AS dwh_valid_to_tmsp,
        TRUE AS dwh_valid_fg,
        k_cntr.party_sid AS parent_int_org_sid,
        CURRENT_TIMESTAMP() AS dwh_created_tmsp,
        CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
        - 1 AS dwh_load_id,
        'MANUAL' AS dwh_node_cd
       FROM ldl_data_production_meta.t_party_key AS k_st
        INNER JOIN ldl_data_production_meta.t_party_key AS k_cntr ON k_cntr.party_nat_key_nr = 'ES' AND SUBSTR(k_st.party_nat_key_nr
             , 1, 2) = 'CS' AND k_cntr.party_key_type_cd = 'COUNTRY' AND k_cntr.dwh_valid_fg
        LEFT JOIN ldl_data_production_core_rel.t_internal_organization AS io_st ON k_st.party_sid = io_st.int_org_sid
          AND io_st.int_org_type_cd = 'STORE' AND io_st.dwh_node_cd <> 'MANUAL (NKC)'
        LEFT JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy AS ioh ON k_st.party_sid = ioh.int_org_sid
            AND k_cntr.party_sid = ioh.parent_int_org_sid AND ioh.int_org_hierarchy_type_cd = 'CNTRY_ORG_STORE'
       WHERE k_st.party_key_type_cd = 'STORE'
        AND io_st.int_org_sid IS NULL
        AND ioh.int_org_sid IS NULL
       QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(k_st.party_sid AS STRING) ORDER BY k_st.dwh_created_tmsp IS NULL,
             k_st.dwh_created_tmsp)) = 1)
      UNION DISTINCT
      SELECT k_st.party_sid AS int_org_sid,
       'CNTRY_ORG_STORE' AS int_org_hierarchy_type_cd,
       PARSE_DATETIME('%F', '1900-01-01') AS dwh_valid_from_tmsp,
       '9999-12-31 23:59:59.999999999' AS dwh_valid_to_tmsp,
       TRUE AS dwh_valid_fg,
       k_cntr.party_sid AS parent_int_org_sid,
       CURRENT_TIMESTAMP() AS dwh_created_tmsp,
       CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
       - 1 AS dwh_load_id,
       'MANUAL' AS dwh_node_cd
      FROM ldl_data_production_meta.t_party_key AS k_st
       INNER JOIN ldl_data_production_meta.t_party_key AS k_cntr ON k_cntr.party_nat_key_nr = 'MT' AND SUBSTR(k_st.party_nat_key_nr
            , 1, 2) = 'MT' AND k_cntr.party_key_type_cd = 'COUNTRY' AND k_cntr.dwh_valid_fg
       LEFT JOIN ldl_data_production_core_rel.t_internal_organization AS io_st ON k_st.party_sid = io_st.int_org_sid AND
          io_st.int_org_type_cd = 'STORE' AND io_st.dwh_node_cd <> 'MANUAL (NKC)'
       LEFT JOIN ldl_data_production_core_rel.t_internal_organization_hierarchy AS ioh ON k_st.party_sid = ioh.int_org_sid
           AND k_cntr.party_sid = ioh.parent_int_org_sid AND ioh.int_org_hierarchy_type_cd = 'CNTRY_ORG_STORE'
      WHERE k_st.party_key_type_cd = 'STORE'
       AND k_st.dwh_node_cd <> 'P_LEW_CORE'
       AND io_st.int_org_sid IS NULL
       AND ioh.int_org_sid IS NULL
      QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(k_st.party_sid AS STRING) ORDER BY k_st.dwh_created_tmsp IS NULL,
            k_st.dwh_created_tmsp)) = 1) AS t15) AS t16
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_rel.t_internal_organization_hierarchy
   WHERE int_org_hierarchy_type_cd = t16.int_org_hierarchy_type_cd
    AND int_org_sid = t16.int_org_sid
    AND dwh_valid_from_tmsp = t16.dwh_valid_from_tmsp)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY int_org_sid, int_org_hierarchy_type_cd, dwh_valid_from_tmsp)) = 1);