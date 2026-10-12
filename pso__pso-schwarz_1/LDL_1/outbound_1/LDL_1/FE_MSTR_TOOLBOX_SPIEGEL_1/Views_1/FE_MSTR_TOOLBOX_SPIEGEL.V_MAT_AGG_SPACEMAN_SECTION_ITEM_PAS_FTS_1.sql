CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_spaceman_section_item_pas_fts_1 (int_org_sid
OPTIONS(description='Internal Organisation ID'), spaceman_section_sid OPTIONS(description='Section ID'),
spaceman_item_sid OPTIONS(description='Spaceman item_1 ID'), cases
OPTIONS(description='Number of cases with condition for reusing in different columns esp. Potential 1 calculation - KOLLI'),
mult_pos_cases OPTIONS(description='Number of cases (Mehrfachstellungen) - KOLLI'), mult_pos_einzel
OPTIONS(description='Number of cases (Mehrfachstellungen) - EINZEL'), cases_einzel
OPTIONS(description='Number of individual items for reusing in different columns - EINZEL'), placing
OPTIONS(description='Placing of item_1 (EP DD Regal ...)'), item_merchandising_type_cd
OPTIONS(description='Item_1 merchandising type code Hand or Case'), cnt_item_1 OPTIONS(description='Number of item_1'),
cnt_cases OPTIONS(description='Number of cases KOLLI (Mehrfachstellungen)'), cnt_cases_einzel
OPTIONS(description='Number of cases EINZEL (Mehrfachstellungen)'), avg_kolli OPTIONS(description='Average kolli width'),
avg_einzel OPTIONS(description='Average einzel width'), avg_contact_distance_per_item
OPTIONS(description='Average contact_1 distance (width of the position) per item_1'), avg_facings_per_item
OPTIONS(description='Average facings per item_1'), potential_1 OPTIONS(description='Potential 1 (old calculation)'),
potential_1_in_cm OPTIONS(description='Potential 1 in cm KOLLI'), potential_1_in_cm_einzel
OPTIONS(description='Potential 1 in cm EINZEL'), cnt_facings OPTIONS(description='Number of facings'),
cnt_facings_reduced OPTIONS(description='Number of reduced facings KOLLI'), cnt_facings_reduced_einzel
OPTIONS(description='Number of reduced facings EINZEL'), capacity OPTIONS(description='Capacity of item_1'),
section_selection_id
OPTIONS(description='Technical column for export functionality in dashboard -> every section has one row for Yes and No'),
metric_system_id OPTIONS(description='Technical column for selection the measurement unit_1 for KPIs: cm or inches'),
pas_type OPTIONS(description='PAS TYPE - Packaged food or Refrigerated'), higher_meas
OPTIONS(description='Factor to calculate higher meas of measurement value e.g. cm to m -> divide by 100'), shelf_meter
OPTIONS(description='Shelf meter')) AS WITH ITEM_LIST AS (SELECT DISTINCT ITSPIT.spaceman_item_sid,
    ITEM.subitemgroup_id,
    'food' AS item_pas_type
   FROM ldl_fe_mstr_toolbox_spiegel.v_item_spaceman_item_1 AS ITSPIT
    INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_1 AS ITEM_1 ON ITSPIT.client_id = ITEM.client_id AND ITSPIT.item_sid = ITEM_1
      .item_id
   WHERE ITEM.subitemgroup_id IN (40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 54, 60, 61, 62, 63, 70, 71, 72, 73
      , 77, 80, 81, 82, 83, 84, 85)
   UNION ALL
   SELECT DISTINCT ITSPIT.spaceman_item_sid,
    ITEM.subitemgroup_id,
    'cool' AS item_pas_type
   FROM ldl_fe_mstr_toolbox_spiegel.v_item_spaceman_item_1 AS ITSPIT
    INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item_1 AS ITEM_1 ON ITSPIT.client_id = ITEM.client_id AND ITSPIT.item_sid = ITEM_1
      .item_id
   WHERE ITEM.subitemgroup_id IN (30, 31, 32, 33, 35, 36, 40, 41, 42, 43, 45, 48, 51, 61, 62, 63)), FACTS_AGGREGATED AS
  (SELECT SEC.int_org_sid,
   SEC.spaceman_section_sid,
   SPIT.spaceman_item_sid,
   SPITHIST.src_case_size,
   POSHIST.item_merchandising_type_cd,
   i.item_pas_type,
    CASE
    WHEN (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((60, 80), (80, 60))
    THEN 'DD'
    WHEN SEC.int_org_sid <> 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((120, 80), (SHELFHIST.shelf_width_meas
         , 120)) OR SEC.int_org_sid = 85 AND (SHELFHIST.shelf_width_meas, SHELFHIST.shelf_depth_meas) IN ((46, 48))
    THEN 'EP/GMA'
    ELSE 'Regal'
    END AS placing,
   SUM(CASE
     WHEN POSHIST.item_merchandising_type_cd = 'Case' AND POSHIST.case_orientation_cd = 'Front End'
     THEN SPITHIST.case_width_meas
     WHEN POSHIST.item_merchandising_type_cd = 'Case' AND POSHIST.case_orientation_cd = 'Side End'
     THEN SPITHIST.case_depth_meas
     ELSE 0
     END) AS kolli_width,
   SUM(CASE
     WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND POSHIST.case_orientation_cd = 'Front End'
     THEN SPITHIST.item_width_meas
     WHEN POSHIST.item_merchandising_type_cd = 'Hand' AND POSHIST.case_orientation_cd = 'Side End'
     THEN SPITHIST.item_depth_meas
     ELSE 0
     END) AS einzel_width,
   SUM(POSHIST.position_width_meas) AS position_width_meas,
   SUM(POSHIST.x_case_cnt) AS x_case_cnt,
   MAX(POSHIST.case_orientation_cd) AS case_orientation_cd,
   SUM(POSHIST.total_case_qty) AS total_case_qty
  FROM ldl_p_lew_core_ac.v_spaceman_section_1 AS SEC
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_hist_1 AS SECHIST ON SEC.spaceman_section_sid = SECHIST.spaceman_section_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf_1 AS SHELF ON SEC.spaceman_section_sid = SHELF.spaceman_section_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf_hist_1 AS SHELFHIST ON SHELF.shelf_sid = SHELFHIST.shelf_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_1 AS POS ON SHELF.shelf_sid = POS.shelf_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_hist_1 AS POSHIST ON POS.shelf_position_sid = POSHIST.shelf_position_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_item_1 AS SPIT ON POSHIST.spaceman_item_sid = SPIT.spaceman_item_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_item_hist_1 AS SPITHIST ON SPIT.spaceman_item_sid = SPITHIST.spaceman_item_sid
   INNER JOIN ITEM_LIST AS i ON SPIT.spaceman_item_sid = i.spaceman_item_sid
  WHERE CURRENT_DATE BETWEEN SECHIST.dwh_valid_from AND SECHIST.dwh_valid_to
   AND SECHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SHELFHIST.dwh_valid_from AND SHELFHIST.dwh_valid_to
   AND SHELFHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN POSHIST.dwh_valid_from AND POSHIST.dwh_valid_to
   AND POSHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SPITHIST.dwh_valid_from AND SPITHIST.dwh_valid_to
   AND SPITHIST.deleted_fg = 0
   AND CURRENT_DATE BETWEEN SPIT.active_from_dt AND SPIT.active_to_dt
  GROUP BY SEC.int_org_sid,
   SEC.spaceman_section_sid,
   SPIT.spaceman_item_sid,
   SPITHIST.src_case_size,
   POSHIST.item_merchandising_type_cd,
   i.item_pas_type,
   placing) (SELECT f.int_org_sid,
   f.spaceman_section_sid,
   f.spaceman_item_sid,
    CASE
    WHEN f.x_case_cnt = 0
    THEN 0
    WHEN f.total_case_qty - f.total_case_qty / f.x_case_cnt * (f.x_case_cnt - 1) >= 2
    THEN f.x_case_cnt - 1
    ELSE 0
    END AS cases,
   IF(f.x_case_cnt >= 2 AND f.item_merchandising_type_cd = 'Case', f.x_case_cnt - 1, 0) AS mult_pos_cases,
   IF(f.x_case_cnt >= 2 AND f.item_merchandising_type_cd = 'Hand', f.x_case_cnt - 1, 0) AS mult_pos_einzel,
    CASE
    WHEN f.x_case_cnt >= 2
    THEN f.x_case_cnt - 1
    ELSE 0
    END AS cases_einzel,
   f.placing,
   f.item_merchandising_type_cd,
   COUNT(DISTINCT f.spaceman_item_sid) AS cnt_item_1,
   SUM(CASE
     WHEN f.x_case_cnt = 0
     THEN 0
     WHEN f.total_case_qty - f.total_case_qty / f.x_case_cnt * (f.x_case_cnt - 1) >= 2
     THEN f.x_case_cnt - 1
     ELSE 0
     END) AS cnt_cases,
   SUM(CASE
     WHEN f.x_case_cnt >= 2
     THEN f.x_case_cnt - 1
     ELSE 0
     END) AS cnt_cases_einzel,
   SUM(IF(f.kolli_width = 0, NULL, f.kolli_width * OM.factor)) AS avg_kolli,
   SUM(IF(f.einzel_width = 0, NULL, f.einzel_width * OM.factor)) AS avg_einzel,
   SUM(f.position_width_meas * OM.factor) AS avg_contact_distance_per_item,
   SUM(IF(f.placing = 'Regal', f.x_case_cnt, 0)) AS avg_facings_per_item,
   SUM(IF(f.placing = 'Regal', CASE
      WHEN f.x_case_cnt = 0
      THEN 0
      WHEN f.total_case_qty - f.total_case_qty / f.x_case_cnt * (f.x_case_cnt - 1) >= 2
      THEN f.x_case_cnt - 1
      ELSE 0
      END, 0)) AS potential_1,
   SUM(IF(f.placing = 'Regal', f.kolli_width * CASE
        WHEN f.x_case_cnt = 0
        THEN 0
        WHEN f.total_case_qty - f.total_case_qty / f.x_case_cnt * (f.x_case_cnt - 1) >= 2
        THEN f.x_case_cnt - 1
        ELSE 0
        END * OM.factor, 0)) AS potential_1_in_cm,
   SUM(IF(f.placing = 'Regal' AND f.x_case_cnt > 3, f.einzel_width * OM.factor * (f.x_case_cnt - 3), 0)) AS
   potential_1_in_cm_einzel,
   SUM(f.x_case_cnt) AS cnt_facings,
   SUM(1 - f.x_case_cnt) AS cnt_facings_reduced,
   SUM(3 - f.x_case_cnt) AS cnt_facings_reduced_einzel,
   SUM(f.src_case_size * f.total_case_qty) AS capacity,
   S.section_selection_id,
   M.metric_system_id,
   M.pas_type,
   M.higher_meas,
   M.shelf_meter
  FROM FACTS_AGGREGATED AS f
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement_1 AS OM ON f.int_org_sid = OM.int_org_sid
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_measurement_1 AS M ON OM.metric_system_id = M.metric_system_id AND f
     .item_pas_type = M.pas_type
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_selection_1 AS S ON f.spaceman_section_sid = S.spaceman_section_sid
    
  GROUP BY f.int_org_sid,
   f.spaceman_section_sid,
   f.spaceman_item_sid,
   cases,
   f.x_case_cnt,
   f.placing,
   f.item_merchandising_type_cd,
   S.section_selection_id,
   M.metric_system_id,
   M.pas_type,
   M.higher_meas,
   M.shelf_meter);