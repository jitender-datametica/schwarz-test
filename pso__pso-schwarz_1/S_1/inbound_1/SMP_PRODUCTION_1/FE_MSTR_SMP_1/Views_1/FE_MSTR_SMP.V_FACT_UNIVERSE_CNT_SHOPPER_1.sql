create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_FACT_UNIVERSE_CNT_SHOPPER_1(
	COUNTRY_ID,
	DIVISION_ID,
	CAMPAIGN_ID,
	UNIVERSE_ID,
	CNT_SHOPPER_ID
) as
SELECT 
     td.country_id
	,td.division_id
	,td.campaign_id
    ,Td.universe_id
	,count(DISTINCT shopper_id) AS cnt_shopper_id
FROM CORE_REL.T_CAMPAIGN_1 TD
JOIN CORE_REL.T_UNIVERSE_SHOPPER_1 TU ON TD.universe_id = TU.universe_id
	AND TD.country_id = TU.country_id
	AND TD.division_id = TU.division_id
WHERE  TU.universe_id <>''
GROUP BY   td.country_id
	,td.division_id
	,td.campaign_id
    ,Td.universe_id;
