/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_surcharge_category
Description		  | This dimension defines the surcharge categories, Surcharge Category is a grouping of several Surcharge types.
Created on        |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_surcharge_category (surcharge_categ_cd
OPTIONS(description='This is a code, which defines the charge categories. Charge Category group a charge type.'),
surcharge_categ_name
OPTIONS(description='This is a name, which defines the charge categories. Charge Category group a charge type.'))
OPTIONS(DESCRIPTION = `THIS DIMENSION DEFINES THE SURCHARGE CATEGORIES, SURCHARGE CATEGORY IS A GROUPING OF SEVERAL SURCHARGE TYPES.`)
AS SELECT surcharge_categ_cd,
 surcharge_categ_name
FROM ldl_score_core.t_dim_surcharge_category;