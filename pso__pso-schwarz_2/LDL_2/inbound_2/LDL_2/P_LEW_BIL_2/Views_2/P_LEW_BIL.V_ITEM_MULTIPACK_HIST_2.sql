create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_BIL.V_ITEM_MULTIPACK_HIST_2(
	CLIENT_ID,
	ITEM_SID,
	SRC_ORIG_ITEM_NR,
	SRC_CASE_SIZE,
	DWH_VALID_FROM,
	DWH_VALID_TO,
	ORIG_DWH_VALID_FROM,
	ITEM_REL_RATE,
	MAX_ITEM_REL_RATE
) as
(
 WITH all_item_sids  AS 
    ( 
    SELECT
            c.item_sid 
            ,c.src_orig_item_nr
            ,c.src_case_size
            ,a.rel_item_sid
            ,a.item_rel_rate
            ,a.ITEM_REL_TYPE_CD
            ,a.client_id
            ,a.deleted_fg
            ,a.dwh_valid_from
            ,a.dwh_valid_to
    FROM 
    P_LEW_CORE_AC.V_ITEM_RELATION_HIST_2 a
        INNER JOIN
            P_LEW_PRECORE.T_ITEM_MAP_KEY_OIN_CS_HIST_2 b
            ON a.item_sid = b.item_sid          
     INNER JOIN
            P_LEW_PRECORE.T_ITEM_MAP_KEY_OIN_CS_HIST_2 c
            ON c.src_orig_item_nr = b.src_orig_item_nr AND a.client_id=c.client_id
             
        )
,multipack_not_deduped AS (
        SELECT
            a.item_sid
            ,a.src_orig_item_nr
            ,a.src_case_size
            ,a.rel_item_sid
            ,a.item_rel_rate
            ,a.client_id
            ,fam.sub_item_grp_cd
            ,a.dwh_valid_from
            ,a.dwh_valid_to
        FROM
           all_item_sids a
        INNER JOIN
            P_LEW_preCORE.t_item_map_key_oin_cs_hist_2 c
            ON a.rel_item_sid = c.item_sid
            AND a.dwh_valid_to BETWEEN c.dwh_valid_from AND c.dwh_valid_to
        INNER JOIN
            p_lew_core_ac.v_item_hist_2 AS itmh
            ON a.client_id = itmh.client_id
            AND a.item_sid = itmh.item_sid 
            AND CURRENT_DATE BETWEEN itmh.dwh_valid_from AND itmh.dwh_valid_to
            
        INNER JOIN
            p_lew_core_ac.v_item_familygroup_hist_2 AS fam
            ON itmh.client_id = fam.client_id
            AND itmh.item_fam_grp_sid = fam.item_fam_grp_sid
            AND CURRENT_DATE BETWEEN fam.dwh_valid_from AND fam.dwh_valid_to
        WHERE
            a.deleted_fg = 0              
            AND a.item_rel_type_cd = 5    
            AND a.src_orig_item_nr <> c.src_orig_item_nr 
            AND 
            fam.sub_item_grp_cd IN (61, 62, 63, 41) 
            AND NOT (fam.sub_item_grp_cd=63 AND fam.client_id=23 AND a.dwh_valid_to<'2027-03-01')
    )
    ,boundaries AS (
SELECT   a.item_sid
      ,a.dwh_valid_from AS boundary
FROM multipack_not_deduped a
UNION  
SELECT 
a.item_sid
,dwh_valid_to+1 AS boundary FROM multipack_not_deduped a
)
, segments AS (
     
    SELECT
       item_sid
       ,boundary AS dwh_valid_from
       ,boundary AS orig_dwh_valid_from
       ,LEAD(boundary) OVER (
            PARTITION BY
                item_sid
            ORDER BY
                boundary
        ) AS dwh_valid_to
    FROM
        boundaries
)
,not_reduced AS (
    SELECT
         s.item_sid
          ,t1.src_orig_item_nr
           , t1.src_case_size
            ,t1.rel_item_sid
            ,MIN(t1.item_rel_rate) OVER (PARTITION BY s.item_sid, s.dwh_valid_from) AS item_rel_rate
            ,MAX(t1.item_rel_rate) OVER (PARTITION BY s.item_sid, s.dwh_valid_from) AS max_item_rel_rate
            ,t1.client_id
            ,MAX(t1.sub_item_grp_cd) OVER (PARTITION BY s.item_sid, s.dwh_valid_from) AS sub_item_grp_cd
            ,orig_dwh_valid_from
        ,s.dwh_valid_from
        ,s.dwh_valid_to - 1 AS dwh_valid_to 
       ,ROW_NUMBER() OVER (PARTITION BY 
            s.item_sid
            ,s.dwh_valid_from
            ORDER BY s.dwh_valid_to DESC
            ,item_rel_rate ASC
        ) AS row_num
    FROM
        segments s
        LEFT JOIN multipack_not_deduped t1_2 ON s.item_sid = t1.item_sid
        AND s.dwh_valid_from >= t1.dwh_valid_from
        AND s.dwh_valid_to <= t1.dwh_valid_to + 1
        )
 ,only_valid_intervals AS (
       SELECT *
        FROM
            not_reduced a
              WHERE dwh_valid_to IS NOT NULL AND row_num=1
    )
    SELECT
        client_id
        ,item_sid
        ,src_orig_item_nr
        ,src_case_size
        ,CASE 
            WHEN client_id=23 AND sub_item_grp_cd=63 AND dwh_valid_from<'2027-03-01' AND dwh_valid_to>='2027-03-01' THEN '2027-03-01' 
            WHEN dwh_valid_from >= '2026-03-01' THEN dwh_valid_from 
            WHEN LAG(dwh_valid_to, 1, '1900-01-01') OVER (PARTITION BY item_sid ORDER BY dwh_valid_from ASC) < '2025-03-01'
            AND dwh_valid_from > '2025-03-01' THEN '2025-03-01'
            WHEN dwh_valid_from < '2025-03-01' AND dwh_valid_to > '2025-03-01' THEN '2025-03-01'
            ELSE dwh_valid_from
        END AS dwh_valid_from
        ,dwh_valid_to
        ,orig_dwh_valid_from
        ,item_rel_rate
        ,max_item_rel_rate
    FROM
        only_valid_intervals
    WHERE item_rel_rate IS NOT NULL AND
        dwh_valid_to >= '2025-03-01'
);
