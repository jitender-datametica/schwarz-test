
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_INV_RETURN_ITEM_WH_DAY_1 
(
    client_id 
    ,loc_sid
    ,wh_id
    ,item_id 
    ,booking_dat
    ,ship_qty
    ,gross_val
    ,sales_net_val
) 
TARGET_LAG = '1 hour, 30 minutes' -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS

SELECT
    mov.client_id
    ,mov.loc_sid
    ,l.src_wh_id              AS wh_id
    ,d.item_sid               AS item_id
    ,mov.dwh_cal_dt           AS booking_dat
    ,SUM(mov.ship_qty)        AS ship_qty
    ,SUM(mov.ship_qty * COALESCE(prc.cond_val_eff_calc, 0))   AS gross_val
    ,SUM(TO_NUMBER(mov.ship_qty * COALESCE(prc.cond_val_eff_calc, 0) * 100 /
    (100 + COALESCE(prc.tax_rate_calc, 0)),18,2)) AS sales_net_val

FROM  P_LEW_CORE_AC.v_item_movement_record_pos_1 AS mov
/* Take the sales_1 price from Sales_1 condition table */
LEFT OUTER JOIN P_LEW_BIL_AC.v_item_loc_sales_cond_denorm_1 prc
    ON  prc.client_id   = mov.client_id
    AND prc.item_sid = mov.item_sid
    AND prc.loc_sid = mov.loc_sid
    AND prc.uom_sid_cond = mov.uom_sid_base
    AND mov.dwh_cal_dt BETWEEN  prc.dwh_valid_from AND prc.dwh_valid_to

INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS l
    ON   mov.client_id   = l.client_id
    AND  mov.loc_sid = l.loc_sid_wh

INNER JOIN P_LEW_MART_MSI.v_org_wh_1 AS o
    ON l.client_id = o.client_id
    AND l.src_wh_id = o.wh_id
    AND l.dwh_actual_fg = 1
    AND l.active_fg = 1
    AND l.bges_active_fg = 1

INNER JOIN P_LEW_CORE_AC.v_item_hist_1 d
    ON mov.client_id = d.client_id
    AND mov.item_sid = d.item_sid
    AND d.deleted_fg = 0
    AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to

LEFT JOIN P_LEW_CORE_AC.v_item_type_1 itm
    ON itm.client_id = d.client_id
    AND itm.item_type_sid = d.item_type_sid
/* Artikel_1 die zu ignorieren sind  */
LEFT JOIN P_LEW_PROCESS_AC.v_item_type_ignore_1 ig
    ON ig.client_id = d.client_id
    AND ig.item_type_cd = itm.src_mtart
    AND 
      (
        (
         ig.client_id IN (33, 34) 
         AND ig.item_type_cd  NOT IN ('ZKM', 'ZVM')
        )
        OR ig.client_id NOT IN (33, 34)
      ) 
    AND ig.item_type_grp_cd IN ('BAGLEVY', 'INV')

WHERE mov.move_type_cd IN  ('911', '912', '913', '914', '921', '922', '923', '924', '925', '926', '927', '928', '963', '964', '987', '988')
AND ig.item_type_cd IS NULL  /* Ungefilterte Artikelarten */
GROUP BY 1,2,3,4,5
;