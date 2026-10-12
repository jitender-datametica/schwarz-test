CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ORG_STORE_BUSYEAR_2
/*
#DescStart#
#$Revision: 7138 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    busyear
    , client_id
    , store_id
    , lead_open_store_fg
)
AS
SELECT
busyear,
client_id,
store_id,
lead_open_store_fg
FROM p_lew_mart_msi.v_org_store_busyear_2
;


