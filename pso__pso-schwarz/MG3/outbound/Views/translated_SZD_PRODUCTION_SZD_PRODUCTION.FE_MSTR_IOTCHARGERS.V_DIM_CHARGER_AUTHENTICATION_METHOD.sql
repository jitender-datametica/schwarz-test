CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_charger_authentication_method (authentication_method_cd
, authentication_method_name, authentication_method_logo) AS SELECT authentication_method_cd,
 authentication_method_name,
 CONCAT('https://mis', CASE
   WHEN udf_schema.PROJECT_ID() = 'SZD_PRODUCTION'
   THEN ''
   WHEN udf_schema.PROJECT_ID() = 'SZD_QUALITY'
   THEN '-qas'
   ELSE '-dev'
   END, '.schwarz/MicroStrategy/images/_custom/iotchargers/authentication_methods/', CASE
   WHEN authentication_method_cd <> '-1'
   THEN authentication_method_cd
   ELSE 'UNKNOWN'
   END, '.png') AS authentication_method_logo
FROM szd_production_core.t_dim_charger_authentication_method;