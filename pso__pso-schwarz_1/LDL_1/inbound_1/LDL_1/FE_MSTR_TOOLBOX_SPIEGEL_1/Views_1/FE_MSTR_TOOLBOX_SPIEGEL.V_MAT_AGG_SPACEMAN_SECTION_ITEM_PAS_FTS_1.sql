CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_SPACEMAN_SECTION_ITEM_PAS_FTS_1(
	INT_ORG_SID COMMENT 'Internal Organisation ID',
	SPACEMAN_SECTION_SID COMMENT 'Section ID',
	SPACEMAN_ITEM_SID COMMENT 'Spaceman item_1 ID',
	CASES COMMENT 'Number of cases with condition for reusing in different columns esp. Potential 1 calculation - KOLLI',
	MULT_POS_CASES COMMENT 'Number of cases (Mehrfachstellungen) - KOLLI',
	MULT_POS_EINZEL COMMENT 'Number of cases (Mehrfachstellungen) - EINZEL',
	CASES_EINZEL COMMENT 'Number of individual items for reusing in different columns - EINZEL',
	PLACING COMMENT 'Placing of item_1 (EP DD Regal ...)',
	ITEM_MERCHANDISING_TYPE_CD COMMENT 'Item_1 merchandising type code Hand or Case',
	CNT_ITEM_1 COMMENT 'Number of item_1',
	CNT_CASES COMMENT 'Number of cases KOLLI (Mehrfachstellungen)',
	CNT_CASES_EINZEL COMMENT 'Number of cases EINZEL (Mehrfachstellungen)',
	AVG_KOLLI COMMENT 'Average kolli width',
	AVG_EINZEL COMMENT 'Average einzel width',
	AVG_CONTACT_DISTANCE_PER_ITEM COMMENT 'Average contact_1 distance (width of the position) per item_1',
	AVG_FACINGS_PER_ITEM COMMENT 'Average facings per item_1',
	POTENTIAL_1 COMMENT 'Potential 1 (old calculation)',
	POTENTIAL_1_IN_CM COMMENT 'Potential 1 in cm KOLLI',
	POTENTIAL_1_IN_CM_EINZEL COMMENT 'Potential 1 in cm EINZEL',
	CNT_FACINGS COMMENT 'Number of facings',
	CNT_FACINGS_REDUCED COMMENT 'Number of reduced facings KOLLI',
	CNT_FACINGS_REDUCED_EINZEL COMMENT 'Number of reduced facings EINZEL',
	CAPACITY COMMENT 'Capacity of item_1',
	SECTION_SELECTION_ID COMMENT 'Technical column for export functionality in dashboard -> every section has one row for Yes and No',
	METRIC_SYSTEM_ID COMMENT 'Technical column for selection the measurement unit_1 for KPIs: cm or inches',
	PAS_TYPE COMMENT 'PAS TYPE - Packaged food or Refrigerated',
	HIGHER_MEAS COMMENT 'Factor to calculate higher meas of measurement value e.g. cm to m -> divide by 100',
	SHELF_METER COMMENT 'Shelf meter'
) AS
WITH 
item_list AS (
	SELECT DISTINCT 
      SPACEMAN_ITEM_SID
    , ITEM.SUBITEMGROUP_ID
    , 'food' AS ITEM_PAS_TYPE
	FROM FE_MSTR_TOOLBOX_SPIEGEL.V_ITEM_SPACEMAN_ITEM_1 ITSPIT
	INNER JOIN P_LEW_MART_LEAD_AC.V_ITM_ITEM_1 ITEM_1
	  ON ITSPIT.CLIENT_ID = ITEM.CLIENT_ID
	  AND ITSPIT.ITEM_SID = ITEM.ITEM_ID
	WHERE ITEM.SUBITEMGROUP_ID IN (40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 54, 60, 61, 62, 63, 70, 71, 72, 73, 77, 80, 81,82, 83, 84, 85)

	UNION ALL 

	SELECT DISTINCT 
      SPACEMAN_ITEM_SID
    , ITEM.SUBITEMGROUP_ID
    , 'cool' AS ITEM_PAS_TYPE
	FROM FE_MSTR_TOOLBOX_SPIEGEL.V_ITEM_SPACEMAN_ITEM_1 ITSPIT
	INNER JOIN P_LEW_MART_LEAD_AC.V_ITM_ITEM_1 ITEM_1
	  ON ITSPIT.CLIENT_ID = ITEM.CLIENT_ID
	  AND ITSPIT.ITEM_SID = ITEM.ITEM_ID
	WHERE ITEM.SUBITEMGROUP_ID IN (30, 31, 32, 33, 35, 36, 40, 41, 42, 43, 45, 48, 51, 61, 62, 63)
	),
facts_aggregated AS (
	SELECT sec.int_org_sid
		, sec.spaceman_section_sid
		, spit.spaceman_item_sid
		, spithist.src_case_size
		, poshist.item_merchandising_type_cd
        , i.ITEM_PAS_TYPE
		, CASE 
			WHEN (shelfhist.shelf_width_meas, shelfhist.shelf_depth_meas) IN ((60, 80), (80, 60)) THEN 'DD'
			WHEN (sec.int_org_sid <> 85 AND (shelfhist.shelf_width_meas, shelfhist.shelf_depth_meas) IN ((120, 80), (shelfhist.shelf_width_meas, 120)))
				OR (sec.int_org_sid = 85 AND (shelfhist.shelf_width_meas, shelfhist.shelf_depth_meas) IN ((46, 48))) THEN 'EP/GMA'
			ELSE 'Regal'
			END AS placing
		, SUM(CASE 
			WHEN poshist.item_merchandising_type_cd = 'Case' AND poshist.case_orientation_cd = 'Front End' THEN spithist.case_width_meas
			WHEN poshist.item_merchandising_type_cd = 'Case' AND poshist.case_orientation_cd = 'Side End' THEN spithist.case_depth_meas
			ELSE 0
			END) AS kolli_width
		, SUM(CASE 
			WHEN poshist.item_merchandising_type_cd = 'Hand' AND poshist.case_orientation_cd = 'Front End' THEN spithist.item_width_meas 
			WHEN poshist.item_merchandising_type_cd = 'Hand' AND poshist.case_orientation_cd = 'Side End' THEN spithist.item_depth_meas 
			ELSE 0
			END) AS einzel_width
		, SUM(poshist.position_width_meas) AS position_width_meas
		, SUM(poshist.x_case_cnt) AS x_case_cnt
		, MAX(poshist.case_orientation_cd) AS case_orientation_cd
		, SUM(poshist.total_case_qty) AS total_case_qty
	FROM p_lew_core_ac.v_spaceman_section_1 sec 
		INNER JOIN p_lew_core_ac.v_spaceman_section_hist_1 AS sechist 
	   		ON sec.spaceman_section_sid = sechist.spaceman_section_sid 
		INNER JOIN p_lew_core_ac.v_spaceman_section_shelf_1 AS shelf 
			ON sec.spaceman_section_sid = shelf.spaceman_section_sid 
		INNER JOIN p_lew_core_ac.v_spaceman_section_shelf_hist_1 AS shelfhist 
			ON shelf.shelf_sid = shelfhist.shelf_sid
		INNER JOIN p_lew_core_ac.v_spaceman_shelf_position_1 AS pos 
			ON shelf.shelf_sid = pos.shelf_sid 
		INNER JOIN p_lew_core_ac.v_spaceman_shelf_position_hist_1 AS poshist 
			ON pos.shelf_position_sid = poshist.shelf_position_sid
		INNER JOIN p_lew_core_ac.v_spaceman_item_1 AS spit 
			ON poshist.spaceman_item_sid = spit.spaceman_item_sid 
		INNER JOIN p_lew_core_ac.v_spaceman_item_hist_1 AS spithist 
			ON spit.spaceman_item_sid = spithist.spaceman_item_sid
		INNER JOIN item_list AS i
			ON spit.spaceman_item_sid = i.spaceman_item_sid
	WHERE CURRENT_DATE BETWEEN sechist.dwh_valid_from AND sechist.dwh_valid_to
		AND sechist.deleted_fg = 0 
		AND CURRENT_DATE BETWEEN shelfhist.dwh_valid_from AND shelfhist.dwh_valid_to
		AND shelfhist.deleted_fg = 0 
		AND CURRENT_DATE BETWEEN poshist.dwh_valid_from AND poshist.dwh_valid_to
		AND poshist.deleted_fg = 0 
		AND CURRENT_DATE BETWEEN spithist.dwh_valid_from AND spithist.dwh_valid_to
		AND spithist.deleted_fg = 0 
		AND CURRENT_DATE BETWEEN spit.active_from_dt AND spit.active_to_dt
	GROUP BY sec.int_org_sid
		, sec.spaceman_section_sid
		, spit.spaceman_item_sid
		, spithist.src_case_size
		, poshist.item_merchandising_type_cd
        , ITEM_PAS_TYPE
		, placing
	)
SELECT f.int_org_sid
	, f.spaceman_section_sid
	, f.spaceman_item_sid
	, CASE WHEN f.x_case_cnt = 0 THEN 0 
		WHEN (f.total_case_qty - (f.total_case_qty / f.x_case_cnt) * (f.x_case_cnt - 1)) >= 2 THEN f.x_case_cnt - 1 
		ELSE 0 
		END AS cases
	, IFF(f.x_case_cnt >= 2 AND f.item_merchandising_type_cd = 'Case', f.x_case_cnt - 1, 0) AS mult_pos_cases
	, IFF(f.x_case_cnt >= 2 AND f.item_merchandising_type_cd = 'Hand', f.x_case_cnt - 1, 0) AS mult_pos_einzel 
	
	, CASE WHEN f.x_case_cnt >=2  THEN f.x_case_cnt - 1 ELSE 0 END AS cases_einzel 
	, f.placing
	, f.item_merchandising_type_cd
	, COUNT(DISTINCT f.spaceman_item_sid) AS cnt_item_1
	, SUM(cases) AS cnt_cases
	, SUM(cases_einzel) AS cnt_cases_einzel
	, SUM(IFF(f.kolli_width = 0, NULL, f.kolli_width * om.factor)) AS avg_kolli
	, SUM(IFF(f.einzel_width = 0, NULL, f.einzel_width * om.factor)) AS avg_einzel
	, SUM(f.position_width_meas * om.factor) AS avg_contact_distance_per_item
	, SUM(IFF(f.placing = 'Regal', f.x_case_cnt, 0)) AS avg_facings_per_item
	, SUM(IFF(f.placing = 'Regal', cases, 0)) AS potential_1
	, SUM(IFF(f.placing = 'Regal', f.kolli_width * cases * om.factor, 0)) AS potential_1_in_cm
	, SUM(IFF(f.placing = 'Regal' AND f.x_case_cnt > 3, f.einzel_width * om.factor * (f.x_case_cnt - 3), 0)) AS potential_1_in_cm_einzel 
	, SUM(f.x_case_cnt) cnt_facings
	, SUM(1 - f.x_case_cnt) AS cnt_facings_reduced
	, SUM(3 - f.x_case_cnt) AS cnt_facings_reduced_einzel
	, SUM(f.src_case_size * f.total_case_qty) AS capacity
	, s.section_selection_id
	, m.metric_system_id
    , m.PAS_TYPE
    , m.higher_meas
    , m.shelf_meter
FROM facts_aggregated f
	INNER JOIN fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement_1 AS om 
		ON f.int_org_sid = om.int_org_sid
	INNER JOIN fe_mstr_toolbox_spiegel.v_spaceman_measurement_1 AS m 
		ON om.metric_system_id = m.metric_system_id
        AND f.ITEM_PAS_TYPE = m.PAS_TYPE
	INNER JOIN fe_mstr_toolbox_spiegel.v_spaceman_section_selection_1 AS s 
		ON f.spaceman_section_sid = s.spaceman_section_sid

GROUP BY f.int_org_sid
	, f.spaceman_section_sid
	, f.spaceman_item_sid
	, cases
	, f.x_case_cnt
	, f.placing
	, f.item_merchandising_type_cd
	, s.section_selection_id
	, m.metric_system_id
    , PAS_TYPE
    , m.higher_meas
    , m.shelf_meter
;