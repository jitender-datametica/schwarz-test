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

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_org_unit_country_2(
	COUNTRY_CD COMMENT 'The code for the country_2 in which the site (cross docks) resides in.',
	COUNTRY_DESCR COMMENT 'A textual description for country_cd written out in group language (German).'
) COMMENT='Is by definition the opposite from the business country. Here we don''t separate islands from the country. This view is filterd for org unit_2'
 AS
SELECT 
	country_cd 
	,country_descr 
FROM fe_mstr_score.v_dim_country_2
WHERE org_units_exist_fg = 'TRUE';