--t_dim_real_estate_event_type_2



TRUNCATE TABLE ldl_data_production_core_dim.t_dim_real_estate_event_type_2;


INSERT INTO ldl_data_production_core_dim.t_dim_real_estate_event_type_2 (real_estate_event_type_cd,
 real_estate_event_type_descr, real_estate_event_type_descr_de, real_estate_event_type_descr_en, dwh_created_tmsp,
 dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT DISTINCT real_estate_event_type_cd,
  real_estate_event_type_descr,
  real_estate_event_type_descr_de,
  real_estate_event_type_descr_en,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  - 1,
  'CORE_REL'
 FROM (WITH st_en AS (SELECT *
      FROM ldl_data_production_core_rel.t_real_estate_status_type_2
      WHERE lang_cd = 'EN'
       AND real_estate_status_categ_cd = 'BS'), st_de AS (SELECT *
      FROM ldl_data_production_core_rel.t_real_estate_status_type_2
      WHERE lang_cd = 'DE'
       AND real_estate_status_categ_cd = 'BS') (SELECT *
      FROM (SELECT CASE
           WHEN IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd) = 'UC'
           THEN 'CS'
           ELSE IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd)
           END AS real_estate_event_type_cd,
           CASE
           WHEN CASE
             WHEN IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd) = 'UC'
             THEN 'CS'
             ELSE IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd)
             END = 'CS'
           THEN 'Vertrag unterzeichnet'
           WHEN CASE
             WHEN IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd) = 'UC'
             THEN 'CS'
             ELSE IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd)
             END = 'CN'
           THEN 'Objekt abgesagt'
           ELSE IFNULL(t4.real_estate_status_descr, t1.real_estate_status_descr)
           END AS real_estate_event_type_descr,
           CASE
           WHEN CASE
             WHEN IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd) = 'UC'
             THEN 'CS'
             ELSE IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd)
             END = 'CS'
           THEN 'Vertrag unterzeichnet'
           WHEN CASE
             WHEN IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd) = 'UC'
             THEN 'CS'
             ELSE IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd)
             END = 'CN'
           THEN 'Objekt abgesagt'
           ELSE t4.real_estate_status_descr
           END AS real_estate_event_type_descr_de,
           CASE
           WHEN CASE
             WHEN IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd) = 'UC'
             THEN 'CS'
             ELSE IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd)
             END = 'CS'
           THEN 'Contract signed'
           WHEN CASE
             WHEN IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd) = 'UC'
             THEN 'CS'
             ELSE IFNULL(t4.real_estate_status_cd, t1.real_estate_status_cd)
             END = 'CN'
           THEN 'Object cancelled'
           ELSE t1.real_estate_status_descr
           END AS real_estate_event_type_descr_en,
          CURRENT_TIMESTAMP(),
          CURRENT_TIMESTAMP(),
          - 1,
          'CORE_REL'
         FROM st_en AS t1_2
          FULL JOIN st_de AS t4 ON t1.real_estate_status_cd = t4.real_estate_status_cd
         UNION ALL
         SELECT '@' AS real_estate_event_type_cd,
          'Unbekannt' AS real_estate_event_type_descr,
          'Unbekannt' AS real_estate_event_type_descr_de,
          'Unknown' AS real_estate_event_type_descr_en,
          CURRENT_TIMESTAMP(),
          CURRENT_TIMESTAMP(),
          - 1,
          'CORE_REL') AS t8)) AS t10
 WHERE NOT EXISTS (SELECT 1 AS `A12180`
   FROM ldl_data_production_core_dim.t_dim_real_estate_event_type_2
   WHERE real_estate_event_type_cd = t10.real_estate_event_type_cd)
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY real_estate_event_type_cd)) = 1);