/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_WE_DELTA_2
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_WE_DELTA_2 COMMENT = 'Wareneingaenge'
( 
  client_id              COMMENT 'Landeskennzeichen'
 ,country_lidl_cd        COMMENT 'ISO-Code Land_2'
 ,wh_id                  COMMENT 'Warehouse'
 ,orig_item_nr           COMMENT 'Artikelnummer'
 ,entry_dt               COMMENT 'Eingangsdatum'
 ,dat_min_durability_rcv COMMENT 'Haltbarkeitsdatum'
 ,receive_piece_qty      COMMENT 'Wareneingaenge'
)
AS

SELECT
  rec.client_id
 ,cli.src_country_lidl_cd
 ,rec.src_wh_id
 ,TRY_CAST(COALESCE(itm.src_orig_item_nr,itm.config_item_cd,itm.src_matnr) AS BIGINT)
 ,rec.entry_dt
 ,COALESCE(rec.dat_min_durability_rcv,sales.mini)
 ,SUM(CASE WHEN rec.status_tg>3 AND rec.receipt_pos_margin_rel_fg=1 AND rec.customer_nr IS NULL THEN rec.receive_piece_qty END)
FROM p_lew_bil_ac.v_mov_item_receive_wh_2 rec

INNER JOIN p_lew_core_ac.v_item_2 itm
ON itm.client_id=rec.client_id
AND itm.item_sid=rec.item_sid

INNER JOIN p_lew_core_ac.v_client_2 cli
ON cli.client_id=rec.client_id

LEFT JOIN
(
  p_lew_core.t_item_movement_record_pos_2 mov

  INNER JOIN
  (
    SELECT
      client_id
     ,TRY_CAST(ref_record_cd AS DECIMAL(20)) AS order_record_id
     ,ref_record_pos_id
     ,uom_cd_sales
     ,MIN(COALESCE(batchmin,nobatchmin))               AS mini
     ,MAX(COALESCE(batchmin,nobatchmin))               AS maxi
    FROM
    (
      SELECT
        client_id
       ,sales_receipt_record_cd
       ,item_sid
       ,ref_record_cd
       ,ref_record_pos_id
       ,uom_cd_sales
       ,SUM(CASE WHEN batch_cd IS NOT NULL THEN delivery_act_qty END)                          AS batchsum
       ,MIN(CASE WHEN batch_cd IS NOT NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END) AS batchmin
       ,MAX(CASE WHEN batch_cd IS NOT NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END) AS batchmax
       ,SUM(CASE WHEN batch_cd IS  NULL THEN delivery_act_qty END)                             AS nobatchsum
       ,MIN(CASE WHEN batch_cd IS NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END)     AS nobatchmin
       ,MAX(CASE WHEN batch_cd IS NULL THEN COALESCE(best_before_dt,DATE'1900-01-01') END)     AS nobatchmax
      FROM p_lew_core.t_sales_receipt_record_pos_2 

      WHERE delivery_act_qty<>0
      AND dwh_cal_dt
      >
      (
        SELECT 
          CASE WHEN COUNT(*)>0 THEN DATE'1900-01-01' ELSE CURRENT_DATE-180 END
        FROM p_lew_process_ac.v_wfm_export_specification_2 exspecs

        LEFT JOIN p_lew_process_ac.v_wfm_last_export_2 exlast
        ON exlast.export_specification=exspecs.export_specification
        AND exlast.process_name='export_wfm_we'
        AND exlast.process_specification='delta'

        WHERE exspecs.client_id IN(1,21,33,34)
        AND exlast.export_specification IS NULL
      )

      GROUP BY
        client_id
       ,sales_receipt_record_cd
       ,item_sid
       ,ref_record_cd
       ,ref_record_pos_id
       ,uom_cd_sales
      HAVING (batchsum<>0 AND batchmin>DATE'1900-01-01' AND batchmin=batchmax)
          OR (batchmin IS NULL AND nobatchsum<>0 AND nobatchmin>DATE'1900-01-01' AND nobatchmin=nobatchmax)
    ) x

    GROUP BY
      client_id
     ,TRY_CAST(ref_record_cd AS DECIMAL(20))
     ,ref_record_pos_id
     ,uom_cd_sales
    HAVING mini=maxi
  ) sales_2 
  ON sales.client_id=mov.client_id
  AND sales.order_record_id=mov.order_record_id
  AND sales.ref_record_pos_id=mov.order_record_pos_id
  AND sales.uom_cd_sales=mov.uom_cd_capt
)
ON mov.client_id=rec.client_id
AND mov.item_sid=rec.item_sid
AND mov.item_movement_record_id=rec.location_item_receipt_id
AND mov.item_movement_record_pos_id=rec.location_item_receipt_pos_id
AND mov.dwh_cal_dt=rec.entry_dt

INNER JOIN
(
  SELECT
    expospecs.client_id
   ,COALESCE(expolast.last_export_tmsp,CAST(DATE'1900-01-01' AS TIMESTAMP)) AS last_export_tmsp
  FROM p_lew_process_ac.v_wfm_export_specification_2 expospecs
  
  LEFT JOIN p_lew_process_ac.v_wfm_last_export_2 expolast
  ON expolast.export_specification = expospecs.export_specification
  AND expolast.process_name = 'export_wfm_we'
  AND expolast.process_specification = 'delta'
) expo
ON expo.client_id=rec.client_id
AND expo.last_export_tmsp<=rec.dwh_created

WHERE rec.receipt_type_id<=3

GROUP BY 
  rec.client_id
 ,cli.src_country_lidl_cd
 ,rec.src_wh_id
 ,TRY_CAST(COALESCE(itm.src_orig_item_nr,itm.config_item_cd,itm.src_matnr) AS BIGINT)
 ,rec.entry_dt
 ,COALESCE(rec.dat_min_durability_rcv,sales.mini)
;
