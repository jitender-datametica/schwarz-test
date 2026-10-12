CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_vat_hist_sap_2 AS SELECT D.client_id,
 D.item_sid,
 D.country_pol_cd,
 COALESCE(H.vat_id, t3.vat_id) AS vat_id,
 COALESCE(H.pct_vat, t3.pct_vat) AS vat_value,
 COALESCE(H.vat_desc, t3.vat_desc) AS vat_descr,
 DATE_ADD(MIN(DATE_SUB(C.cal_dt, INTERVAL 1 DAY)), INTERVAL - 1 DAY) AS dwh_valid_from,
 MAX(C.cal_dt) AS dwh_valid_to
FROM ldl_p_lew_core_ac.v_item_tax_country_hist_2 AS D
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS B ON D.client_id = B.client_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS C ON C.cal_dt BETWEEN DATE '2006-03-01' AND (CURRENT_DATE) AND C.cal_dt
   BETWEEN D.dwh_valid_from AND D.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_map_mis_tax_class_2 AS G ON D.client_id = G.client_id AND D.tax_class_cd = G.tax_class_cd
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS H ON G.client_id = H.client_id AND G.mis_vat_id = H.vat_id
  AND C.cal_dt BETWEEN H.dat_rec_start AND H.dat_rec_end
 LEFT JOIN (SELECT client_id,
   vat_id,
   pct_vat,
   vat_desc,
   dat_rec_start,
   dat_rec_end
  FROM ldl_p_lew_core_ac.v_wawi_ref_vat_2
  WHERE language_id = 7
   AND client_id NOT IN (SELECT client_id
     FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2
     WHERE vat_id > 0)
  GROUP BY client_id,
   vat_id,
   dat_rec_start,
   dat_rec_end,
   vat_desc,
   pct_vat) AS t3 ON G.client_id = t3.client_id AND G.mis_vat_id = t3.vat_id AND C.cal_dt BETWEEN t3.dat_rec_start AND
   t3.dat_rec_end
 LEFT JOIN (SELECT F0.client_id,
   F0.item_sid,
   F0.dwh_valid_from,
   F0.dwh_valid_to,
   F0.country_pol_cd,
   COALESCE(SUBSTR(CAST(H2.dat_rec_start AS STRING), 1, 20), '19000101') AS dat_rec_start_h2,
   COALESCE(SUBSTR(CAST(H2.dat_rec_end AS STRING), 1, 20), '99991231') AS dat_rec_end_h2,
   COALESCE(SUBSTR(CAST(t8.dat_rec_start AS STRING), 1, 20), '19000101') AS dat_rec_start_i2,
   COALESCE(SUBSTR(CAST(t8.dat_rec_end AS STRING), 1, 20), '99991231') AS dat_rec_end_i2
  FROM ldl_p_lew_core_ac.v_item_tax_country_hist_2 AS F0
   LEFT JOIN ldl_p_lew_core_ac.v_map_mis_tax_class_2 AS G2 ON F0.client_id = G2.client_id AND F0.tax_class_cd = G2.tax_class_cd
     
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS H2 ON G2.client_id = H2.client_id AND G2.mis_vat_id = H2.vat_id
     
   LEFT JOIN (SELECT client_id,
     vat_id,
     pct_vat,
     vat_desc,
     dat_rec_start,
     dat_rec_end
    FROM ldl_p_lew_core_ac.v_wawi_ref_vat_2
    WHERE language_id = 7
     AND client_id NOT IN (SELECT client_id
       FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2
       WHERE vat_id > 0)
    GROUP BY client_id,
     vat_id,
     dat_rec_start,
     dat_rec_end,
     vat_desc,
     pct_vat) AS t8 ON G2.client_id = t8.client_id AND G2.mis_vat_id = t8.vat_id
  WHERE COALESCE(H2.vat_id, t8.vat_id) >= 0
   AND F0.deleted_fg = 0) AS f ON D.client_id = f.client_id AND D.item_sid = f.item_sid AND D.country_pol_cd <> B.country_cd
        AND (D.country_pol_cd > f.country_pol_cd OR B.country_cd = f.country_pol_cd) AND C.cal_dt BETWEEN f.dwh_valid_from
     AND f.dwh_valid_to AND C.cal_dt BETWEEN CAST(f.dat_rec_start_h2 AS DATE) AND (CAST(f.dat_rec_end_h2 AS DATE)) AND C
   .cal_dt BETWEEN CAST(f.dat_rec_start_i2 AS DATE) AND (CAST(f.dat_rec_end_i2 AS DATE))
WHERE f.client_id IS NULL
 AND COALESCE(H.vat_id, t3.vat_id) >= 0
 AND D.deleted_fg = 0
 AND EXISTS (SELECT 1
  FROM ldl_p_lew_core_ac.v_item_tax_country_hist_2 AS U
  WHERE client_id = D.client_id
   AND item_sid = D.item_sid
   AND country_pol_cd <> D.country_pol_cd
   AND dwh_valid_from <= D.dwh_valid_to
   AND dwh_valid_to >= D.dwh_valid_from
   AND deleted_fg = 0)
GROUP BY D.client_id,
 D.item_sid,
 D.country_pol_cd,
 vat_id,
 vat_value,
 vat_descr
UNION ALL
SELECT D.client_id,
 D.item_sid,
 D.country_pol_cd,
 h.vat_id,
 h.pct_vat AS vat_value,
 h.vat_desc AS vat_descr,
  CASE
  WHEN D.dwh_valid_from > h.dat_rec_start
  THEN D.dwh_valid_from
  ELSE h.dat_rec_start
  END AS dwh_valid_from,
  CASE
  WHEN D.dwh_valid_to < h.dat_rec_end
  THEN D.dwh_valid_to
  ELSE h.dat_rec_end
  END AS dwh_valid_to
FROM ldl_p_lew_core_ac.v_item_tax_country_hist_2 AS D
 INNER JOIN ldl_p_lew_core_ac.v_client_2 AS B ON D.client_id = B.client_id
 LEFT JOIN ldl_p_lew_core_ac.v_map_mis_tax_class_2 AS G ON D.client_id = G.client_id AND D.tax_class_cd = G.tax_class_cd
 INNER JOIN (SELECT client_id,
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
      WHERE vat_id > 0)) AS h ON D.client_id = h.client_id AND (G.mis_vat_id = h.vat_id OR D.tax_class_cd IS NOT NULL
        AND G.mis_vat_id IS NULL AND h.vat_id = - 1) AND D.dwh_valid_to >= h.dat_rec_start AND D.dwh_valid_from <= h.dat_rec_end
   
WHERE h.vat_id >= - 1
 AND D.deleted_fg = 0
 AND NOT EXISTS (SELECT 1
  FROM ldl_p_lew_core_ac.v_item_tax_country_hist_2 AS U
  WHERE client_id = D.client_id
   AND item_sid = D.item_sid
   AND country_pol_cd <> D.country_pol_cd
   AND dwh_valid_from <= D.dwh_valid_to
   AND dwh_valid_to >= D.dwh_valid_from
   AND deleted_fg = 0);