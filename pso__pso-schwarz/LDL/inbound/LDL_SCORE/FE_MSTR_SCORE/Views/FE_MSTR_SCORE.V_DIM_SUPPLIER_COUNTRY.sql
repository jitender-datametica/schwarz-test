/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_supplier_country
Description		  | Business country filterd for supplier
Created on        |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_supplier_country(
	country_cd COMMENT 'The code for the country in which the site (cross docks) resides in.',
	country_descr COMMENT 'A textual description for country_cd written out in group language (German).'
) COMMENT='Is by definition the opposite from the business country. Here we don''t separate islands from the country. This view is filterd for supplier'
 AS
SELECT 
    country_cd 
    ,country_descr 
FROM FE_MSTR_SCORE.V_DIM_COUNTRY
WHERE suppliers_exist_fg = 'TRUE';