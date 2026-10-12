/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_supplier_country_2
Description		  | Business country_2 filterd for supplier_2
Created on        |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_supplier_country_2(
	country_cd COMMENT 'The code for the country_2 in which the site (cross docks) resides in.',
	country_descr COMMENT 'A textual description for country_cd written out in group language (German).'
) COMMENT='Is by definition the opposite from the business country. Here we don''t separate islands from the country. This view is filterd for supplier_2'
 AS
SELECT 
    country_cd 
    ,country_descr 
FROM FE_MSTR_SCORE.V_DIM_COUNTRY_2
WHERE suppliers_exist_fg = 'TRUE';