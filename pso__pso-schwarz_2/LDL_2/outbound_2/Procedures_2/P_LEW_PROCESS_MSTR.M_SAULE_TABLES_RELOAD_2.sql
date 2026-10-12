CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_saule_tables_reload()
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    TRUNCATE TABLE p_lew_process_mstr.t_pillar_2
  ''';
  EXECUTE IMMEDIATE '''
    INSERT INTO p_lew_process_mstr.t_pillar_2 ( pillar_id
    , pillar_name
    , main_pillar_id
    , dwh_created
    , dwh_updated) SELECT
    pillar_id,
    pillar_name,
    main_pillar_id,
    CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created,
    CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_2
    GROUP BY 1,2,3,4
  ''';

  EXECUTE IMMEDIATE '''
    TRUNCATE TABLE p_lew_process_mstr.t_main_pillar_2
  ''';
  EXECUTE IMMEDIATE '''
    INSERT INTO p_lew_process_mstr.t_main_pillar_2 ( main_pillar_id
    , main_pillar_name
    , dwh_created, dwh_updated) SELECT
    main_pillar_id,
    main_pillar_name,
    CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created,
    CAST(CURRENT_TIMESTAMP() AS DATETIME)AS dwh_updated
    FROM p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_2
    GROUP BY 1,2,3,4
  ''';

  EXECUTE IMMEDIATE '''
    TRUNCATE TABLE p_lew_process_mstr.t_itm_fam_pillar_map_2
  ''';
  EXECUTE IMMEDIATE '''
    INSERT INTO p_lew_process_mstr.t_itm_fam_pillar_map_2 ( client_id
    , item_familygroup_id
    , src_familygrp_cd
    , pillar_id) 
    SELECT
    ifg.client_id                                       AS client_id,
    COALESCE(ifg.src_familygrp_id, ifg.item_fam_grp_sid) AS item_familygroup_id,
    ifam.src_familygrp_cd                                AS src_familygrp_cd,
    ifam.pillar_id                                       AS pillar_id
    FROM p_lew_bil_ac.v_item_familygroup_2 AS ifg
    
    INNER JOIN p_lew_core_ac.v_subitemgroup_2 AS sig
    ON ifg.sub_item_grp_sid = sig.sub_item_grp_sid
    
    INNER JOIN p_lew_core_ac.v_subitemgroup_hist_2 AS sig_h
    ON sig.sub_item_grp_sid = sig_h.sub_item_grp_sid
    AND CURRENT_DATE("Europe/Berlin") BETWEEN sig_h.dwh_valid_from AND sig_h.dwh_valid_to
    
    INNER JOIN p_lew_core_ac.v_itemgroup_international_2 AS igri
    ON sig_h.item_grp_int_sid = igri.item_grp_int_sid
    
    INNER JOIN p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction_2 AS ifam
    ON ifg.src_familygrp_cd = ifam.src_familygrp_cd
    GROUP BY 1,2,3,4
  ''';

  COMMIT TRANSACTION;
END;
