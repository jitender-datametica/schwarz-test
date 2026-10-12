/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_org_unit_country_2
Description		  | Business country_2 filterd for org unit_2
Created on        |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_org_unit_country_2 (country_cd
OPTIONS(description='The code for the country_2 in which the site (cross docks) resides in.'), country_descr
OPTIONS(description='A textual description for country_cd written out in group language (German).'))
OPTIONS(DESCRIPTION = `IS BY DEFINITION THE OPPOSITE FROM THE BUSINESS COUNTRY. HERE WE DON''T SEPARATE ISLANDS FROM THE COUNTRY. THIS VIEW IS FILTERD FOR ORG UNIT_2`)
AS SELECT country_cd,
 country_descr
FROM ldl_score_fe_mstr_score.v_dim_country_2
WHERE org_units_exist_fg;