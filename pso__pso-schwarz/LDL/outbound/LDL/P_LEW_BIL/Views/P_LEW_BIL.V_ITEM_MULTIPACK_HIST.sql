CREATE OR REPLACE VIEW ldl_p_lew_bil.v_item_multipack_hist AS WITH ALL_ITEM_SIDS AS (SELECT C.item_sid,
   C.src_orig_item_nr,
   C.src_case_size,
   A.rel_item_sid,
   A.item_rel_rate,
   A.item_rel_type_cd,
   A.client_id,
   A.deleted_fg,
   A.dwh_valid_from,
   A.dwh_valid_to
  FROM ldl_p_lew_core_ac.v_item_relation_hist AS A
   INNER JOIN ldl_p_lew_precore.t_item_map_key_oin_cs_hist AS B ON A.item_sid = B.item_sid
   INNER JOIN ldl_p_lew_precore.t_item_map_key_oin_cs_hist AS C ON B.src_orig_item_nr = C.src_orig_item_nr AND A.client_id
      = C.client_id), MULTIPACK_NOT_DEDUPED AS (SELECT a.item_sid,
   a.src_orig_item_nr,
   a.src_case_size,
   a.rel_item_sid,
   a.item_rel_rate,
   a.client_id,
   FAM.sub_item_grp_cd,
   a.dwh_valid_from,
   a.dwh_valid_to
  FROM ALL_ITEM_SIDS AS a
   INNER JOIN ldl_p_lew_precore.t_item_map_key_oin_cs_hist AS C0 ON a.rel_item_sid = C0.item_sid AND a.dwh_valid_to
     BETWEEN C0.dwh_valid_from AND C0.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS ITMH ON a.client_id = ITMH.client_id AND a.item_sid = ITMH.item_sid AND
     CURRENT_DATE BETWEEN ITMH.dwh_valid_from AND ITMH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS FAM ON ITMH.client_id = FAM.client_id AND ITMH.item_fam_grp_sid
       = FAM.item_fam_grp_sid AND CURRENT_DATE BETWEEN FAM.dwh_valid_from AND FAM.dwh_valid_to
  WHERE a.deleted_fg = 0
   AND CAST(a.item_rel_type_cd AS FLOAT64) = 5
   AND a.src_orig_item_nr <> C0.src_orig_item_nr
   AND CAST(FAM.sub_item_grp_cd AS INTEGER) IN (61, 62, 63, 41)
   AND (CAST(FAM.sub_item_grp_cd AS FLOAT64) <> 63 OR FAM.client_id <> 23 OR a.dwh_valid_to >= DATE '2027-03-01')),
 BOUNDARIES AS (SELECT item_sid,
    dwh_valid_from AS boundary
   FROM MULTIPACK_NOT_DEDUPED AS a
   UNION DISTINCT
   SELECT item_sid,
    DATE_ADD(dwh_valid_to, INTERVAL 1 DAY) AS boundary
   FROM MULTIPACK_NOT_DEDUPED AS a), SEGMENTS AS (SELECT item_sid,
   boundary AS dwh_valid_from,
   boundary AS orig_dwh_valid_from,
   LEAD(boundary) OVER (PARTITION BY item_sid ORDER BY boundary NULLS LAST) AS dwh_valid_to
  FROM BOUNDARIES), NOT_REDUCED AS (SELECT s.item_sid,
   t1.src_orig_item_nr,
   t1.src_case_size,
   t1.rel_item_sid,
   MIN(t1.item_rel_rate) OVER (PARTITION BY s.item_sid, s.dwh_valid_from RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS item_rel_rate,
   MAX(t1.item_rel_rate) OVER (PARTITION BY s.item_sid, s.dwh_valid_from RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS max_item_rel_rate,
   t1.client_id,
   MAX(t1.sub_item_grp_cd) OVER (PARTITION BY s.item_sid, s.dwh_valid_from RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS sub_item_grp_cd,
   s.orig_dwh_valid_from,
   s.dwh_valid_from,
   DATE_SUB(s.dwh_valid_to, INTERVAL 1 DAY) AS dwh_valid_to,
   ROW_NUMBER() OVER (PARTITION BY s.item_sid, s.dwh_valid_from ORDER BY s.dwh_valid_to DESC NULLS FIRST, t1.item_rel_rate
      NULLS LAST) AS row_num
  FROM SEGMENTS AS s
   LEFT JOIN MULTIPACK_NOT_DEDUPED AS t1 ON s.item_sid = t1.item_sid AND s.dwh_valid_from >= t1.dwh_valid_from AND s.dwh_valid_to
      <= DATE_ADD(t1.dwh_valid_to, INTERVAL 1 DAY)), ONLY_VALID_INTERVALS AS (SELECT item_sid,
   src_orig_item_nr,
   src_case_size,
   rel_item_sid,
   item_rel_rate,
   max_item_rel_rate,
   client_id,
   sub_item_grp_cd,
   orig_dwh_valid_from,
   dwh_valid_from,
   dwh_valid_to,
   row_num
  FROM NOT_REDUCED AS a
  WHERE dwh_valid_to IS NOT NULL
   AND row_num = 1) (SELECT client_id,
   item_sid,
   src_orig_item_nr,
   src_case_size,
    CASE
    WHEN client_id = 23 AND CAST(sub_item_grp_cd AS FLOAT64) = 63 AND dwh_valid_from < DATE '2027-03-01' AND
      dwh_valid_to >= DATE '2027-03-01'
    THEN '2027-03-01'
    WHEN dwh_valid_from >= DATE '2026-03-01'
    THEN CAST(dwh_valid_from AS STRING)
    WHEN (LAG(dwh_valid_to, 1, CAST('1900-01-01' AS DATE)) OVER (PARTITION BY item_sid ORDER BY dwh_valid_from
           NULLS LAST)) < DATE '2025-03-01' AND dwh_valid_from > DATE '2025-03-01' OR dwh_valid_from < DATE '2025-03-01'
        AND dwh_valid_to > DATE '2025-03-01'
    THEN '2025-03-01'
    ELSE CAST(dwh_valid_from AS STRING)
    END AS dwh_valid_from,
   dwh_valid_to,
   orig_dwh_valid_from,
   item_rel_rate,
   max_item_rel_rate
  FROM ONLY_VALID_INTERVALS
  WHERE item_rel_rate IS NOT NULL
   AND dwh_valid_to >= DATE '2025-03-01');