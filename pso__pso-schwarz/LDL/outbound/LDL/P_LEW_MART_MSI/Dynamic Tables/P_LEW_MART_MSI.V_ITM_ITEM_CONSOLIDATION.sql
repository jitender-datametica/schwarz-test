
CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_itm_item_consolidation
AS
-- Auflösung WH
 SELECT i.client_id,
 WH.src_wh_id AS wh_id,
 i.item_sid AS item_id,
 i.itm_consgrp_id,
 i.cons_item_id,
  CASE
  WHEN i.itm_consgrp_id = - 1
  THEN A.orig_item_nr
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS cons_orig_item_nr,
  CASE
  WHEN i.itm_consgrp_id = - 1
  THEN A.dat_valid_from
  ELSE DATE '1900-01-01'
  END AS cons_dat_valid_from_item,
  CASE
  WHEN i.itm_consgrp_id = - 1
  THEN 0
  ELSE 1
  END AS cons_fg,
 CGP.itm_consgrp_desc,
 OID.item_desc
FROM (SELECT I1.client_id,
    I1.wh_loc_sid,
    I1.item_sid,
    C1.itm_consgrp_id,
    CAST(- 1 AS BIGNUMERIC) AS cons_item_id
   FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh AS I1
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_consolidation AS C1 ON I1.client_id = C1.client_id AND I1.item_sid = C1
       .item_sid AND I1.wh_loc_sid = C1.wh_loc_sid
   WHERE CURRENT_DATE BETWEEN C1.dat_rec_start AND C1.dat_rec_end
    AND CURRENT_DATE BETWEEN I1.dat_rec_start AND I1.dat_rec_end
   UNION ALL
   SELECT client_id,
    wh_loc_sid,
    item_sid,
    CAST(- 1 AS BIGNUMERIC) AS itm_consgrp_id,
    item_sid AS cons_item_sid
   FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh AS I2
   WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
    AND NOT EXISTS (SELECT 1
     FROM ldl_p_lew_core_ac.v_wawi_itm_item_consolidation AS C2
     WHERE I2.client_id = client_id
      AND I2.item_sid = item_sid
      AND I2.wh_loc_sid = wh_loc_sid
      AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end)) AS i
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON i.client_id = WH.client_id AND i.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act AS A ON i.client_id = A.client_id AND i.item_sid = A.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_consolidationgroup AS CGP ON i.client_id = CGP.client_id AND i.wh_loc_sid = CGP
     .wh_loc_sid AND i.itm_consgrp_id = CGP.itm_consgrp_id AND CURRENT_DATE BETWEEN CGP.dat_rec_start AND CGP.dat_rec_end
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_orig_item_desc_act AS OID ON i.client_id = OID.client_id AND A.orig_item_nr =
     OID.orig_item_nr AND A.dat_valid_from = OID.dat_valid_from AND i.client_id = OID.language_id;

