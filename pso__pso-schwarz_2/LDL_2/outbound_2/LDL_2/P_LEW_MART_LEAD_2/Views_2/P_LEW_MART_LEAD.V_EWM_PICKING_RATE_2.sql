CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ewm_picking_rate_2 AS WITH TSK AS (SELECT work_package_sid,
   client_id,
   wh_loc_sid,
   wh_task_confirm_dt,
   wh_task_grp_nr,
   dest_handling_unit_nr,
   pick_case_qty,
   wh_task_confirm_tmsp,
   wh_task_start_tmsp,
   wh_task_nr,
   wh_sub_task_nr
  FROM ldl_p_lew_core.t_warehouse_pick_item_task_2
  WHERE wh_task_status_cd = 'C'
   AND wh_task_activity_type_cd = 'PICK'), WHO AS (SELECT work_package_sid,
   client_id,
   wh_loc_sid,
   work_package_grp_nr,
   work_package_nr /* add work_package_nr to count the amount of orders for EWM warehouses */,
   work_package_start_tmsp,
   work_package_confirm_tmsp
  FROM ldl_p_lew_core.t_warehouse_work_package_2), HU AS (SELECT DISTINCT t_warehouse_pick_handling_unit_task.pick_handling_unit_task_nr
   ,
   t_warehouse_pick_handling_unit_task.pick_handling_unit_sub_task_nr,
   t_warehouse_pick_handling_unit_task.work_package_sid,
   t_warehouse_pick_handling_unit_task.client_id,
   t_warehouse_pick_handling_unit_task.wh_loc_sid,
   t_warehouse_pick_handling_unit_task.wh_task_confirm_tmsp,
   t_warehouse_pick_handling_unit_task.wh_task_grp_nr,
   t_warehouse_pick_handling_unit_task.dest_handling_unit_nr,
   t_warehouse_pick_handling_unit_task.handling_unit_type_cd,
   t_ref_pallet_type.pallet_type_factor,
   t_ref_pallet_type.pallet_type_cd,
   ROW_NUMBER() OVER (PARTITION BY CAST(t_warehouse_pick_handling_unit_task.work_package_sid AS STRING), CAST(t_warehouse_pick_handling_unit_task.client_id AS STRING)
      , CAST(t_warehouse_pick_handling_unit_task.wh_loc_sid AS STRING), t_warehouse_pick_handling_unit_task.wh_task_grp_nr
      , t_warehouse_pick_handling_unit_task.dest_handling_unit_nr ORDER BY t_warehouse_pick_handling_unit_task.wh_task_confirm_tmsp
      IS NULL, t_warehouse_pick_handling_unit_task.wh_task_confirm_tmsp, t_warehouse_pick_handling_unit_task.pick_handling_unit_task_nr
      IS NULL DESC, t_warehouse_pick_handling_unit_task.pick_handling_unit_task_nr DESC,
      t_warehouse_pick_handling_unit_task.pick_handling_unit_sub_task_nr IS NULL DESC,
      t_warehouse_pick_handling_unit_task.pick_handling_unit_sub_task_nr DESC) AS grp_hu_tsk_last
  FROM ldl_p_lew_core.t_warehouse_pick_handling_unit_task_2
   LEFT JOIN ldl_p_lew_core.t_ref_handling_unit_type_2 ON t_warehouse_pick_handling_unit_task.client_id =
     t_ref_handling_unit_type.client_id AND t_warehouse_pick_handling_unit_task.handling_unit_type_cd =
     t_ref_handling_unit_type.handling_unit_type_cd
   LEFT JOIN ldl_p_lew_core.t_ref_pallet_type_2 ON t_ref_handling_unit_type.pallet_type_cd = t_ref_pallet_type.pallet_type_cd
    ), BRK AS (SELECT work_package_sid,
   client_id,
   wh_loc_sid,
   SUM(DATETIME_DIFF(work_break_end_tmsp, work_break_start_tmsp, SECOND)) AS work_break_time
  FROM ldl_p_lew_core.t_warehouse_work_break_2
  GROUP BY work_package_sid,
   client_id,
   wh_loc_sid), LKP AS (SELECT t_ref_work_group.wh_work_grp_nr,
   t_ref_work_group.wh_work_grp_descr,
   t_ref_uniform_pick_area.pick_area_nr,
   t_ref_uniform_pick_area.pick_area_descr,
   t_ref_pick_main_area.pick_main_area_nr,
   t_ref_pick_main_area.pick_main_area_descr
  FROM ldl_p_lew_core.t_ref_work_group_2
   INNER JOIN ldl_p_lew_core.t_ref_uniform_pick_area_2 ON t_ref_work_group.pick_area_nr = t_ref_uniform_pick_area.pick_area_nr
    
   INNER JOIN ldl_p_lew_core.t_ref_pick_main_area_2 ON t_ref_uniform_pick_area.pick_main_area_nr = t_ref_pick_main_area.pick_main_area_nr
    ) (SELECT t1.client_id,
   t1.wh_loc_sid,
   WH.src_wh_id AS wh_id,
   t1.work_package_sid,
   t1.wh_task_nr,
   t1.wh_sub_task_nr,
   t1.wh_task_confirm_dt,
   ROUND(CAST(CONCAT(SUBSTR(SUBSTR(CAST(t1.wh_task_confirm_dt AS STRING), 1, 20), 1, 4), SUBSTR(SUBSTR(CAST(t1.wh_task_confirm_dt AS STRING)
        , 1, 20), 6, 2)) AS BIGNUMERIC), 0) AS cy_month,
   ROUND(CAST(IF(LENGTH(SUBSTR(SAFE_CAST(EXTRACT(ISOWEEK FROM t1.wh_task_confirm_dt) as STRING), 1, 19)) = 2, CONCAT(EXTRACT(YEAR FROM t1.wh_task_confirm_dt), EXTRACT(ISOWEEK FROM t1.wh_task_confirm_dt)), CONCAT(EXTRACT(YEAR FROM t1.wh_task_confirm_dt), '0', EXTRACT(ISOWEEK FROM t1.wh_task_confirm_dt
        ))) AS BIGNUMERIC), 0) AS cy_week,
   t1.wh_task_grp_nr,
   t3.work_package_grp_nr,
   t3.work_package_nr,
   t1.pick_case_qty,
   t6.pallet_type_factor,
   t12.wh_work_grp_descr,
   t12.pick_area_nr,
   t12.pick_area_descr,
   t12.pick_main_area_nr,
   t12.pick_main_area_descr,
   t1.dest_handling_unit_nr,
   t6.handling_unit_type_cd,
   ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
      , t1.wh_task_confirm_dt, t1.wh_task_grp_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1.wh_task_confirm_tmsp, t1.wh_task_nr
      IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr) AS grp_who_first,
   ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
      , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1_2
      .wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr) AS
   grp_hu_first,
   ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
      , t1.wh_task_confirm_dt, t1.wh_task_grp_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL DESC, t1.wh_task_confirm_tmsp
      DESC, t1.wh_task_nr IS NULL DESC, t1.wh_task_nr DESC, t1.wh_sub_task_nr IS NULL DESC, t1.wh_sub_task_nr DESC) AS
   grp_who_last,
    CASE
    WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
          , t1.wh_task_confirm_dt, t1.wh_task_grp_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1.wh_task_confirm_tmsp,
          t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr)) = 1 AND t1.wh_task_grp_nr
       NOT IN ('WHO_CANCEL', 'WHO_SPLIT')
    THEN IFNULL(t3.work_package_start_tmsp, t1.wh_task_start_tmsp)
    WHEN t1.wh_task_grp_nr IN ('WHO_CANCEL', 'WHO_SPLIT') AND (ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING)
          , CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING), t1.wh_task_confirm_dt, t1.wh_task_grp_nr
          ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr
          IS NULL, t1.wh_sub_task_nr)) = 1
    THEN t1.wh_task_start_tmsp
    ELSE LAG(t1.wh_task_confirm_tmsp) OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
       ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr
       IS NULL, t1.wh_sub_task_nr)
    END AS pick_start_tmsp,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
          , t1.wh_task_confirm_dt, t1.wh_task_grp_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL DESC, t1.wh_task_confirm_tmsp
          DESC, t1.wh_task_nr IS NULL DESC, t1.wh_task_nr DESC, t1.wh_sub_task_nr IS NULL DESC, t1.wh_sub_task_nr DESC)
       ) = 1 AND t1.wh_task_grp_nr NOT IN ('WHO_CANCEL', 'WHO_SPLIT'), IFNULL(IFNULL(t3.work_package_confirm_tmsp, t6.wh_task_confirm_tmsp
      ), t1.wh_task_confirm_tmsp), t1.wh_task_confirm_tmsp) AS pick_end_tmsp,
   DATETIME_DIFF(IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL DESC, t1.wh_task_confirm_tmsp
           DESC, t1.wh_task_nr IS NULL DESC, t1.wh_task_nr DESC, t1.wh_sub_task_nr IS NULL DESC, t1.wh_sub_task_nr DESC
         )) = 1 AND t1.wh_task_grp_nr NOT IN ('WHO_CANCEL', 'WHO_SPLIT'), IFNULL(IFNULL(t3.work_package_confirm_tmsp, t6
       .wh_task_confirm_tmsp), t1.wh_task_confirm_tmsp), t1.wh_task_confirm_tmsp), CASE
     WHEN (ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1.wh_task_confirm_tmsp
           , t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr)) = 1 AND t1.wh_task_grp_nr
        NOT IN ('WHO_CANCEL', 'WHO_SPLIT')
     THEN IFNULL(t3.work_package_start_tmsp, t1.wh_task_start_tmsp)
     WHEN t1.wh_task_grp_nr IN ('WHO_CANCEL', 'WHO_SPLIT') AND (ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING)
           , CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING), t1.wh_task_confirm_dt, t1.wh_task_grp_nr
           ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr
           IS NULL, t1.wh_sub_task_nr)) = 1
     THEN t1.wh_task_start_tmsp
     ELSE LAG(t1.wh_task_confirm_tmsp) OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
        ORDER BY t1.wh_task_confirm_tmsp IS NULL, t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr
        IS NULL, t1.wh_sub_task_nr)
     END, SECOND) AS work_time_sec,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
         , t1.wh_task_confirm_dt, t1.wh_task_grp_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL DESC, t1.wh_task_confirm_tmsp
         DESC, t1.wh_task_nr IS NULL DESC, t1.wh_task_nr DESC, t1.wh_sub_task_nr IS NULL DESC, t1.wh_sub_task_nr DESC))
     = 1, t10.work_break_time, NULL) AS sum_break_sec,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
         , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL,
         t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr)) =
     1, t6.pallet_type_factor, 0) AS pick_pallet_qty,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('AE', 'E', 'EP', 'EPAL', 'ZE') AND t6.pallet_type_factor <> 0, 1, 0) AS
   thm_1,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('DD', 'DPAL') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_2,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('CPOS', 'FR') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_3,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('BX') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_4,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('MT') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_5,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd NOT IN ('AE', 'E', 'EP', 'EPAL', 'ZE', 'DD', 'DPAL', 'CPOS', 'FR', 'BX', 'MT')
     AND t6.pallet_type_factor <> 0, 1, 0) AS thm_else,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('BB') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_bb,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('BD') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_bd,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('COHU') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_cohu,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('DTOT') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_dtot,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('EPOS') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_epos,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('ES') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_es,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('GMA') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_gma,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('HG') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_hg,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('HS') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_hs,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('IP') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_ip,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('QG') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_qg,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('QP') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_qp,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('SG') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_sg,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('SP') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_sp,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('TB') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_tb,
   IF((ROW_NUMBER() OVER (PARTITION BY CAST(t1.client_id AS STRING), CAST(t1.wh_loc_sid AS STRING), CAST(t1.work_package_sid AS STRING)
           , t1.wh_task_confirm_dt, t1.wh_task_grp_nr, t1.dest_handling_unit_nr ORDER BY t1.wh_task_confirm_tmsp IS NULL
           , t1.wh_task_confirm_tmsp, t1.wh_task_nr IS NULL, t1.wh_task_nr, t1.wh_sub_task_nr IS NULL, t1.wh_sub_task_nr
           )) = 1 AND t6.pallet_type_cd IN ('TOTE') AND t6.pallet_type_factor <> 0, 1, 0) AS thm_tote
  FROM TSK AS t1_2
   INNER JOIN ldl_p_lew_bil.t_warehouse_2 AS WH ON t1.client_id = WH.client_id AND t1.wh_loc_sid = WH.loc_sid_wh AND
      CURRENT_DATE BETWEEN WH.dwh_valid_from AND WH.dwh_valid_to AND (WH.active_fg <> 0)
   INNER JOIN WHO AS t3 ON t1.client_id = t3.client_id AND t1.wh_loc_sid = t3.wh_loc_sid AND t1.work_package_sid = t3.work_package_sid
     
   LEFT JOIN HU AS t6 ON t1.client_id = t6.client_id AND t1.wh_loc_sid = t6.wh_loc_sid AND t1.work_package_sid = t6.work_package_sid
         AND t1.wh_task_grp_nr = t6.wh_task_grp_nr AND t1.dest_handling_unit_nr = t6.dest_handling_unit_nr AND t6.grp_hu_tsk_last
      = 1
   LEFT JOIN BRK AS t10 ON t1.client_id = t10.client_id AND t1.wh_loc_sid = t10.wh_loc_sid AND t1.work_package_sid = t10
     .work_package_sid
   LEFT JOIN LKP AS t12 ON t1.wh_task_grp_nr = t12.wh_work_grp_nr);