CREATE OR REPLACE VIEW szd_fe_mstr_infrastructure.v_l_sit_infrastructure_country_political_2 (country_pol_cd,
country_pol_name, curr_cd) AS SELECT iso_country_cd AS country_pol_cd,
 country_name_de AS country_pol_name,
 curr_cd
FROM szd_core.t_dim_country_political_2
WHERE dwh_valid_fg;