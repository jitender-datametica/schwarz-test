CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_KPGES_MTH_WH_MERGE_1
/*
#DescStart#
#$Revision: 7705 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , wh_id
    , aspect_id
    , indicator_id
    , cy_month
    , val_indicator
    , currency_iso_cd
    , dat_dayend
)
AS
SELECT
client_id,
wh_id,
aspect_id,
indicator_id,
cy_month,
val_indicator,
currency_iso_cd,
dat_dayend
FROM p_lew_mart_msi.v_kpges_mth_wh_merge_1
;


