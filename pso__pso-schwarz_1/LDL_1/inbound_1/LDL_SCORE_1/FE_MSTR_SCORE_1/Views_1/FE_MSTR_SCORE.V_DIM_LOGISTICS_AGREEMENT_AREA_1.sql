/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_logistics_agreement_area_1
Description		| This table defines areas of logistics agreement. For example Logistics and Import.
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_LOGISTICS_AGREEMENT_AREA_1(
	LOGISTICS_AGMT_AREA_CD COMMENT 'Code of Logistics agreement area, for example: IMP/LOG.',
	LOGISTICS_AGMT_AREA_DESCR COMMENT 'Description of logistics agreement area, for example: Import/Logistik.'
) COMMENT='This table defines areas of logistics agreement. For example Logistics and Import.'
 AS 
SELECT
   logistics_agmt_area_cd
  ,logistics_agmt_area_descr
FROM CORE.T_DIM_LOGISTICS_AGREEMENT_AREA_1;