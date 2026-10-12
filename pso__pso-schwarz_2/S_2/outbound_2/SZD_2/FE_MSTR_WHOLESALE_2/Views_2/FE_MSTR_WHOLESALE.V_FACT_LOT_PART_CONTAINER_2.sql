CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_fact_lot_part_container_2 (lot_part_prod_instance_group_sid, lot_nr,
container_resource_sid, lot_prod_instance_group_sid, gtin_nr, ship_destination_cd, total_ship_prod_qty,
shipped_product_qty, other_lots_in_container_cnt, other_lots_in_container_txt, total_ship_cont_prod_qty,
container_share_pct, produced_pcs_cnt, teu_share, carton_volume, eu_member_flag, container_dest_country_classification,
carton_volume_lot, container_share_volume) AS SELECT DISTINCT LPC.lot_part_product_instance_group_sid AS
 lot_part_prod_instance_group_sid,
 LPC.lot_nr,
 LPC.container_resource_item_sid AS container_resource_sid,
 LPC.lot_product_instance_group_sid AS lot_prod_instance_group_sid,
 LPC.gtin_nr,
 LPC.shipping_destination_cd AS ship_destination_cd,
 LPC.total_shipped_product_qty AS total_ship_prod_qty,
 LPC.shipped_product_qty,
 LPC.other_lots_in_container_cnt,
 LPC.other_lots_in_container_txt,
 LPC.total_shipped_container_product_qty AS total_ship_cont_prod_qty,
 LPC.container_share_pct,
  LP.piece_per_carton_qty * LPC.shipped_product_qty AS produced_pcs_cnt,
  LPC.container_share_pct * C.teu_qty AS teu_share,
    LP.length_m_meas * LP.width_m_meas * LP.height_m_meas * LPC.shipped_product_qty AS carton_volume,
  CASE
  WHEN COUNTRY_POL.eu_member_fg
  THEN 1
  ELSE 0
  END AS eu_member_flag,
  CASE
  WHEN (AVG(CASE
      WHEN COUNTRY_POL.eu_member_fg
      THEN 1
      ELSE 0
      END) OVER (PARTITION BY CAST(LPC.container_resource_item_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) = 1
  THEN 'Nur EU-Ware'
  WHEN (AVG(CASE
       WHEN COUNTRY_POL.eu_member_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY CAST(LPC.container_resource_item_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) > 0 AND (AVG(CASE
       WHEN COUNTRY_POL.eu_member_fg
       THEN 1
       ELSE 0
       END) OVER (PARTITION BY CAST(LPC.container_resource_item_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
      UNBOUNDED FOLLOWING)) < 1
  THEN 'Nicht EU-Ware & EU-Ware'
  WHEN (AVG(CASE
      WHEN COUNTRY_POL.eu_member_fg
      THEN 1
      ELSE 0
      END) OVER (PARTITION BY CAST(LPC.container_resource_item_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) = 0
  THEN 'Nur Nicht-EU-Ware'
  ELSE NULL
  END AS container_dest_country_classification,
 SUM(LP.length_m_meas * LP.width_m_meas * LP.height_m_meas * LPC.shipped_product_qty) OVER (PARTITION BY CAST(LPC.container_resource_item_sid AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS carton_volume_lot,
 IF((SUM(LP.length_m_meas * LP.width_m_meas * LP.height_m_meas * LPC.shipped_product_qty) OVER (PARTITION BY CAST(LPC.container_resource_item_sid AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0, SAFE_DIVIDE(LP.length_m_meas * LP.width_m_meas
       * LP.height_m_meas * LPC.shipped_product_qty, SUM(LP.length_m_meas * LP.width_m_meas * LP.height_m_meas * LPC.shipped_product_qty
     ) OVER (PARTITION BY CAST(LPC.container_resource_item_sid AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING))) AS container_share_volume
FROM szd_core.t_fact_lot_lot_part_container_2 AS LPC
 LEFT JOIN szd_core.t_dim_lot_part_2 AS LP ON LPC.lot_part_product_instance_group_sid = LP.product_instance_group_sid AND
    LPC.lot_product_instance_group_sid = LP.lot_product_instance_group_sid AND LPC.shipping_destination_cd = LP.shipping_destination_cd
   
 LEFT JOIN szd_core.t_dim_container_2 AS C ON LPC.container_resource_item_sid = C.resource_item_sid
 INNER JOIN szd_core.t_dim_country_political_2 AS COUNTRY_POL ON CASE
   WHEN LPC.shipping_destination_cd IN ('SpareItems', 'CON')
   THEN '-1'
   WHEN LENGTH(LPC.shipping_destination_cd) = 3 AND CASE
      WHEN REGEXP_CONTAINS(LPC.shipping_destination_cd, r'K')
      THEN LENGTH(REGEXP_REPLACE(LPC.shipping_destination_cd, CONCAT('(.*?)', 'K', '(.*)'), '\\1')) + 1
      ELSE 0
      END = 1
   THEN RIGHT(LPC.shipping_destination_cd, 2)
   WHEN LENGTH(LPC.shipping_destination_cd) = 3 AND CASE
       WHEN REGEXP_CONTAINS(LPC.shipping_destination_cd, r'K')
       THEN LENGTH(REGEXP_REPLACE(LPC.shipping_destination_cd, CONCAT('(.*?)', 'K', '(.*)'), '\\1')) + 1
       ELSE 0
       END = 0 AND LPC.shipping_destination_cd <> 'CON'
   THEN LEFT(LPC.shipping_destination_cd, 2)
   WHEN LENGTH(LPC.shipping_destination_cd) = 4 AND CASE
      WHEN REGEXP_CONTAINS(LPC.shipping_destination_cd, r'KO')
      THEN LENGTH(REGEXP_REPLACE(LPC.shipping_destination_cd, CONCAT('(.*?)', 'KO', '(.*)'), '\\1')) + 1
      ELSE 0
      END = 1
   THEN RIGHT(LPC.shipping_destination_cd, 2)
   WHEN LENGTH(LPC.shipping_destination_cd) = 4 AND CASE
      WHEN REGEXP_CONTAINS(LPC.shipping_destination_cd, r'OS')
      THEN LENGTH(REGEXP_REPLACE(LPC.shipping_destination_cd, CONCAT('(.*?)', 'OS', '(.*)'), '\\1')) + 1
      ELSE 0
      END = 1
   THEN RIGHT(LPC.shipping_destination_cd, 2)
   ELSE LPC.shipping_destination_cd
   END = COUNTRY_POL.iso_country_cd
WHERE LPC.dwh_valid_fg
 AND LP.dwh_valid_fg
 AND C.dwh_valid_fg
 AND COUNTRY_POL.dwh_valid_fg
 AND C.container_status_cd = 'A'
 AND LP.lot_part_status_cd = 'A';