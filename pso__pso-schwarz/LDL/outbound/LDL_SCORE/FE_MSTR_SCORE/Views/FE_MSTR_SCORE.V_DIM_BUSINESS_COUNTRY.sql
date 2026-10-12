CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_business_country AS SELECT bus_country_cd,
 bus_country_descr,
 reporting_country_descr,
 reporting_territory_descr,
 link_to_nat_flag_txt,
   '<img src="' || link_to_nat_flag_txt || '" height="50px" width="50px">' AS image_tag
FROM ldl_score_core.t_dim_business_country;