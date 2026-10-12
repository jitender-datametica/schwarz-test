CREATE OR REPLACE VIEW ldl_production_p_lew_bil_ac.v_dim_country_political (country_pol_cd, country_pol_name,
country_pol_name_de, country_pol_name_en, country_pol_name_bg, country_pol_name_cs, country_pol_name_da,
country_pol_name_el, country_pol_name_es, country_pol_name_fi, country_pol_name_fr, country_pol_name_hr,
country_pol_name_hu, country_pol_name_it, country_pol_name_lt, country_pol_name_nl, country_pol_name_pl,
country_pol_name_pt, country_pol_name_ro, country_pol_name_sh, country_pol_name_sk, country_pol_name_sl,
country_pol_name_sv, curr_cd, country_grp_sid, country_grp_manager_name, dwh_load_id, dwh_created, dwh_updated) AS
SELECT *
FROM ldl_production_p_lew_bil.v_dim_country_political;