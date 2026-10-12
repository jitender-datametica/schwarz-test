/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_equipment_type_2
Description		| Type of vehicle
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_equipment_type_2 (equipment_type_cd
OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'), equipment_type_descr
OPTIONS(description='Description for this equipment code, i.e. vehicle(truck) e.g.Jumbo/Megas,Planen-LKW, Kühl_2-LKW,Seecontainer 45`pw reefer'),
equipment_capacity_ep_pallet_cnt OPTIONS(description='Number of EP pallets that can fit in the vehicle'),
equipment_capacity_dd_pallet_cnt OPTIONS(description='Number of DD pallets that can fit in the vehicle'),
equipment_type_external_id OPTIONS(description='External system numeric code'), means_of_transport_cd
OPTIONS(description='Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)'))
OPTIONS(DESCRIPTION = `TYPE OF VEHICLE I.E. KOFFER`) AS SELECT equipment_type_cd,
 equipment_type_descr,
 equipment_capacity_ep_pallet_cnt,
 equipment_capacity_dd_pallet_cnt,
 equipment_type_external_id,
 means_of_transport_cd
FROM ldl_score_core.t_dim_equipment_type_2;