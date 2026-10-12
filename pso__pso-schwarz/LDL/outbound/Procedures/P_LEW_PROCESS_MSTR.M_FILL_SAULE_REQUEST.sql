CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_fill_saule_request(USERLOGIN STRING)
BEGIN

  
  EXECUTE IMMEDIATE """
    DELETE FROM p_lew_process_mstr.t_saule_config_comments WHERE TRUE
  """;

  
  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_process_mstr.t_saule_config_comments (comments, sort, sort2) 
    SELECT
      src_familygrp_cd || '   ' || item_fam_grp_name || '           ' || pillar_id || '  ' || pillar_name AS a,
      2 AS sort,
      60 AS sort2
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
    WHERE src_familygrp_cd IN (
        SELECT src_familygrp_cd
        FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
        GROUP BY 1
        HAVING COUNT(DISTINCT pillar_id) > 1
    )
    UNION ALL
    SELECT
      pillar_id || '  ' || pillar_name AS a,
      2 AS sort,
      30 AS sort2
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
    WHERE pillar_id IN (
        SELECT pillar_id
        FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
        GROUP BY 1
        HAVING COUNT(DISTINCT pillar_name) > 1
    )
    GROUP BY 1, 2
    
    UNION ALL
    SELECT
      pillar_id || '  ' || pillar_name AS a,
      2 AS sort,
      20 AS sort2
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
    WHERE pillar_name IN (
        SELECT pillar_name
        FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
        GROUP BY 1
        HAVING COUNT(DISTINCT pillar_id) > 1
    )
    GROUP BY 1, 2
    
    UNION ALL
    SELECT
      main_pillar_id || '  ' || main_pillar_name AS a,
      2 AS sort,
      50 AS sort2
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
    WHERE main_pillar_id IN (
        SELECT main_pillar_id
        FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
        GROUP BY 1
        HAVING COUNT(DISTINCT main_pillar_name) > 1
    )
    GROUP BY 1, 2
    
    UNION ALL
    SELECT
      main_pillar_id || '  ' || main_pillar_name AS a,
      2 AS sort,
      40 AS sort2
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
    WHERE main_pillar_name IN (
        SELECT main_pillar_name
        FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
        GROUP BY 1
        HAVING COUNT(DISTINCT main_pillar_id) > 1
    )
    GROUP BY 1, 2
    
    UNION ALL
    SELECT DISTINCT 
      pillar_id || '  ' || pillar_name || '    ' || main_pillar_id || ' ' || main_pillar_name AS a,
      2 AS sort,
      70 AS sort2
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
    WHERE pillar_id IN (
        SELECT pillar_id
        FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
        GROUP BY 1
        HAVING COUNT(DISTINCT main_pillar_id) > 1
    )
    
    UNION ALL
    SELECT DISTINCT 
      TRIM(a2.src_familygrp_cd) || ' ' || a2.item_family_desc || ' ->  ' || TRIM(a1.src_familygrp_cd) || ' ' || TRIM(a1.item_fam_grp_name) AS a,
      2 AS sort,
      10 AS sort2
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction a1
    INNER JOIN p_lew_mart_lead_ac.v_itm_familygroup_int a2 
      ON (TRIM(a1.src_familygrp_cd) = a2.src_familygrp_cd AND TRIM(a1.item_fam_grp_name) <> TRIM(a2.item_family_desc))
      OR (TRIM(a1.src_familygrp_cd) <> a2.src_familygrp_cd AND TRIM(a1.item_fam_grp_name) = TRIM(a2.item_family_desc))
    WHERE TRIM(a1.src_familygrp_cd) || ' ' || TRIM(a1.item_fam_grp_name) NOT IN (
        SELECT TRIM(a1.src_familygrp_cd) || ' ' || TRIM(a1.item_fam_grp_name)
        FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction a1
        INNER JOIN p_lew_mart_lead_ac.v_itm_familygroup_int a2
          ON TRIM(a1.src_familygrp_cd) = a2.src_familygrp_cd
          AND TRIM(a1.item_fam_grp_name) = TRIM(a2.item_family_desc)
    )
  """;

  
  EXECUTE IMMEDIATE """
INSERT INTO p_lew_process_mstr.t_saule_config_comments (comments, sort, sort2) 
    SELECT a1.a, sort, sort2
    FROM (SELECT 'Artikelfamilien können nur einer Säule zugeordnet werden                                                                                    ' AS a, 1 AS sort, 60 AS sort2) AS a1
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 60)
    
    UNION ALL
    SELECT a2.a, sort, sort2
    FROM (SELECT 'Es wurden Säulen mit nicht eindeutigem Namen gefunden. Jede Säule muss einen eindeutigen Namen haben' AS a, 1 AS sort, 30 AS sort2) AS a2
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 30)
    
    UNION ALL
    SELECT a3.a, sort, sort2
    FROM (SELECT 'Es wurden Säulen mit nicht eindeutiger ID gefunden. Jede Säule muss eine eindeutige ID haben' AS a, 1 AS sort, 20 AS sort2) AS a3
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 20)
    
    UNION ALL
    SELECT a4.a, sort, sort2
    FROM (SELECT 'Es wurden Obersäulen mit nicht eindeutigem Namen gefunden. Jede Obersäule muss einen eindeutigen Namen haben' AS a, 1 AS sort, 50 AS sort2) AS a4
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 50)
    
    UNION ALL
    SELECT a5.a, sort, sort2
    FROM (SELECT 'Es wurden Obersäulen mit nicht eindeutiger ID gefunden. Jede Obersäule muss eine eindeutige ID haben' AS a, 1 AS sort, 40 AS sort2) AS a5
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 40)
    
    UNION ALL
    SELECT a6.a, sort, sort2
    FROM (SELECT 'Säulen können nur einer Obersäule zugeordnet werden                                                                                    ' AS a, 1 AS sort, 70 AS sort2) AS a6
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 70)
    
    UNION ALL
    SELECT a7.a, sort, sort2
    FROM (SELECT 'Artikelfamily ID / Name kann nicht geändert werden' AS a, 1 AS sort, 10 AS sort2) AS a7
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 10)
    
    UNION ALL
    SELECT a8.a, sort, sort2
    FROM (SELECT 'Es wurden Datensätze mit fehlerhaften Konfigurationen gefunden:' AS a, 0 AS sort, 0 AS sort2) AS a8
    WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments)
    
    UNION ALL
    SELECT a9.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 20 AS sort2) AS a9 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 20)
    UNION ALL
    SELECT a10.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 30 AS sort2) AS a10 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 30)
    UNION ALL
    SELECT a11.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 40 AS sort2) AS a11 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 40)
    UNION ALL
    SELECT a12.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 50 AS sort2) AS a12 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 50)
    UNION ALL
    SELECT a13.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 60 AS sort2) AS a13 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 60)
    UNION ALL
    SELECT a14.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 70 AS sort2) AS a14 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 70)
    UNION ALL
    SELECT a15.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 0 AS sort2) AS a15 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 0)
    UNION ALL
    SELECT a16.a, sort, sort2 FROM (SELECT ' ' AS a, 0 AS sort, 10 AS sort2) AS a16 WHERE EXISTS (SELECT 1 FROM p_lew_process_mstr.t_saule_config_comments WHERE sort2 = 10)
  """;
/*this condition assures that if there are two artikelfamilies with the same the configuration still can be installed if the itemfamily_id-itemfamily_desc combination is correct (changed in Patchnumber:2580, 02-09-2020) */
-- before it was lew_mart_msi_ac.v_itm_familygroup_int
-- in new view we added combination   --trim(a2.subitemgroup_id)||'.'||trim(a2.family_cd)
-- in new view we added combination   --trim(a2.subitemgroup_id)||'.'||trim(a2.family_cd)


  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_process_mstr.t_saule_config_requests (req_id, status_id, req_date, requestor, approver, status_desc) 
    SELECT
      COALESCE(MAX(a.req_id), 0) + 1 AS req_id,
      COALESCE(verification.status, 1) AS status_id,
      CURRENT_DATE("Europe/Berlin") AS req_date,
      @userlogin AS requestor,
      CAST(NULL AS STRING) AS approver,
      CASE
        WHEN COALESCE(verification.status, 1) = 0 THEN 'Falsche Konfiguration'
        WHEN COALESCE(verification.status, 1) = 1 THEN 'Prüfung ausstehend'
        ELSE NULL 
      END AS status_desc
    FROM p_lew_process_mstr.t_saule_config_requests AS a
    CROSS JOIN (
      SELECT MAX(0) AS status
      FROM p_lew_process_mstr.t_saule_config_comments
    ) AS verification
    GROUP BY verification.status
  """ USING USERLOGIN AS userlogin;

  EXCEPTION WHEN ERROR THEN
    -- Raised exact message with || concatenation mapped from SF script
    RAISE USING MESSAGE = 'MESSAGE: ' || @@error.message;


END;