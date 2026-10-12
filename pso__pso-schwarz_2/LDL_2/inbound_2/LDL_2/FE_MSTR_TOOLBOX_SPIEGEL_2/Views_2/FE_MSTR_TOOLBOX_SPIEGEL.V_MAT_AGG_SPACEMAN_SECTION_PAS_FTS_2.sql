/*
#----------------------------------------------------------------------------
# Description:
# This view provides the agreggated KPIs on section level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_SPACEMAN_SECTION_PAS_FTS_2(
	INT_ORG_SID COMMENT 'Internal Organisation ID',
	SPACEMAN_SECTION_SID COMMENT 'Section ID',
	SECTION_WIDTH_MEAS COMMENT 'Width of the section',
	SHELF_WIDTH_MEAS COMMENT 'Width of section (all shelfes together)',
	MAX_POTENTIAL_CONTACT_DISTANCE COMMENT 'Maximum ptoential conta t distance',
	MAX_POTENTIAL_CONTACT_DISTANCE_5 COMMENT 'Maximum ptoential conta t distance',
	AVG_KOLLI COMMENT 'Average kolli width per item_2',
	AVG_EINZEL COMMENT 'Average einzel width per item_2',
	CNT_CASES COMMENT 'Number of cases',
	CNT_ITEM_2 COMMENT 'Number of items (always 1)',
	SECTION_SELECTION_ID COMMENT 'Technical column for export functionality in dashboard -> every section has one row for Yes and No',
	METRIC_SYSTEM_ID COMMENT 'Technical column for selection the measurement unit_2 for KPIs: cm or inches',
	PAS_TYPE COMMENT 'PAS TYPE - Packaged food or Refrigerated',
	HIGHER_MEAS COMMENT 'Factor to calculate higher meas of measurement value e.g. cm to m -> divide by 100',
	SHELF_METER COMMENT 'Shelf meter'
) AS
 SELECT sec.int_org_sid
     , sec.spaceman_section_sid
     , sec.section_width_meas
     , shelf.shelf_width_meas
     , CASE 
		WHEN shelf.podium_width > 0 AND (shelf.shelf_width_meas/sec.section_width_meas < 4) 
		THEN (4 * higher_meas * shelf.podium_width) + (1 * higher_meas * (sec.shelf_length - shelf.podium_width)) 
		ELSE 0 
		END AS max_potential_contact_distance
     , CASE WHEN shelf.podium_width > 0 AND (shelf.shelf_width_meas/sec.section_width_meas < 5) 
		THEN (5 * higher_meas * shelf.podium_width) + (1 * higher_meas * (sec.shelf_length - shelf.podium_width)) 
		ELSE 0 
		END AS max_potential_contact_distance_5

		
     , secitem.avg_kolli
     , secitem.avg_einzel
     , secitem.cnt_cases
     , secitem.cnt_item_2
     , selection.section_selection_id
     , sec.metric_system_id
	 , meas.PAS_TYPE
	 , meas.higher_meas
	 , meas.shelf_meter
	FROM (
			SELECT sec.int_org_sid
				, sec.spaceman_section_sid
				, meas.PAS_TYPE
				, org_meas.metric_system_id
				, section_width_meas*org_meas.factor AS section_width_meas
				, section_width_meas*org_meas.factor/meas.higher_meas AS shelf_length
			FROM FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_section_2 sec
			INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_int_org_measurement_2 org_meas 
			 ON sec.int_org_sid = org_meas.int_org_sid
			INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_measurement_2 meas 
			 ON org_meas.metric_system_id = meas.metric_system_id
		) sec

	INNER JOIN
		( 
			SELECT shelf.spaceman_section_sid
				, org_meas.metric_system_id
				, meas.PAS_TYPE
				, SUM(shelf_width_meas*org_meas.factor) shelf_width_meas
				, SUM(CASE WHEN shelf.shelf_depth_meas*org_meas.factor > org_meas.pod_620_depth *org_meas.factor 
							AND (CASE WHEN (shelf.shelf_width_meas*factor = org_meas.dd_600_width*org_meas.factor 
											AND shelf.shelf_depth_meas*factor = org_meas.dd_800_depth*org_meas.factor) 
											OR (shelf.shelf_depth_meas*factor = org_meas.dd_600_depth*org_meas.factor 
											AND shelf.shelf_width_meas*factor = org_meas.dd_800_width*org_meas.factor) 
									THEN 'DD' 
									WHEN (org_meas.int_org_sid <> 85 AND(
											((shelf.shelf_width_meas*factor = org_meas.ep_1200_width*org_meas.factor 
											OR shelf.shelf_width_meas*factor = org_meas.ep_1330_width*org_meas.factor) 
										AND shelf.shelf_depth_meas*factor = org_meas.ep_800_depth*org_meas.factor) 
											OR shelf.shelf_depth_meas*factor = org_meas.ep_1200_depth*org_meas.factor)
											)
											OR
											(org_meas.int_org_sid = 85 
											AND shelf.shelf_width_meas*factor = org_meas.ep_1200_width*org_meas.factor
											AND shelf.shelf_depth_meas*factor = org_meas.ep_1200_depth*org_meas.factor
											)
									THEN 'EP/GMA' 
									ELSE 'Regal' 
									END) = 'Regal' 
						THEN shelf.shelf_width_meas*org_meas.factor 
						ELSE 0 
						END)/MAX(higher_meas) AS podium_width
	
			FROM FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_section_2 sec 
			INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_section_shelf_2 shelf 
			 ON sec.spaceman_section_sid = shelf.spaceman_section_sid
			INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_int_org_measurement_2 org_meas 
			 ON sec.int_org_sid = org_meas.int_org_sid
			INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_measurement_2 meas 
			 ON org_meas.metric_system_id = meas.metric_system_id
			GROUP BY shelf.spaceman_section_sid
					, org_meas.metric_system_id
					, meas.PAS_TYPE
				
		) shelf 
		 ON sec.spaceman_section_sid = shelf.spaceman_section_sid
		 AND sec.metric_system_id = shelf.metric_system_id 
		 AND sec.PAS_TYPE = shelf.PAS_TYPE
		INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_section_selection_2 selection  
		 ON sec.spaceman_section_sid = selection.spaceman_section_sid 
		INNER JOIN
		(
			 SELECT secitem.spaceman_section_sid
		         , secitem.section_selection_id
		         , secitem.metric_system_id
				 , secitem.PAS_TYPE
		         , AVG(secitem.avg_kolli) AS avg_kolli
		         , AVG(secitem.avg_einzel) AS avg_einzel
		         , SUM(cnt_cases) AS cnt_cases
		         , SUM(cnt_item_2) AS cnt_item_2
		    FROM FE_MSTR_TOOLBOX_SPIEGEL.v_agg_spaceman_section_item_pas_fts_2 secitem 
		    GROUP BY secitem.spaceman_section_sid
		          , secitem.section_selection_id
		          , secitem.metric_system_id 
				  , secitem.PAS_TYPE
		) secitem 
		 ON secitem.section_selection_id = selection.section_selection_id 
		 AND secitem.metric_system_id = sec.metric_system_id 
		 AND secitem.PAS_TYPE = sec.PAS_TYPE
		INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_int_org_measurement_2 org_meas 
		 ON sec.int_org_sid = org_meas.int_org_sid 
		 AND sec.metric_system_id = org_meas.metric_system_id
		INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_measurement_2 meas 
		 ON org_meas.metric_system_id = meas.metric_system_id
		 AND sec.PAS_TYPE = meas.PAS_TYPE
;