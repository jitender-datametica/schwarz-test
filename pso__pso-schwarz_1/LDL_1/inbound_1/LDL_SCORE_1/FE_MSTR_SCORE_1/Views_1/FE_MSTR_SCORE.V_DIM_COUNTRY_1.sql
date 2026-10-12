/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_country_1
Description		  | Charge types
Created on        |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_country_1(
	country_cd COMMENT 'The code for the country_1 in which the site (cross docks) resides in.',
	country_descr COMMENT 'A textual description for country_cd written out in group language (German).',
	suppliers_exist_fg COMMENT 'Flag informs, if supplier_1 exist in this country.',
	haulers_exist_fg COMMENT 'Flag informs, if hauler exist in this country.',
	org_units_exist_fg COMMENT 'Flag informs, if Org Unit_1 exist in this country.'
) COMMENT='Is by definition the opposite from the business country. Here we don''t separate islands from the country. '
 AS 
SELECT
   country_cd
  ,country_descr
  ,suppliers_exist_fg
  ,haulers_exist_fg
  ,org_units_exist_fg
FROM core.t_dim_country_1;