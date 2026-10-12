/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_logistics_tariff_2
Description		| Contains details about terms and conditions of tariffs applicable for a logistical agreements
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_LOGISTICS_TARIFF_2(
	LOGISTICS_TARIFF_SID COMMENT 'Surrogate identifier for Logistics Tariff',
	EQUIPMENT_TYPE_CD COMMENT 'The type discriminator for this equipment, i.e. vehicle(truck)',
	NEGOT_FG COMMENT 'Is this a negotiable term?',
	WEIGHT_DISPO_FG COMMENT 'There can be a weight disposition in the groupage load as well as in the full load.',
	MAX_TONS_MEAS COMMENT 'The maximum allowance for charging a truck in tons',
	TERM_DAY_CNT COMMENT 'Term days',
	MIN_PALLET_CNT COMMENT 'Minimum permitted load in Euro Pallets'
) COMMENT='Contains details about terms and conditions of tariffs applicable for a logistical agreements'
 AS 
SELECT
   logistics_tariff_sid
  ,equipment_type_cd
  ,negot_fg
  ,weight_dispo_fg
  ,max_tons_meas
  ,term_day_cnt
  ,min_pallet_cnt
FROM CORE.T_DIM_LOGISTICS_TARIFF_2;