TRUNCATE TABLE ldl_data_production_etl.t_r2d_internal_organization_status;


INSERT INTO ldl_data_production_etl.t_r2d_internal_organization_status (int_org_sid, dwh_valid_from_tmsp,
 dwh_valid_to_tmsp, int_org_status_cd, int_org_status_descr_de)
WITH party_status AS (SELECT io.int_org_sid,
    GREATEST(io.dwh_valid_from_tmsp, ps.dwh_valid_from_tmsp) AS val_from,
    LEAST(io.dwh_valid_to_tmsp, ps.dwh_valid_to_tmsp) AS val_to,
    pst_de.party_status_type_cd AS int_org_status_cd,
    pst_de.party_status_type_descr AS int_org_status_descr_de,
    LEAD(pst_de.party_status_type_cd) OVER (PARTITION BY CAST(io.int_org_sid AS STRING), io.dwh_valid_to_tmsp ORDER BY
       GREATEST(io.dwh_valid_from_tmsp, ps.dwh_valid_from_tmsp) IS NULL, GREATEST(io.dwh_valid_from_tmsp, ps.dwh_valid_from_tmsp
        )) AS prev_int_org_status_cd,
     CASE
     WHEN (LEAD(pst_de.party_status_type_cd) OVER (PARTITION BY CAST(io.int_org_sid AS STRING), io.dwh_valid_to_tmsp
        ORDER BY GREATEST(io.dwh_valid_from_tmsp, ps.dwh_valid_from_tmsp) IS NULL, GREATEST(io.dwh_valid_from_tmsp, ps.dwh_valid_from_tmsp
           ))) = pst_de.party_status_type_cd
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_internal_organization AS io
    INNER JOIN ldl_data_production_core_rel.t_party_status AS ps ON io.int_org_sid = ps.party_sid AND ps.party_type_cd =
        'INT_ORG' AND io.dwh_valid_to_tmsp >= ps.dwh_valid_from_tmsp AND io.dwh_valid_from_tmsp <= ps.dwh_valid_to_tmsp
    INNER JOIN ldl_data_production_core_rel.t_party_status_type AS pst_de ON ps.party_status_type_cd = pst_de.party_status_type_cd
       AND pst_de.lang_cd = 'DE'), ps_with_groups AS (SELECT int_org_sid,
    val_from,
    val_to,
    int_org_status_cd,
    int_org_status_descr_de,
    prev_int_org_status_cd,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(int_org_sid AS STRING) ORDER BY val_from IS NULL, val_from, has_change_fg
       IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM party_status AS ps) (SELECT int_org_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    int_org_status_cd,
    int_org_status_descr_de
   FROM ps_with_groups
   GROUP BY int_org_sid,
    int_org_status_cd,
    int_org_status_descr_de,
    group_id);