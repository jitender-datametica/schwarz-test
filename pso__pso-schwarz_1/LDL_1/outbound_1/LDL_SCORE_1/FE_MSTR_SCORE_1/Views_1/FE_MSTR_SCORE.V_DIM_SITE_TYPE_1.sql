/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_site_type_1
Description		| Type of site: WH Lager, PROD Produktionsstätte, LOAD Verladestandort, TURNS Drehkreuz, HEAD Firmensitz
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_site_type_1 (site_type_cd
OPTIONS(description='The code for the type of site e.g. TRANS = Warenumschlagplatz..'), site_type_descr
OPTIONS(description='A textual description for the site_type_cd written out in group language (German).'))
OPTIONS(DESCRIPTION = `THIS DIMENSION CONTAINS INFORMATION ABOUT TYPE OF SITE. THERE ARE 5 POSSIBLE TYPES OF SITE:(WH LAGER, PROD PRODUKTIONSSTÄTTE, LOAD VERLADESTANDORT, TURNS DREHKREUZ, HEAD FIRMENSITZ)`)
AS SELECT site_type_cd,
 site_type_descr
FROM ldl_score_core.t_dim_site_type_1;