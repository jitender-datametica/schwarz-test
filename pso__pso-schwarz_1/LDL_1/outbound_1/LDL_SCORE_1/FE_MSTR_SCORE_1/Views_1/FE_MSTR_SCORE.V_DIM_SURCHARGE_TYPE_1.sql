/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_dim_surcharge_type_1
Description		  | This dimension defines the services for which, a surcharge fee is charged.
Created on        |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_surcharge_type_1 (surcharge_type_cd
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'), surcharge_categ_cd
OPTIONS(description='This is a code, which defines the charge categories. Charge Category group a charge type.'),
surcharge_type_name OPTIONS(description='This is a name, for the services for which, a fee is charged.'))
OPTIONS(DESCRIPTION = `THIS DIMENSION DEFINES THE SERVICES FOR WHICH, A SURCHARGE FEE IS CHARGED.`) AS SELECT
 surcharge_type_cd,
 surcharge_categ_cd,
 surcharge_type_name
FROM ldl_score_core.t_dim_surcharge_type_1;