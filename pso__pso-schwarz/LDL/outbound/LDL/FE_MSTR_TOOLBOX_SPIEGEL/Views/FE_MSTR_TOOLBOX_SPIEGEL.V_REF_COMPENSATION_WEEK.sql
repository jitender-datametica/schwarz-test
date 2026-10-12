/*
#----------------------------------------------------------------------------
# Description:
# Static view for Reporting.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     26.02.2024      Simeon Nikolaev          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_compensation_week (storage_test_exec_sid, orig_store_nr,
test_week, compensation_week_fg) AS SELECT DISTINCT main.storage_test_exec_sid,
 main.orig_store_nr,
 main.test_week,
  CASE
  WHEN cmpwk.test_week = main.test_week
  THEN 1
  ELSE 0
  END AS compensation_week_fg
FROM (SELECT DISTINCT TR.storage_test_exec_sid,
   grp.orig_store_nr,
   grp.test_week
  FROM ldl_p_lew_core.t_storage_test_result AS TR
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_storage_test_execution_ext AS EXT ON TR.storage_test_exec_sid = EXT.storage_test_exec_sid
    
   INNER JOIN (SELECT GRP.storage_test_result_grp_sid,
     GRP.storage_test_result_grp_type_cd,
     LOC.src_orig_store_nr AS orig_store_nr,
     GRP.test_week
    FROM ldl_p_lew_core.t_storage_test_result_group AS GRP
     INNER JOIN ldl_p_lew_core.t_location AS LOC ON GRP.loc_sid_store = LOC.loc_sid
    WHERE UPPER(GRP.storage_test_result_grp_type_cd) = UPPER('Store')) AS grp ON TR.storage_test_result_grp_sid = grp.storage_test_result_grp_sid
    ) AS main
 INNER JOIN (SELECT DISTINCT src.storage_test_exec_sid,
   src.orig_store_nr,
   src.test_week
  FROM (SELECT DISTINCT TR0.storage_test_exec_sid,
     grp.orig_store_nr,
     TR0.storage_test_result_grp_sid,
     grp.storage_test_result_grp_type_cd,
     grp.test_week
    FROM ldl_p_lew_core.t_storage_test_result AS TR0
     INNER JOIN (SELECT GRP0.storage_test_result_grp_sid,
       LOC0.src_orig_store_nr AS orig_store_nr,
       GRP0.storage_test_result_grp_type_cd,
       GRP0.test_week
      FROM ldl_p_lew_core.t_storage_test_result_group AS GRP0
       INNER JOIN ldl_p_lew_core.t_location AS LOC0 ON GRP0.loc_sid_store = LOC0.loc_sid
      WHERE UPPER(GRP0.storage_test_result_grp_type_cd) = UPPER('Store')
       AND GRP0.test_week <> - 1) AS grp ON TR0.storage_test_result_grp_sid = grp.storage_test_result_grp_sid) AS src
   INNER JOIN (SELECT storage_test_exec_sid,
     orig_store_nr,
     MAX(reconstruction_week) OVER (PARTITION BY CAST(storage_test_exec_sid AS STRING), CAST(orig_store_nr AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_reconstruction_week,
     analysis_start_week,
     excluded_week_header
    FROM ldl_fe_mstr_toolbox_spiegel.v_storage_test_result_parameter) AS ps ON src.storage_test_exec_sid = ps.storage_test_exec_sid
        AND src.orig_store_nr = ps.orig_store_nr AND src.test_week > ps.max_reconstruction_week AND src.test_week < CAST(ps.analysis_start_week AS FLOAT64)
     ) AS cmpwk ON main.storage_test_exec_sid = cmpwk.storage_test_exec_sid AND main.orig_store_nr = cmpwk.orig_store_nr;