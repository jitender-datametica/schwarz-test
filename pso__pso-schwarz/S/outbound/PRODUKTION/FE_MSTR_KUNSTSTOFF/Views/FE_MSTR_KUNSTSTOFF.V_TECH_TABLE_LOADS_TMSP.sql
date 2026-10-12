CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_tech_table_loads_tmsp (sorting_order, fact_table, max_tmsp,
max_data_tmsp, current_tmsp) AS (((((SELECT 1 AS sorting_order,
      'CORE.T_FACT_BOOKING_PER_ORDER_BUSINESS_DAY' AS fact_table,
      CAST(MAX(dwh_src_1_tmsp) AS TIMESTAMP) AS max_tmsp,
      CAST(MAX(max_booking_tmsp) AS TIMESTAMP) AS max_data_tmsp,
      CURRENT_TIMESTAMP() AS current_tmsp
     FROM produktion_core.t_fact_booking_per_order_business_day
     WHERE max_booking_tmsp < CAST(PARSE_DATETIME('%F %H:%M:%S', '9999-12-31 23:59:59') AS TIMESTAMP)
       
     UNION DISTINCT
     SELECT 2,
      'CORE.T_FACT_MEASUREMENT_PRODUCTION_LINE',
      MAX(dwh_src_1_tmsp),
      MAX(measurement_tmsp),
      CURRENT_TIMESTAMP() AS current_tmsp
     FROM produktion_core.t_fact_measurement_production_line)
    UNION DISTINCT
    SELECT 3,
     'CORE.T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL',
     MAX(dwh_src_1_tmsp),
     MAX(measurement_tmsp),
     CURRENT_TIMESTAMP() AS current_tmsp
    FROM produktion_core.t_fact_measurement_production_line_per_intervall)
   UNION DISTINCT
   SELECT 4,
    'CORE.T_FACT_MEASUREMENT_PRODUCTION_LINE_PER_INTERVALL_MOVING',
    MAX(dwh_src_1_tmsp),
    MAX(measurement_tmsp),
    CURRENT_TIMESTAMP() AS current_tmsp
   FROM produktion_core.t_fact_measurement_production_line_per_intervall_moving)
  UNION DISTINCT
  SELECT 5,
   'CORE.T_FACT_MEASUREMENT_SILO',
   MAX(dwh_src_1_tmsp),
   MAX(measurement_tmsp),
   CURRENT_TIMESTAMP() AS current_tmsp
  FROM produktion_core.t_fact_measurement_silo)
 UNION DISTINCT
 SELECT 6,
  'CORE.T_FACT_ORDER',
  MAX(dwh_src_1_tmsp),
  MAX(dwh_src_1_tmsp),
  CURRENT_TIMESTAMP() AS current_tmsp
 FROM produktion_core.t_fact_order)
UNION DISTINCT
SELECT 7,
 'CORE.T_FACT_THRESHOLD_PARAMETER_PER_MATERIAL_REL',
 MAX(dwh_src_1_tmsp),
 MAX(dwh_src_1_tmsp),
 CURRENT_TIMESTAMP() AS current_tmsp
FROM produktion_core.t_fact_threshold_parameter_per_material_rel;