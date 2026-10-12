  /*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_prisma_salesq_1
#----------------------------------------------------------------------------
# History:
#  1.0  29.04.2022    Ross, Ulrich            Init
#  1.1  01.07.2022    Ross, Ulrich            Add view v_client_migration_per_1 to seperate eLWIS and WAWI
#  1.2  10.11.2022    Ross, Ulrich            Anpassen Berechnung sales_piece_qty u. sales_weight_qty
#  1.3  09.01.2022    Ross, Ulrich            Anpassen Logik bei View v_client_migration_per_1
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_prisma_salesq_1 (
    client_id
  , store_id
  , dat_formdate
  , uhrzeit
  , cashier_id
  , int_itemgroup_cd
  , subitemgroup_id
  , sales_q
  , dwh_created
) AS
SELECT
  erg.client_id
, erg.store_id
, erg.dat_formdate
, erg.uhrzeit
, erg.cashier_id
, erg.int_itemgroup_cd
, CAST(erg.subitemgroup_id AS INTEGER) AS subitemgroup_id
, ZeroIfNull(CAST(erg.sales_piece_qty + erg.sales_weight_qty AS DECIMAL(19,5))) AS sales_q
, erg.dwh_created
FROM
(
  /*
  # Nur EU Daten #
  # In der View v_pos_receiptline_1 ist die Spalte pos.main_item_grp_cd mit dem main_item_grp_cd befüllt.
  # Für US Daten ist die Spalte pos.main_item_grp_cd aber mit dem SubItemGroup Code befüllt
  */
  SELECT
    pos.client_id AS client_id
  , pos.loc_sid AS store_id
  , pos.dwh_cal_dt AS dat_formdate
  , CASE WHEN HOUR(CAST(pos.receipt_tmsp AS TIME(6)))<=9 THEN '0'||TO_CHAR(HOUR (CAST(pos.receipt_tmsp AS TIME(6)))) ELSE TO_CHAR(HOUR (CAST(pos.receipt_tmsp AS TIME(6)))) END || ':' ||
               CASE WHEN MINUTE(CAST(pos.receipt_tmsp AS TIME(6))) < 15 THEN '00'
         WHEN MINUTE(CAST(pos.receipt_tmsp AS TIME(6))) < 30 THEN '15'
         WHEN MINUTE(CAST(pos.receipt_tmsp AS TIME(6))) < 45 THEN '30'
           ELSE '45' 
    END AS uhrzeit   
  
  , pos.cashier_id
  , item.int_itemgroup_cd AS int_itemgroup_cd
  , item.subitemgroup_id
   ,SUM (CASE	
   WHEN pos.weight_item_fg = 0	
   THEN pos.sales_piece_qty	
   ELSE 0	
   END) AS sales_piece_qty	
  ,SUM(CASE	
   WHEN pos.weight_item_fg = 1	
   THEN pos.sales_weight_qty	
   ELSE 0	
   END) AS sales_weight_qty 
  , pos.dwh_created
  
  FROM p_lew_core_ac.v_pos_receiptline_1 AS pos	
  
  INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS cmp  
  ON cmp.client_id = pos.client_id
  AND cmp.active_fg = 0
  AND (pos.dwh_cal_dt > cmp.migration_dat_valid_to 
        OR cmp.migration_dat_valid_from = cmp.migration_dat_valid_to)
  
    
  INNER JOIN (  SELECT item.client_id, item.item_sid, item.subitemgroup_id, sig.int_itemgroup_cd
                FROM p_lew_mart_cs.v_gen_item_asis_1 AS item_1
                INNER JOIN p_lew_mart_cs.v_cs_subitemgroup_1 AS sig
                  ON item.client_id = sig.client_id
                  AND item.subitemgroup_id = sig.subitemgroup_cd
                GROUP BY item.client_id, item.item_sid, item.subitemgroup_id, sig.int_itemgroup_cd
            ) AS item_1
  ON pos.client_id = item.client_id
  AND pos.item_sid = item.item_sid  
  WHERE pos.turnover_relevant_fg = 1	
  GROUP BY 1,2,3,4,5,6,7,10
 UNION ALL
  
  /*
  # Nur US Daten #
  */
  SELECT
    pos.client_id AS client_id
  , pos.loc_sid AS store_id
  , pos.dwh_cal_dt AS dat_formdate
  , CASE WHEN HOUR(CAST(pos.receipt_tmsp AS TIME(6)))<=9 THEN '0'||TO_CHAR(HOUR (CAST(pos.receipt_tmsp AS TIME(6)))) ELSE TO_CHAR(HOUR (CAST(pos.receipt_tmsp AS TIME(6)))) END || ':' ||
               CASE WHEN MINUTE(CAST(pos.receipt_tmsp AS TIME(6))) < 15 THEN '00'
         WHEN MINUTE(CAST(pos.receipt_tmsp AS TIME(6))) < 30 THEN '15'
         WHEN MINUTE(CAST(pos.receipt_tmsp AS TIME(6))) < 45 THEN '30'
           ELSE '45' 
    END AS uhrzeit  
  , pos.cashier_id
  , sig.int_itemgroup_cd AS int_itemgroup_cd   
  , pos.main_item_grp_cd AS subitemgroup_id
   ,SUM (CASE	
   WHEN pos.weight_item_fg = 0	
   THEN pos.sales_piece_qty	
   ELSE 0	
   END) AS sales_piece_qty	
  ,SUM(CASE	
   WHEN pos.weight_item_fg = 1	
   THEN pos.sales_weight_qty	
   ELSE 0	
   END) AS sales_weight_qty   
  , pos.dwh_created  
  
  FROM p_lew_core_ac.v_pos_receiptline_1 AS pos
  INNER JOIN p_lew_core_ac.v_client_migration_per_1 AS cmp  
  ON cmp.client_id = pos.client_id
  AND pos.dwh_cal_dt BETWEEN cmp.migration_dat_valid_from AND cmp.migration_dat_valid_to
    
  INNER JOIN ( SELECT client_id, mainitemgroup_cd,subitemgroup_cd,int_itemgroup_cd
               FROM p_lew_mart_cs.v_cs_subitemgroup_1
                  GROUP BY client_id,mainitemgroup_cd,subitemgroup_cd,int_itemgroup_cd
              ) AS sig
  ON pos.client_id = sig.client_id
    AND pos.main_item_grp_cd = sig.subitemgroup_cd 
     
  WHERE pos.turnover_relevant_fg = 1	
  GROUP BY 1,2,3,4,5,6,7,10
) AS erg 
;