/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_country_2
Description		  | Charge types
Created on        |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_country_2 (country_cd
OPTIONS(description='The code for the country_2 in which the site (cross docks) resides in.'), country_descr
OPTIONS(description='A textual description for country_cd written out in group language (German).'), suppliers_exist_fg
OPTIONS(description='Flag informs, if supplier_2 exist in this country.'), haulers_exist_fg
OPTIONS(description='Flag informs, if hauler exist in this country.'), org_units_exist_fg
OPTIONS(description='Flag informs, if Org Unit_2 exist in this country.'))
OPTIONS(DESCRIPTION = `IS BY DEFINITION THE OPPOSITE FROM THE BUSINESS COUNTRY. HERE WE DON''T SEPARATE ISLANDS FROM THE COUNTRY. `)
AS SELECT country_cd,
 country_descr,
 suppliers_exist_fg,
 haulers_exist_fg,
 org_units_exist_fg
FROM ldl_score_core.t_dim_country_2;