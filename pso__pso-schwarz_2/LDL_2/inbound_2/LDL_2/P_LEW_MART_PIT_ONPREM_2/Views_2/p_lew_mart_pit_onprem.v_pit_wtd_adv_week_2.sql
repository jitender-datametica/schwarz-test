CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_WTD_ADV_WEEK_2

AS
SELECT
wtd.adv_week_sid
,wtd.client_id
,wtd.adv_week_id
,wtd.wtd_adv_week_sid
,wtd.wtd_adv_week_id
,COALESCE(awr.adv_week_rltd_type_id, -1::INTEGER) AS adv_week_rltd_type_id
FROM
(SELECT
(100::INTEGER * wk.adv_week_id ) + wk.client_id AS adv_week_sid
,wk.client_id
,wk.adv_week_id
,(100::INTEGER * wkr.adv_week_id) + wkr.client_id AS wtd_adv_week_sid
,wkr.adv_week_id AS wtd_adv_week_id
FROM p_lew_mart_pit_onprem.t_advert_week_2 AS wk
INNER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS wkr
ON  wk.client_id   = wkr.client_id
AND wk.adv_week_id > wkr.adv_week_id
QUALIFY ROW_NUMBER() OVER (PARTITION BY wk.client_id, wk.adv_week_id ORDER BY wkr.adv_week_id DESC NULLS LAST) <= 53
) AS wtd
LEFT JOIN p_lew_mart_pit_onprem.t_advert_week_related_2 AS awr
ON  wtd.client_id       = awr.client_id
AND wtd.adv_week_id     = awr.adv_week_id
AND wtd.wtd_adv_week_id = awr.rltd_adv_week_id;