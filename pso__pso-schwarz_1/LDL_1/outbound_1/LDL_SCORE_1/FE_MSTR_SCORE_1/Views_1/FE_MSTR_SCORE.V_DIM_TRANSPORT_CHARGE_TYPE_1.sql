/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_transport_charge_type_1
Description		| This dimension defines the services for which, a Transport fee is charged.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_transport_charge_type_1 (transport_charge_type_cd
OPTIONS(description='This is a code, which defines the services for which, a fee is charged.'),
transport_charge_type_name OPTIONS(description='This is a name, for the services for which, a fee is charged.'))
OPTIONS(DESCRIPTION = `THIS DIMENSION DEFINES THE SERVICES FOR WHICH, A TRANSPORT FEE IS CHARGED`) AS SELECT
 transport_charge_type_cd,
 transport_charge_type_name
FROM ldl_score_core.t_dim_transport_charge_type_1;