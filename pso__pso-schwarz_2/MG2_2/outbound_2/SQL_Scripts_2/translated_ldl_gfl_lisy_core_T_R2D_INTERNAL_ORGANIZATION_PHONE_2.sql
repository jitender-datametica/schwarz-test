TRUNCATE TABLE ldl_data_production_etl.t_r2d_internal_organization_phone_2;


INSERT INTO ldl_data_production_etl.t_r2d_internal_organization_phone_2 (int_org_sid, dwh_valid_from_tmsp,
 dwh_valid_to_tmsp, phone_nr)
WITH int_org_phone AS (SELECT io.int_org_sid,
    GREATEST(io.dwh_valid_from_tmsp, pa.dwh_valid_from_tmsp, tn.dwh_valid_from_tmsp) AS val_from,
    LEAST(io.dwh_valid_to_tmsp, pa.dwh_valid_to_tmsp, tn.dwh_valid_to_tmsp) AS val_to,
    tn.phone_nr,
    LAG(tn.phone_nr) OVER (PARTITION BY CAST(io.int_org_sid AS STRING) ORDER BY GREATEST(io.dwh_valid_from_tmsp, pa.dwh_valid_from_tmsp
        , tn.dwh_valid_from_tmsp) IS NULL, GREATEST(io.dwh_valid_from_tmsp, pa.dwh_valid_from_tmsp, tn.dwh_valid_from_tmsp
        )) AS prev_phone_nr,
     CASE
     WHEN (LAG(tn.phone_nr) OVER (PARTITION BY CAST(io.int_org_sid AS STRING) ORDER BY GREATEST(io.dwh_valid_from_tmsp,
           pa.dwh_valid_from_tmsp, tn.dwh_valid_from_tmsp) IS NULL, GREATEST(io.dwh_valid_from_tmsp, pa.dwh_valid_from_tmsp
           , tn.dwh_valid_from_tmsp))) = tn.phone_nr
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_internal_organization_2 AS io
    INNER JOIN ldl_data_production_core_rel.t_party_address_2 AS pa ON io.int_org_sid = pa.party_sid AND pa.addr_type_cd =
         'TEL' AND pa.addr_usg_type_cd = 'TL_MN' AND io.dwh_valid_to_tmsp >= pa.dwh_valid_from_tmsp AND io.dwh_valid_from_tmsp
       <= pa.dwh_valid_to_tmsp
    INNER JOIN ldl_data_production_core_rel.t_telephone_number_2 AS tn ON pa.addr_sid = tn.phone_nr_sid AND tn.dwh_valid_from_tmsp
        <= LEAST(io.dwh_valid_to_tmsp, pa.dwh_valid_to_tmsp) AND tn.dwh_valid_to_tmsp >= GREATEST(io.dwh_valid_from_tmsp
       , pa.dwh_valid_from_tmsp)), io_phone_with_groups AS (SELECT int_org_sid,
    val_from,
    val_to,
    phone_nr,
    prev_phone_nr,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(int_org_sid AS STRING) ORDER BY val_from IS NULL, val_from, has_change_fg
       IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM int_org_phone AS io_phone) (SELECT int_org_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    phone_nr
   FROM io_phone_with_groups
   GROUP BY int_org_sid,
    phone_nr,
    group_id);