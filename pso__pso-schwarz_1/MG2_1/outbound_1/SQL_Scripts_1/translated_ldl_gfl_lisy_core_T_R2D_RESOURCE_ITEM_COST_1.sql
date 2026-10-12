TRUNCATE TABLE ldl_data_production_etl.t_r2d_resource_item_cost_1;


INSERT INTO ldl_data_production_etl.t_r2d_resource_item_cost_1 (real_estate_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 cost_type_cd, resource_item_type_cd, curr_cd, cost_val, cost_eur_val)
WITH re_cost AS (SELECT re.real_estate_sid,
    GREATEST(re.dwh_valid_from_tmsp, ric.dwh_valid_from_tmsp, exr.dwh_valid_from_tmsp) AS val_from,
    LEAST(re.dwh_valid_to_tmsp, ric.dwh_valid_to_tmsp, exr.dwh_valid_to_tmsp) AS val_to,
    ric.cost_type_cd,
    ric.resource_item_type_cd,
    ric.curr_cd,
    ric.cost_val,
     ric.cost_val * exr.exchange_rate AS cost_eur_val,
    TO_HEX(CAST(SHA256(IFNULL(CAST(ric.cost_val AS STRING), CAST(- 1 AS STRING)) || '#&#' || IFNULL(CAST(exr.exchange_rate AS STRING)
         , CAST(- 1 AS STRING))) AS BYTES)) AS row_hash_for_diff,
    LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(ric.cost_val AS STRING), CAST(- 1 AS STRING)) || '#&#' || IFNULL(CAST(exr.exchange_rate AS STRING)
          , CAST(- 1 AS STRING))) AS BYTES))) OVER (PARTITION BY CAST(re.real_estate_sid AS STRING), ric.cost_type_cd
     ORDER BY GREATEST(re.dwh_valid_from_tmsp, ric.dwh_valid_from_tmsp, exr.dwh_valid_from_tmsp) IS NULL, GREATEST(re.dwh_valid_from_tmsp
        , ric.dwh_valid_from_tmsp, exr.dwh_valid_from_tmsp)) AS prev_row_hash_for_diff,
     CASE
     WHEN TO_HEX(CAST(SHA256(IFNULL(CAST(ric.cost_val AS STRING), CAST(- 1 AS STRING)) || '#&#' || IFNULL(CAST(exr.exchange_rate AS STRING)
           , CAST(- 1 AS STRING))) AS BYTES)) = (LAG(TO_HEX(CAST(SHA256(IFNULL(CAST(ric.cost_val AS STRING), CAST(- 1 AS STRING)
              ) || '#&#' || IFNULL(CAST(exr.exchange_rate AS STRING), CAST(- 1 AS STRING))) AS BYTES))) OVER (PARTITION BY CAST(re.real_estate_sid AS STRING)
          , ric.cost_type_cd ORDER BY GREATEST(re.dwh_valid_from_tmsp, ric.dwh_valid_from_tmsp, exr.dwh_valid_from_tmsp
           ) IS NULL, GREATEST(re.dwh_valid_from_tmsp, ric.dwh_valid_from_tmsp, exr.dwh_valid_from_tmsp)))
     THEN 0
     ELSE 1
     END AS has_change_fg
   FROM ldl_data_production_core_rel.t_real_estate_1 AS re_1
    INNER JOIN ldl_data_production_core_rel.t_resource_item_cost_1 AS ric ON re.real_estate_sid = ric.resource_item_sid
      AND re.dwh_valid_to_tmsp >= ric.dwh_valid_from_tmsp AND re.dwh_valid_from_tmsp <= ric.dwh_valid_to_tmsp
    INNER JOIN ldl_data_production_core_rel.t_exchange_rate_1 AS exr ON ric.curr_cd = exr.src_curr_cd AND exr.tgt_curr_cd
         = 'EUR' AND exr.exchange_rate_type_cd = 'BEW_ISK' AND exr.dwh_valid_from_tmsp <= LEAST(re.dwh_valid_to_tmsp,
        ric.dwh_valid_to_tmsp) AND exr.dwh_valid_to_tmsp >= GREATEST(re.dwh_valid_from_tmsp, ric.dwh_valid_from_tmsp)),
  re_cost_with_groups AS (SELECT real_estate_sid,
    val_from,
    val_to,
    cost_type_cd,
    resource_item_type_cd,
    curr_cd,
    cost_val,
    cost_eur_val,
    row_hash_for_diff,
    prev_row_hash_for_diff,
    has_change_fg,
    SUM(has_change_fg) OVER (PARTITION BY CAST(real_estate_sid AS STRING), cost_type_cd ORDER BY val_from IS NULL,
       val_from, has_change_fg IS NULL DESC, has_change_fg DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    group_id
   FROM re_cost AS rec) (SELECT real_estate_sid,
    MIN(val_from) AS dwh_valid_from_tmsp,
    MAX(val_to) AS dwh_valid_to_tmsp,
    cost_type_cd,
    resource_item_type_cd,
    curr_cd,
    cost_val,
    cost_eur_val
   FROM re_cost_with_groups
   GROUP BY real_estate_sid,
    cost_type_cd,
    resource_item_type_cd,
    curr_cd,
    cost_val,
    cost_eur_val,
    group_id);