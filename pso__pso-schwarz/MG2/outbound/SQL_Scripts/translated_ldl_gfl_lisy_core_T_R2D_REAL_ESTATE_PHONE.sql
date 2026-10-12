TRUNCATE TABLE ldl_data_production_etl.t_r2d_real_estate_phone;


INSERT INTO ldl_data_production_etl.t_r2d_real_estate_phone (real_estate_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 phone_nr)
WITH re_phone AS (SELECT re.real_estate_sid,
    GREATEST(re.dwh_valid_from_tmsp, rea.dwh_valid_from_tmsp, tn.dwh_valid_from_tmsp) AS val_from,
    LEAST(re.dwh_valid_to_tmsp, rea.dwh_valid_to_tmsp, tn.dwh_valid_to_tmsp) AS val_to,
    tn.phone_nr,
    LAG(tn.phone_nr) OVER (PARTITION BY CAST(re.real_estate_sid AS STRING) ORDER BY GREATEST(re.dwh_valid_from_tmsp, rea
        .dwh_valid_from_tmsp, tn.dwh_valid_from_tmsp) IS NULL, GREATEST(re.dwh_valid_from_tmsp, rea.dwh_valid_from_tmsp
        , tn.dwh_valid_from_tmsp)) AS prev_phone_nr,
     CASE
     WHEN (LAG(tn.phone_nr) OVER (PARTITION BY CAST(re.real_estate_sid AS STRING) ORDER BY GREATEST(re.dwh_valid_from_tmsp
           , rea.dwh_valid_from_tmsp, tn.dwh_valid_from_tmsp) IS NULL, GREATEST(re.dwh_valid_from_tmsp, rea.dwh_valid_from_tmsp
           , tn.dwh_valid_from_tmsp))) = tn.phone_nr
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_real_estate AS re
    INNER JOIN ldl_data_production_core_rel.t_real_estate_address AS rea ON re.real_estate_sid = rea.real_estate_sid AND
         rea.addr_type_cd = 'TEL' AND rea.addr_usg_type_cd = 'TL_MN' AND re.dwh_valid_to_tmsp >= rea.dwh_valid_from_tmsp
        AND re.dwh_valid_from_tmsp <= rea.dwh_valid_to_tmsp
    INNER JOIN ldl_data_production_core_rel.t_telephone_number AS tn ON rea.addr_sid = tn.phone_nr_sid AND tn.dwh_valid_from_tmsp
        <= LEAST(re.dwh_valid_to_tmsp, rea.dwh_valid_to_tmsp) AND tn.dwh_valid_to_tmsp >= GREATEST(re.dwh_valid_from_tmsp
       , rea.dwh_valid_from_tmsp)), re_phone_with_groups AS (SELECT real_estate_sid,
    val_from,
    val_to,
    phone_nr,
    prev_phone_nr,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(real_estate_sid AS STRING) ORDER BY val_from IS NULL, val_from,
       has_change_fg IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS group_id
   FROM re_phone AS t0) (SELECT real_estate_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    phone_nr
   FROM re_phone_with_groups
   GROUP BY real_estate_sid,
    phone_nr,
    group_id);