CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_GFK_HHP_LEH_ACCOUNT
(
MANDANT_ID,
GFK_ACCOUNT_ID,
GFK_ACCOUNT_BEZ
)
AS
SELECT
 mandant_id
,gfk_account_id
,gfk_account_bez
FROM dbp_data.gfk_hhp_leh_account;