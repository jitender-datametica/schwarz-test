CREATE OR REPLACE VIEW szd_production_fe_mstr_lifecycle.v_l_lifecycle_country_political_2 (country_pol_cd,
country_pol_name, country_pol_name_de, country_pol_name_ch, country_pol_name_en, country_pol_name_cz,
country_pol_name_lt, country_pol_name_sk, country_pol_name_si, country_pol_name_ro) AS SELECT iso_country_cd AS
 country_pol_cd,
 country_name_de AS country_pol_name,
 country_name_de AS country_pol_name_de,
 country_name_de AS country_pol_name_ch,
 country_name_en AS country_pol_name_en,
 country_name_en AS country_pol_name_cz,
 country_name_en AS country_pol_name_lt,
 country_name_en AS country_pol_name_sk,
 country_name_en AS country_pol_name_si,
 country_name_en AS country_pol_name_ro
FROM szd_production_core.t_dim_country_political_2
WHERE dwh_valid_fg;