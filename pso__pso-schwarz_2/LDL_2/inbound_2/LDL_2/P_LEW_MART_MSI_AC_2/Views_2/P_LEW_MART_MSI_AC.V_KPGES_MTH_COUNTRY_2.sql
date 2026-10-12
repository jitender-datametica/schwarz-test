CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_KPGES_MTH_COUNTRY_2
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, indicator_id
, cy_month
, val_indicator
, currency_iso_cd
, dat_dayend
 )
AS
SELECT
client_id,
indicator_id,
cy_month,
val_indicator,
currency_iso_cd,
dat_dayend
FROM p_lew_mart_msi.v_kpges_mth_country_2;


