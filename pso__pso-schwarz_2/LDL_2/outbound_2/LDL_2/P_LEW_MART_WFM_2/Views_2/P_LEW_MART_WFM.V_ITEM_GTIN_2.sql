CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_gtin_2 (client_id, orig_item_nr, item_ean) AS SELECT *
FROM (SELECT SIG.client_id,
   imi.orig_itm_nr AS orig_item_nr,
   CAST(SIG.ean_2 AS STRING) AS item_ean
  FROM ldl_p_lew_core_ac.v_wawi_itm_ean_2 AS SIG
   INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON SIG.client_id = CL.client_id
   INNER JOIN (SELECT I.client_id,
     I.item_sid,
      CASE
      WHEN I.src_orig_item_nr IS NULL
      THEN COALESCE(ROUND(SAFE_CAST(I.config_item_cd AS BIGNUMERIC), 0), ROUND(SAFE_CAST(I.src_matnr AS BIGNUMERIC), 0)
       , CAST(I.src_orig_item_nr AS BIGNUMERIC))
      ELSE ROUND(CAST(I.src_orig_item_nr AS BIGNUMERIC), 0)
      END AS orig_itm_nr
    FROM ldl_p_lew_core_ac.v_item_2 AS I
     INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_2 AS W ON I.client_id = W.client_id AND I.item_sid = W.item_sid AND (W
          .item_status BETWEEN 5 AND 11 OR W.item_status BETWEEN 12 AND 13) AND CURRENT_DATE BETWEEN W.dat_rec_start AND
       W.dat_rec_end
     INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS A ON I.client_id = A.client_id AND I.item_sid = A.item_sid AND
        A.orig_item_nr > 0 AND A.status_id_hq NOT IN (1, 2, 15)
    GROUP BY I.client_id,
     I.item_sid,
     orig_itm_nr) AS imi ON SIG.client_id = imi.client_id AND SIG.item_sid = imi.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON SIG.client_id = MIG.client_id
  WHERE CURRENT_DATE BETWEEN SIG.dat_rec_start AND SIG.dat_rec_end
   AND ROUND(SAFE_CAST(SIG.ean_2 AS BIGNUMERIC), 0) > 0
   AND ROUND(CAST(SIG.ean_2 AS BIGNUMERIC), 0) = CAST(SIG.ean_2 AS FLOAT64)
   AND (CURRENT_DATE < MIG.migration_dat_valid_from OR CURRENT_DATE > MIG.migration_dat_valid_to)
  QUALIFY SIG.dat_rec_start = (MAX(SIG.dat_rec_start) OVER (PARTITION BY CAST(SIG.client_id AS STRING), SIG.ean_2
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS x
GROUP BY client_id,
 orig_item_nr,
 item_ean;