TRUNCATE TABLE ldl_data_production_core_dim.t_dim_exchange_rate_type_2;


INSERT INTO ldl_data_production_core_dim.t_dim_exchange_rate_type_2 (exchange_rate_type_cd, exchange_rate_type_descr,
 exchange_rate_type_descr_de, exchange_rate_type_descr_en, active_for_bus_year_fg, dwh_created_tmsp, dwh_updated_tmsp,
 dwh_load_id, dwh_node_cd)
(SELECT exchange_rate_type_cd,
  exchange_rate_type_descr,
  exchange_rate_type_descr_de,
  exchange_rate_type_descr_en,
  fixed_rate_fg,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CAST(${LOAD_ID} AS INTEGER),
  'CORE_REL'
 FROM (SELECT de.exchange_rate_type_cd,
     de.exchange_rate_type_descr,
     de.exchange_rate_type_descr AS exchange_rate_type_descr_de,
     en.exchange_rate_type_descr AS exchange_rate_type_descr_en,
     de.fixed_rate_fg,
     CURRENT_TIMESTAMP(),
     CURRENT_TIMESTAMP(),
     CAST(${LOAD_ID} AS INTEGER),
     'CORE_REL'
    FROM (SELECT *
      FROM ldl_data_production_core_rel.t_exchange_rate_type_2
      WHERE lang_cd = 'DE') AS de
     INNER JOIN (SELECT *
      FROM ldl_data_production_core_rel.t_exchange_rate_type_2
      WHERE lang_cd = 'EN') AS en ON de.exchange_rate_type_cd = en.exchange_rate_type_cd
    UNION DISTINCT
    SELECT '@',
     'Unbekannt',
     'Unbekannt',
     'Unknown',
     FALSE,
     CURRENT_TIMESTAMP(),
     CURRENT_TIMESTAMP(),
     1,
     'MANUAL') AS t4
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_dim.t_dim_exchange_rate_type_2
   WHERE exchange_rate_type_cd = t4.exchange_rate_type_cd)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY exchange_rate_type_cd)) = 1);