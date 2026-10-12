CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_parameters_settings_1 AS WITH TYPES AS (SELECT country_1
   ,
   wh_nr,
   order_group_id,
   parameter_date,
   MIN(CASE
     WHEN parameter_id = 348 AND LOWER(adf_parameter_value) = 'true'
     THEN '348-TRUCKFULLING'
     WHEN parameter_id = 349 AND adf_parameter_value IS NOT NULL
     THEN '349-CUSTOM RUN'
     WHEN parameter_id = 365 AND LOWER(adf_parameter_value) = 'true'
     THEN '365-TOPUP'
     ELSE '999-STANDARD'
     END) AS order_type_input
  FROM ldl_autodispo_core.t_oracle_v_fk_parameters_settings_1
  WHERE order_group_active_fg = 1
  GROUP BY country_1,
   wh_nr,
   order_group_id,
   parameter_date) (SELECT PS.country_1,
   PS.wh_nr AS wh,
   PS.parameter_date AS date,
   PS.parameter_id,
   DC.parameter_name,
   PS.order_group_id,
   PS.order_group_name,
   PS.calculationmethod,
   PS.adf_parameter_value AS parameter_value,
   DC.defined_parameter_value,
    CASE
    WHEN PS.parameter_id = 349 AND DC.defined_parameter_value IS NULL AND PS.adf_parameter_value IS NULL
    THEN 1
    WHEN LOWER(PS.adf_parameter_value) = LOWER(DC.defined_parameter_value)
    THEN 1
    ELSE 0
    END AS match,
   SUBSTR(t.order_type_input, 5, 20) AS order_type
  FROM ldl_autodispo_core.t_oracle_v_fk_parameters_settings_1 AS PS
   INNER JOIN TYPES AS t ON PS.country_1 = t.country_1 AND PS.wh_nr = t.wh_nr AND PS.order_group_id = t.order_group_id AND
     PS.parameter_date = t.parameter_date
   INNER JOIN ldl_autodispo_core.t_oracle_v_dic_parameters_settings_1 AS DC ON PS.country_1 = DC.country_1 AND PS.parameter_id
       = DC.parameter_id AND PS.parameter_date BETWEEN CAST(DC.dwh_valid_from_tmsp AS DATE) AND (CAST(DC.dwh_valid_to_tmsp AS DATE)
      )
  WHERE PS.order_group_active_fg = 1);