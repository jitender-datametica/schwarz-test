CREATE OR REPLACE VIEW ldl_dig_transfer.v_rel_value_cube_domain_hierarchy_1 (data_domain_cd
OPTIONS(description='Identifier code for data domains (eg. department name can be a data domain)'), cube_level_type_cd
OPTIONS(description='Identifier for the level type of value cube (eg. order, product, customer).'), cube_descr
OPTIONS(description='Description of the value cube.'), display_order_nr
OPTIONS(description='Numbers displaying the visual sequential order.'), value_pos_descr
OPTIONS(description='Description of the value cube position.'), agg_pos_cd
OPTIONS(description='Identifier of the value cube position for the calculated subtotal/total.'), calc_sign
OPTIONS(description='A BYTES indicator defining the multiplicative factor as +1 or -1.'), value_pos_cd
OPTIONS(description='Identifier of the value cube position. Each metric can be a value cube position.'))
OPTIONS(DESCRIPTION = `THE RELATIONAL VIEW HOLDING THE LOGIC NEEDED TO DEFINE THE VALUE CUBES OUTPUT BASED ON PARAMETERS LIKE VALUE CUBE LEVEL, VALUE CUBE POSITIONS, AND AGGREGATION LOGIC.`)
AS WITH REL AS (SELECT data_domain_cd,
   cube_level_type_cd,
   cube_descr,
   value_pos_cd,
   value_pos_descr,
   agg_value_logic,
   factor_sign,
   display_order_nr
  FROM ldl_dig_transfer.t_rel_value_cube_domain_hierarchy_1), AGG_REL AS (SELECT t.data_domain_cd,
   t.cube_level_type_cd,
   t.value_pos_cd,
   TO_JSON_STRING(F.value) AS fval,
   IFNULL(NULLIF(CASE
      WHEN TO_JSON_STRING(F.value) IS NOT NULL
      THEN IFNULL(SPLIT(TO_JSON_STRING(F.value), '*')[SAFE_OFFSET(0)], '')
      ELSE NULL
      END, TO_JSON_STRING(F.value)), '1') AS agg_sign,
    CASE
    WHEN TO_JSON_STRING(F.value) IS NOT NULL
    THEN IFNULL(SPLIT(TO_JSON_STRING(F.value), '*')[SAFE_OFFSET(- 1)], '')
    ELSE NULL
    END AS pos_kpi_id
  FROM REL AS t
   INNER JOIN UNNEST(UDF_SCHEMA.flatten(PARSE_JSON(TO_JSON_STRING(REGEXP_EXTRACT_ALL(REPLACE(t.AGG_VALUE_LOGIC, '-',
         '+-1*') , r'[^+]+'))), '', FALSE, FALSE, 'both')) AS F ON TRUE) (SELECT r.data_domain_cd,
   r.cube_level_type_cd,
   r.cube_descr,
   r.display_order_nr,
   r.value_pos_descr,
   COALESCE(a.value_pos_cd, r.value_pos_cd) AS agg_pos_cd,
   COALESCE(CAST(a.agg_sign AS BIGNUMERIC), r.factor_sign) AS calc_sign,
   COALESCE(a.pos_kpi_id, r.value_pos_cd) AS value_pos_cd
  FROM REL AS r
   LEFT JOIN AGG_REL AS a ON r.value_pos_cd = a.value_pos_cd AND r.data_domain_cd = a.data_domain_cd AND r.cube_level_type_cd
      = a.cube_level_type_cd
  ORDER BY r.display_order_nr NULLS LAST);