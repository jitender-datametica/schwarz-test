/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_logistics_tariff
Description		| Contains details about terms and conditions of tariffs applicable for a logistical agreements
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_logistics_tariff (logistics_tariff_sid
OPTIONS(description='Surrogate identifier for Logistics Tariff'), equipment_type_cd
OPTIONS(description='The type discriminator for this equipment, i.e. vehicle(truck)'), negot_fg
OPTIONS(description='Is this a negotiable term?'), weight_dispo_fg
OPTIONS(description='There can be a weight disposition in the groupage load as well as in the full load.'),
max_tons_meas OPTIONS(description='The maximum allowance for charging a truck in tons'), term_day_cnt
OPTIONS(description='Term days'), min_pallet_cnt OPTIONS(description='Minimum permitted load in Euro Pallets'))
OPTIONS(DESCRIPTION = `CONTAINS DETAILS ABOUT TERMS AND CONDITIONS OF TARIFFS APPLICABLE FOR A LOGISTICAL AGREEMENTS`)
AS SELECT logistics_tariff_sid,
 equipment_type_cd,
 negot_fg,
 weight_dispo_fg,
 max_tons_meas,
 term_day_cnt,
 min_pallet_cnt
FROM ldl_score_core.t_dim_logistics_tariff;