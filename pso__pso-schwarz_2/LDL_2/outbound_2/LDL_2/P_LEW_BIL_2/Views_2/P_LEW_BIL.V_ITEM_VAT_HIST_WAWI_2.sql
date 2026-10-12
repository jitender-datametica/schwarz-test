CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_vat_hist_wawi_2 AS SELECT W.client_id,
 W.item_sid,
 CAST(NULL AS STRING) AS country_pol_cd,
 W.vat_id,
 h.pct_vat AS vat_value,
 h.vat_desc AS vat_descr,
  CASE
  WHEN h.dat_rec_start > W.dat_rec_start
  THEN h.dat_rec_start
  ELSE W.dat_rec_start
  END AS dwh_valid_from,
  CASE
  WHEN h.dat_rec_end < W.dat_rec_end
  THEN h.dat_rec_end
  ELSE W.dat_rec_end
  END AS dwh_valid_to
FROM ldl_p_lew_core_ac.v_wawi_itm_item_2 AS W
 LEFT JOIN (SELECT client_id,
    vat_id,
    pct_vat,
    vat_desc,
    dat_rec_start,
    dat_rec_end
   FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS A
   UNION ALL
   SELECT A.client_id,
    A.vat_id,
    A.pct_vat,
    A.vat_desc,
    A.dat_rec_start,
    DATE_SUB(B.dat_rec_start, INTERVAL 1 DAY) AS dat_rec_end
   FROM ldl_p_lew_core_ac.v_wawi_ref_vat_2 AS A
    INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS B ON A.client_id = B.client_id AND A.vat_id = B.vat_id
     AND B.dat_rec_start BETWEEN DATE_ADD(A.dat_rec_start, INTERVAL 1 DAY) AND A.dat_rec_end
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS C ON B.client_id = C.client_id AND B.vat_id = C.vat_id AND
      C.dat_rec_start BETWEEN DATE_ADD(A.dat_rec_start, INTERVAL 1 DAY) AND (DATE_SUB(B.dat_rec_start, INTERVAL 1 DAY))
   WHERE A.language_id = 7
    AND C.client_id IS NULL
    AND A.client_id NOT IN (SELECT client_id
      FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2
      WHERE vat_id > 0)
   UNION ALL
   SELECT A.client_id,
    A.vat_id,
    A.pct_vat,
    A.vat_desc,
    DATE_ADD(B.dat_rec_end, INTERVAL 1 DAY) AS dat_rec_start,
     CASE
     WHEN DATE_SUB(C.dat_rec_start, INTERVAL 1 DAY) < A.dat_rec_end
     THEN DATE_SUB(C.dat_rec_start, INTERVAL 1 DAY)
     ELSE A.dat_rec_end
     END AS dat_rec_end
   FROM ldl_p_lew_core_ac.v_wawi_ref_vat_2 AS A
    INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS B ON A.client_id = B.client_id AND A.vat_id = B.vat_id
     AND B.dat_rec_end BETWEEN A.dat_rec_start AND (DATE_SUB(A.dat_rec_end, INTERVAL 1 DAY))
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS C ON B.client_id = C.client_id AND B.vat_id = C.vat_id AND
      B.dat_rec_start < C.dat_rec_start
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS D ON C.client_id = D.client_id AND C.vat_id = D.vat_id AND
      D.dat_rec_start BETWEEN B.dat_rec_start AND C.dat_rec_start
   WHERE A.language_id = 7
    AND D.client_id IS NULL
    AND A.client_id NOT IN (SELECT client_id
      FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2
      WHERE vat_id > 0)
   UNION ALL
   SELECT A.client_id,
    A.vat_id,
    A.pct_vat,
    A.vat_desc,
    A.dat_rec_start,
    A.dat_rec_end
   FROM ldl_p_lew_core_ac.v_wawi_ref_vat_2 AS A
    LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS B ON A.client_id = B.client_id AND A.vat_id = B.vat_id AND
       A.dat_rec_start <= B.dat_rec_end AND A.dat_rec_end >= B.dat_rec_start
   WHERE A.language_id = 7
    AND B.client_id IS NULL
    AND A.client_id NOT IN (SELECT client_id
      FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2
      WHERE vat_id > 0)) AS h ON W.client_id = h.client_id AND W.vat_id = h.vat_id AND W.dat_rec_end >= h.dat_rec_start
  AND W.dat_rec_start <= h.dat_rec_end;