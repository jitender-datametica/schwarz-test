TRUNCATE TABLE ldl_data_production_core_dim.t_dim_currency_2;


INSERT INTO ldl_data_production_core_dim.t_dim_currency_2 (curr_cd, curr_name, curr_name_de, curr_name_en,
 used_in_stores_fg, euro_exch_rate, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT curr_cd,
  curr_name,
  curr_name_de,
  curr_name_en,
  used_in_stores_fg,
  euro_exch_rate,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CAST(${LOAD_ID} AS INTEGER),
  'CORE_REL'
 FROM (SELECT de.curr_cd,
     de.curr_name,
     de.curr_name AS curr_name_de,
     en.curr_name AS curr_name_en,
     de.used_in_stores_fg,
     r.exchange_rate AS euro_exch_rate,
     CURRENT_TIMESTAMP(),
     CURRENT_TIMESTAMP(),
     CAST(${LOAD_ID} AS INTEGER),
     'CORE_REL'
    FROM (SELECT *
      FROM ldl_data_production_core_rel.t_currency_2
      WHERE lang_cd = 'DE') AS de
     INNER JOIN (SELECT *
      FROM ldl_data_production_core_rel.t_currency_2
      WHERE lang_cd = 'EN') AS en ON de.curr_cd = en.curr_cd
     LEFT JOIN (SELECT *
      FROM ldl_data_production_core_rel.t_exchange_rate_2
      WHERE exchange_rate_type_cd = 'BEW_ISK'
       AND tgt_curr_cd = 'EUR'
       AND dwh_valid_fg) AS r ON de.curr_cd = r.src_curr_cd
    UNION DISTINCT
    SELECT '@',
     'Unbekannt',
     'Unbekannt',
     'Unknown',
     FALSE,
     CAST(NULL AS BIGNUMERIC),
     CURRENT_TIMESTAMP(),
     CURRENT_TIMESTAMP(),
     1,
     'MANUAL') AS t5
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_dim.t_dim_currency_2
   WHERE curr_cd = t5.curr_cd)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY curr_cd)) = 1);