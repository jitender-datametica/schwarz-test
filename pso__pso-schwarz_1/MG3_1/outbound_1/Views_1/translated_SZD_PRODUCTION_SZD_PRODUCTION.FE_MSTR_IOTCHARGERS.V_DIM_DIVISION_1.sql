CREATE OR REPLACE VIEW szd_production_fe_mstr_iotchargers.v_dim_division_1 (division_cd, division_name, division_logo) AS
SELECT division_cd,
 division_name,
 CONCAT('https://mis', CASE
   WHEN udf_schema.PROJECT_ID() = 'SZD_PRODUCTION'
   THEN ''
   WHEN udf_schema.PROJECT_ID() = 'SZD_QUALITY'
   THEN '-qas'
   ELSE '-dev'
   END, '.schwarz/MicroStrategy/images/_custom/iotchargers/divisions/', CASE
   WHEN division_cd <> '-1'
   THEN division_cd
   ELSE 'UNKNOWN'
   END, '.png') AS division_logo
FROM szd_production_core.t_dim_division_1
WHERE dwh_valid_to_tmsp >= CAST('9999-12-31' AS TIMESTAMP);