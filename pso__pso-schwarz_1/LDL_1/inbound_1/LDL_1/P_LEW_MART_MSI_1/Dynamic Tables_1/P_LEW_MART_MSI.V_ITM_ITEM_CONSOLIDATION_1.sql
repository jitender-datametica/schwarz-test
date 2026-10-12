
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_ITEM_CONSOLIDATION_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 9104 $, $LastChangedBy: aarnold $
#SubjectAreas#: Artikelstamm
#DescEnd#
*/
SELECT
i.client_id,
wh.src_wh_id AS wh_id,
i.item_sid AS item_id,
i.itm_consgrp_id,
i.cons_item_id,
CASE WHEN i.itm_consgrp_id = -1 THEN a.orig_item_nr ELSE -1 END AS cons_orig_item_nr,
CASE WHEN i.itm_consgrp_id = -1 THEN a.dat_valid_from ELSE DATE '1900-01-01' END AS cons_dat_valid_from_item,
CASE WHEN i.itm_consgrp_id = -1 THEN 0 ELSE 1 END AS cons_fg,
cgp.itm_consgrp_desc,
oid.item_desc
FROM
(SELECT
i1.client_id,
i1.wh_loc_sid,
i1.item_sid,
c1.itm_consgrp_id,
CAST(-1 AS INTEGER) AS cons_item_id
FROM p_lew_core_ac.v_wawi_itm_item_wh_1 i1
INNER JOIN p_lew_core_ac.v_wawi_itm_item_consolidation_1 c1
ON i1.client_id = c1.client_id
AND i1.item_sid  =  c1.item_sid
AND i1.wh_loc_sid  =  c1.wh_loc_sid
WHERE CURRENT_DATE BETWEEN c1.dat_rec_start AND c1.dat_rec_end
AND   CURRENT_DATE BETWEEN i1.dat_rec_start AND i1.dat_rec_end
UNION ALL
SELECT
i2.client_id,
i2.wh_loc_sid,
i2.item_sid,
CAST(-1 AS INTEGER) AS itm_consgrp_id,
i2.item_sid AS cons_item_sid
FROM p_lew_core_ac.v_wawi_itm_item_wh_1 i2
WHERE NOT EXISTS
(SELECT
1
FROM p_lew_core_ac.v_wawi_itm_item_consolidation_1 c2
WHERE i2.client_id = c2.client_id
AND i2.item_sid  =  c2.item_sid
AND i2.wh_loc_sid  =  c2.wh_loc_sid
AND CURRENT_DATE BETWEEN c2.dat_rec_start AND c2.dat_rec_end
)
AND   CURRENT_DATE BETWEEN i2.dat_rec_start AND i2.dat_rec_end
) i
 -- Auflösung WH
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON wh.client_id = i.client_id
AND wh.loc_sid_wh = i.wh_loc_sid
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 a
ON a.client_id = i.client_id
AND a.item_sid  =  i.item_sid
LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_consolidationgroup_1 cgp
ON cgp.client_id = i.client_id
AND cgp.wh_loc_sid  =  i.wh_loc_sid
AND cgp.itm_consgrp_id = i.itm_consgrp_id
AND CURRENT_DATE BETWEEN cgp.dat_rec_start AND cgp.dat_rec_end
INNER JOIN p_lew_core_ac.v_wawi_itm_orig_item_desc_act_1 oid
ON  i.client_id = oid.client_id
AND a.orig_item_nr = oid.orig_item_nr
AND a.dat_valid_from = oid.dat_valid_from
AND oid.language_id = i.client_id
;
