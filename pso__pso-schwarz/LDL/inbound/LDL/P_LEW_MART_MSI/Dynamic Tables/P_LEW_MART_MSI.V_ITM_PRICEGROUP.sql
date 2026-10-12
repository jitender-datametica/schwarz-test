
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_PRICEGROUP

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 9112 $, $LastChangedBy: aarnold $
#SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
#DescEnd#
*/
SELECT
a.client_id,
wh.src_wh_id AS wh_id,
a.st_loc_sid AS store_id,
a.pricegroup_id,
a.dat_valid_from  AS dat_rec_start,
a.dat_valid_until   AS dat_rec_end,
a.priority,
a.pricegroup_desc
FROM p_lew_core_ac.v_wawi_itm_pricegroup AS a
 -- Auflösung WH
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON wh.client_id = a.client_id
AND wh.loc_sid_wh =  a.wh_loc_sid
AND wh.dwh_actual_fg = 1
;
