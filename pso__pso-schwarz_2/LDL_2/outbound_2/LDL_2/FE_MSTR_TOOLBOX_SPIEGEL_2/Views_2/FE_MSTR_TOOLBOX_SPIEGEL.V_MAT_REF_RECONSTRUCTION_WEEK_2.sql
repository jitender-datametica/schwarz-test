CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_ref_reconstruction_week_2 (storage_test_exec_sid, orig_store_nr,
test_week, reconstruction_week_fg, excluded_week_fg, compensation_week_fg) AS SELECT tr.storage_test_exec_sid,
 tr.orig_store_nr,
 tr.test_week,
 MAX(CASE
   WHEN tr.test_week = PA.reconstructin_week_list_graph
   THEN 1
   ELSE 0
   END) AS reconstruction_week_fg,
 MAX(CASE
   WHEN tr.test_week = PA.excluded_week_list_graph
   THEN 1
   ELSE 0
   END) AS excluded_week_fg,
  CASE
  WHEN tr.test_week = PA.test_week_comp
  THEN 1
  ELSE 0
  END AS compensation_week_fg
FROM (SELECT TR.storage_test_exec_sid,
   grp.orig_store_nr,
   grp.test_week
  FROM ldl_p_lew_core.t_storage_test_result_2 AS TR
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext_2 AS EXT ON TR.storage_test_exec_sid = EXT.storage_test_exec_sid
    
   INNER JOIN (SELECT GRP.storage_test_result_grp_sid,
     GRP.storage_test_result_grp_type_cd,
     LOC.src_orig_store_nr AS orig_store_nr,
     GRP.test_week
    FROM ldl_p_lew_core.t_storage_test_result_group_2 AS GRP
     INNER JOIN ldl_p_lew_core.t_location_2 AS LOC ON GRP.loc_sid_store = LOC.loc_sid
    WHERE UPPER(GRP.storage_test_result_grp_type_cd) = UPPER('Store')) AS grp ON TR.storage_test_result_grp_sid = grp.storage_test_result_grp_sid
    ) AS tr
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter_graph_2 AS PA ON tr.storage_test_exec_sid = PA.storage_test_exec_sid
    AND tr.orig_store_nr = PA.orig_store_nr
GROUP BY tr.storage_test_exec_sid,
 tr.orig_store_nr,
 tr.test_week,
 compensation_week_fg;