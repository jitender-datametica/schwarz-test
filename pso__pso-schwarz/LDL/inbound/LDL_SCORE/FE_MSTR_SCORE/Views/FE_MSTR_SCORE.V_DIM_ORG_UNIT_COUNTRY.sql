/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_org_unit_country
Description		  | Business country filterd for org unit
Created on        |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_org_unit_country(
	COUNTRY_CD COMMENT 'The code for the country in which the site (cross docks) resides in.',
	COUNTRY_DESCR COMMENT 'A textual description for country_cd written out in group language (German).'
) COMMENT='Is by definition the opposite from the business country. Here we don''t separate islands from the country. This view is filterd for org unit'
 AS
SELECT 
	country_cd 
	,country_descr 
FROM fe_mstr_score.v_dim_country
WHERE org_units_exist_fg = 'TRUE';