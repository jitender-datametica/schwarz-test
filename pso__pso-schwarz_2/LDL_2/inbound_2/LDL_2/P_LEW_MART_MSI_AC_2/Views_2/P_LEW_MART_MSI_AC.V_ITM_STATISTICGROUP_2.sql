CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_STATISTICGROUP_2
(
client_id
, statisticgroup_id
, statisticgroup_desc
, language_id
, stdgroup_id
 )
AS
SELECT
client_id,
statisticgroup_id,
statisticgroup_desc,
language_id,
stdgroup_id
FROM p_lew_mart_msi.v_itm_statisticgroup_2;


