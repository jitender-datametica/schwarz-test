CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_declarant_type_1 (declarant_type_cd, declarant_type_name) AS SELECT
 declarant_type_cd,
 declarant_type_name
FROM szd_core.t_dim_declarant_type_1;