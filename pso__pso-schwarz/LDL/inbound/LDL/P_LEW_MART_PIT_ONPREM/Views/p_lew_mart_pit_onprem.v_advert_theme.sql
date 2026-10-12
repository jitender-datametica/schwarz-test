CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_ADVERT_THEME
AS
SELECT
client_id
,adv_theme_sid
,adv_theme_descr
,dwh_created
FROM p_lew_mart_pit_onprem.t_advert_theme;