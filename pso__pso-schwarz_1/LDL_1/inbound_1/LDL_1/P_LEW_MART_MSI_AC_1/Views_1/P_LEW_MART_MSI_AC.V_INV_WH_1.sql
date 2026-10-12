CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_INV_WH_1
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, wh_id
, inv_id
, inv_start_date
, inv_end_date
 )
AS
SELECT
client_id,
wh_id,
inv_id,
inv_start_date,
inv_end_date
FROM p_lew_mart_msi.v_inv_wh_1;





