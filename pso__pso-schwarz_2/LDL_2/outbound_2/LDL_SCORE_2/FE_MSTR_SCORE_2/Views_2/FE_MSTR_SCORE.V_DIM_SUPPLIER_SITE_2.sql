/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_supplier_site_2
Description		  | This entity contains sites which are operated by supplier_2
Created on        |	19.11.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_supplier_site_2 (supplier_site_sid, supplier_sid, country_cd,
country_descr, supplier_site_nr, supplier_site_abbr_name, supplier_site_name, supplier_site_transpoint_type_cd,
supplier_site_transpoint_type_descr, longitude, latitude, city_name, zip, street_name, gln_nr) AS SELECT
 supplier_site_sid,
 supplier_sid,
 country_cd,
 country_descr,
 supplier_site_nr,
 supplier_site_abbr_name,
 supplier_site_name,
 supplier_site_transpoint_type_cd,
 supplier_site_transpoint_type_descr,
 longitude,
 latitude,
 city_name,
 zip,
 street_name,
 gln_nr
FROM ldl_score_core.t_dim_supplier_site_2;