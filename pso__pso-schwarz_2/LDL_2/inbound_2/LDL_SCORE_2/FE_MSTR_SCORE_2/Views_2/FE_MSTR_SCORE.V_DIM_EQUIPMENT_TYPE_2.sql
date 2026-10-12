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

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_EQUIPMENT_TYPE_2 (
	EQUIPMENT_TYPE_CD COMMENT 'The type discriminator for this equipment, i.e. vehicle(truck)',
	EQUIPMENT_TYPE_DESCR COMMENT 'Description for this equipment code, i.e. vehicle(truck) e.g.Jumbo/Megas,Planen-LKW, Kühl_2-LKW,Seecontainer 45`pw reefer',
	EQUIPMENT_CAPACITY_EP_PALLET_CNT COMMENT 'Number of EP pallets that can fit in the vehicle',
	EQUIPMENT_CAPACITY_DD_PALLET_CNT COMMENT 'Number of DD pallets that can fit in the vehicle',
	EQUIPMENT_TYPE_EXTERNAL_ID COMMENT 'External system numeric code',
	MEANS_OF_TRANSPORT_CD COMMENT 'Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)'
) COMMENT='Type of vehicle i.e. Koffer'
 AS 
SELECT
   equipment_type_cd
  ,equipment_type_descr
  ,equipment_capacity_ep_pallet_cnt 
  ,equipment_capacity_dd_pallet_cnt
  ,equipment_type_external_id
  ,means_of_transport_cd
FROM CORE.T_DIM_EQUIPMENT_TYPE_2;