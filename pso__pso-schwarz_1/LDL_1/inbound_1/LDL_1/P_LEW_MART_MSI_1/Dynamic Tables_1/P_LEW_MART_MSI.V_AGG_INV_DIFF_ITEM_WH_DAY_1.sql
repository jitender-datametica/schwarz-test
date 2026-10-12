CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_INV_DIFF_ITEM_WH_DAY_1
(
    client_id                      
    ,loc_sid                        
    ,wh_id                          
    ,item_id                       
    ,dat_formdate                  
    ,inv_diff_total_piece          
    ,inv_diff_total_val             
    ,inv_diff_total_net_val         
    ,inv_diff_type_a_piece      
    ,inv_diff_type_a_val         
    ,inv_diff_type_a_net_val    
    ,inv_diff_type_b_piece        
    ,inv_diff_type_b_val       
    ,inv_diff_type_b_net_val
    ,inv_diff_type_x_piece  
    ,inv_diff_type_x_val     
    ,inv_diff_type_x_net_val     
    ,inv_diff_type_oth_piece  
    ,inv_diff_type_oth_val  
    ,inv_diff_type_oth_net_val 
) 

TARGET_LAG = '1 hour, 30 minutes' -- dummy_1 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS

SELECT
    inv.client_id
    ,inv.loc_sid
    ,wh.wh_id                                 AS wh_id
    ,inv.item_sid                             AS item_id
    ,inv.dwh_cal_dt                           AS dat_formdate
    ,SUM(COALESCE(inv.inv_diff_qty,0))        AS inv_diff_total_piece
    ,SUM(COALESCE(inv.inv_diff_gross_val,0))  AS inv_diff_total_val
    ,SUM(COALESCE(inv.inv_diff_net_val,0))    AS inv_diff_total_net_val
    ,SUM(CASE WHEN inv.inv_type_cd = 'A'
    THEN COALESCE(inv.inv_diff_qty,0)
    ELSE 0 END)                               AS inv_diff_type_a_piece
    ,SUM(CASE WHEN inv.inv_type_cd = 'A'
    THEN COALESCE(inv.inv_diff_gross_val,0)
    ELSE 0 END)                               AS inv_diff_type_a_val
    ,SUM(CASE WHEN inv.inv_type_cd = 'A'
    THEN COALESCE(inv.inv_diff_net_val,0)
    ELSE 0 END)                               AS inv_diff_type_a_net_val
    ,SUM(CASE WHEN inv.inv_type_cd = 'B'
    THEN COALESCE(inv.inv_diff_qty,0)
    ELSE 0 END)                               AS inv_diff_type_b_piece
    ,SUM(CASE WHEN inv.inv_type_cd = 'B'
    THEN COALESCE(inv.inv_diff_gross_val,0)
    ELSE 0 END)                               AS inv_diff_type_b_val
    ,SUM(CASE WHEN inv.inv_type_cd = 'B'
    THEN COALESCE(inv.inv_diff_net_val,0)
    ELSE 0 END)                               AS inv_diff_type_b_net_val
    ,SUM(CASE WHEN inv.inv_type_cd = 'X'
    THEN COALESCE(inv.inv_diff_qty,0)
    ELSE 0 END)                               AS inv_diff_type_x_piece
    ,SUM(CASE WHEN inv.inv_type_cd = 'X'
    THEN COALESCE(inv.inv_diff_gross_val,0)
    ELSE 0 END)                               AS inv_diff_type_x_val
    ,SUM(CASE WHEN inv.inv_type_cd = 'X'
    THEN COALESCE(inv.inv_diff_net_val,0)
    ELSE 0 END)                               AS inv_diff_type_x_net_val
    ,SUM(CASE WHEN (inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'X'))
    THEN COALESCE(inv.inv_diff_qty,0)
    ELSE 0 END)                               AS inv_diff_type_oth_piece
    ,SUM(CASE WHEN (inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'X'))
    THEN COALESCE(inv.inv_diff_gross_val,0)
    ELSE 0 END)                               AS inv_diff_type_oth_val
    ,SUM(CASE WHEN (inv.inv_type_cd IS NULL OR inv.inv_type_cd NOT IN ('A', 'B', 'X'))
    THEN COALESCE(inv.inv_diff_net_val,0)
    ELSE 0 END)                               AS inv_diff_type_oth_net_val
FROM
(
/* Die Daten aus dem SAP MM_1, WM_1 und EWM kommen alle aus der Tabelle t_inv_diff_record_pos_1  */
/* only takes the warehouse records from t_inv_diff_record_pos_1 */
SELECT
    si.client_id
    ,si.loc_sid
    ,si.item_sid
    ,si.dwh_cal_dt
    ,si.curr_sid
    ,si.inv_type_cd
    ,si.inv_diff_qty
    ,si.inv_diff_gross_val
    ,si.inv_diff_net_val
FROM P_LEW_CORE_AC.v_inv_diff_record_pos_1 AS si

INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS l
    ON   si.client_id    = l.client_id
    AND  si.loc_sid      = l.loc_sid_wh
    AND  l.dwh_actual_fg = 1
    AND l.active_fg      = 1
    AND l.bges_active_fg = 1

/* Nur die Bewegungsarten, welche Inventuren betreffen oder NULL */
WHERE (si.move_type_cd IN (701, 702, 703, 704, 707, 708, 711, 712, 717, 718) OR si.move_type_cd IS NULL)
) AS inv

INNER JOIN
    (
    /* Der fachlische WH-Schluessel wird herangezogen  */
    SELECT
        l_wh.client_id
        ,dwh_valid_from
        ,dwh_valid_to
        ,l_wh.loc_sid_wh
        ,org_wh.wh_id                 AS wh_id
        FROM P_LEW_BIL_AC.v_warehouse_1 AS l_wh
    /* Durch dAS joinen der v_org_wh_1 werden die in v_warehouse_1 fehlende Lager ergaenzt. */
    LEFT OUTER JOIN P_LEW_MART_MSI.v_org_wh_1  AS org_wh
        ON l_wh.client_id = org_wh.client_id
        AND l_wh.src_wh_id = org_wh.wh_id

    WHERE l_wh.dwh_actual_fg = 1
    AND l_wh.active_fg = 1
    AND l_wh.bges_active_fg = 1
    AND org_wh.wh_id IS NOT NULL
    ) AS wh
ON inv.client_id = wh.client_id
AND inv.loc_sid = wh.loc_sid_wh

INNER JOIN P_LEW_CORE_AC.v_item_hist_1 d
    ON inv.client_id = d.client_id
    AND inv.item_sid = d.item_sid
    AND d.deleted_fg = 0
    AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to

LEFT JOIN P_LEW_CORE_AC.v_item_type_1 itm
    ON itm.client_id = d.client_id
    AND itm.item_type_sid = d.item_type_sid
/* Artikel_1 die zu ignorieren sind, die der Artikelgruppe Baglevy und INV zugewiesen sind */
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

WHERE ig.item_type_cd IS NULL  /* Ungefilterte Artikelarten */
GROUP BY 1,2,3,4,5
;