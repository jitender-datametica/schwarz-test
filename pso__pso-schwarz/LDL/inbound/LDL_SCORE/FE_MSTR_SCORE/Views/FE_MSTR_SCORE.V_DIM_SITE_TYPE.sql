/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_type
Description		| Type of site: WH Lager, PROD Produktionsstätte, LOAD Verladestandort, TURNS Drehkreuz, HEAD Firmensitz
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_site_type(
	site_type_cd COMMENT 'The code for the type of site e.g. TRANS = Warenumschlagplatz..',
	site_type_descr COMMENT 'A textual description for the site_type_cd written out in group language (German).'
) COMMENT='This Dimension contains information about type of site. There are 5 possible types of site:(WH Lager, PROD Produktionsstätte, LOAD Verladestandort, TURNS Drehkreuz, HEAD Firmensitz)'
 AS 
SELECT
   site_type_cd
  ,site_type_descr
FROM core.t_dim_site_type;