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


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_spaceman_section_pas_fts_1 (int_org_sid
OPTIONS(description='Internal Organisation ID'), spaceman_section_sid OPTIONS(description='Section ID'),
section_width_meas OPTIONS(description='Width of the section'), shelf_width_meas
OPTIONS(description='Width of section (all shelfes together)'), max_potential_contact_distance
OPTIONS(description='Maximum ptoential conta t distance'), max_potential_contact_distance_5
OPTIONS(description='Maximum ptoential conta t distance'), avg_kolli OPTIONS(description='Average kolli width per item_1'),
avg_einzel OPTIONS(description='Average einzel width per item_1'), cnt_cases OPTIONS(description='Number of cases'),
cnt_item_1 OPTIONS(description='Number of items (always 1)'), section_selection_id
OPTIONS(description='Technical column for export functionality in dashboard -> every section has one row for Yes and No'),
metric_system_id OPTIONS(description='Technical column for selection the measurement unit_1 for KPIs: cm or inches'),
pas_type OPTIONS(description='PAS TYPE - Packaged food or Refrigerated'), higher_meas
OPTIONS(description='Factor to calculate higher meas of measurement value e.g. cm to m -> divide by 100'), shelf_meter
OPTIONS(description='Shelf meter')) AS SELECT sec.int_org_sid,
 sec.spaceman_section_sid,
 sec.section_width_meas,
 shelf.shelf_width_meas,
  CASE
  WHEN shelf.podium_width > 0 AND shelf.shelf_width_meas / sec.section_width_meas < 4
  THEN 4 * MEAS1.higher_meas * shelf.podium_width + MEAS1.higher_meas * (sec.shelf_length - shelf.podium_width)
  ELSE 0
  END AS max_potential_contact_distance,
  CASE
  WHEN shelf.podium_width > 0 AND shelf.shelf_width_meas / sec.section_width_meas < 5
  THEN 5 * MEAS1.higher_meas * shelf.podium_width + MEAS1.higher_meas * (sec.shelf_length - shelf.podium_width)
  ELSE 0
  END AS max_potential_contact_distance_5,
 secitem.avg_kolli,
 secitem.avg_einzel,
 secitem.cnt_cases,
 secitem.cnt_item_1,
 SELECTION.section_selection_id,
 sec.metric_system_id,
 MEAS1.pas_type,
 MEAS1.higher_meas,
 MEAS1.shelf_meter
FROM (SELECT SEC.int_org_sid,
   SEC.spaceman_section_sid,
   MEAS.pas_type,
   ORG_MEAS.metric_system_id,
    SEC.section_width_meas * ORG_MEAS.factor AS section_width_meas,
     SEC.section_width_meas * ORG_MEAS.factor / MEAS.higher_meas AS shelf_length
  FROM ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_1 AS SEC
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement_1 AS ORG_MEAS ON SEC.int_org_sid = ORG_MEAS.int_org_sid
    
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_measurement_1 AS MEAS ON ORG_MEAS.metric_system_id = MEAS.metric_system_id
    ) AS sec
 INNER JOIN (SELECT SHELF.spaceman_section_sid,
   ORG_MEAS0.metric_system_id,
   MEAS0.pas_type,
   SUM(SHELF.shelf_width_meas * ORG_MEAS0.factor) AS shelf_width_meas,
    SUM(CASE
      WHEN SHELF.shelf_depth_meas * ORG_MEAS0.factor > ORG_MEAS0.pod_620_depth * ORG_MEAS0.factor AND CASE
         WHEN SHELF.shelf_width_meas * ORG_MEAS0.factor = ORG_MEAS0.dd_600_width * ORG_MEAS0.factor AND SHELF.shelf_depth_meas
              * ORG_MEAS0.factor = ORG_MEAS0.dd_800_depth * ORG_MEAS0.factor OR SHELF.shelf_depth_meas * ORG_MEAS0.factor
              = ORG_MEAS0.dd_600_depth * ORG_MEAS0.factor AND SHELF.shelf_width_meas * ORG_MEAS0.factor = ORG_MEAS0.dd_800_width
              * ORG_MEAS0.factor
         THEN 'DD'
         WHEN ORG_MEAS0.int_org_sid <> 85 AND ((SHELF.shelf_width_meas * ORG_MEAS0.factor = ORG_MEAS0.ep_1200_width *
                  ORG_MEAS0.factor OR SHELF.shelf_width_meas * ORG_MEAS0.factor = ORG_MEAS0.ep_1330_width * ORG_MEAS0.factor
                  ) AND SHELF.shelf_depth_meas * ORG_MEAS0.factor = ORG_MEAS0.ep_800_depth * ORG_MEAS0.factor OR SHELF.shelf_depth_meas
                * ORG_MEAS0.factor = ORG_MEAS0.ep_1200_depth * ORG_MEAS0.factor) OR ORG_MEAS0.int_org_sid = 85 AND SHELF
              .shelf_width_meas * ORG_MEAS0.factor = ORG_MEAS0.ep_1200_width * ORG_MEAS0.factor AND SHELF.shelf_depth_meas
              * ORG_MEAS0.factor = ORG_MEAS0.ep_1200_depth * ORG_MEAS0.factor
         THEN 'EP/GMA'
         ELSE 'Regal'
         END = 'Regal'
      THEN SHELF.shelf_width_meas * ORG_MEAS0.factor
      ELSE 0
      END) / MAX(MEAS0.higher_meas) AS podium_width
  FROM ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_1 AS SEC0
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_shelf_1 AS SHELF ON SEC0.spaceman_section_sid = SHELF.spaceman_section_sid
    
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement_1 AS ORG_MEAS0 ON SEC0.int_org_sid = ORG_MEAS0.int_org_sid
    
   INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_measurement_1 AS MEAS0 ON ORG_MEAS0.metric_system_id = MEAS0.metric_system_id
    
  GROUP BY SHELF.spaceman_section_sid,
   ORG_MEAS0.metric_system_id,
   MEAS0.pas_type) AS shelf ON sec.spaceman_section_sid = shelf.spaceman_section_sid AND sec.metric_system_id = shelf.metric_system_id
     AND sec.pas_type = shelf.pas_type
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_selection_1 AS SELECTION ON sec.spaceman_section_sid =
  SELECTION.spaceman_section_sid
 INNER JOIN (SELECT spaceman_section_sid,
   section_selection_id,
   metric_system_id,
   pas_type,
   AVG(avg_kolli) AS avg_kolli,
   AVG(avg_einzel) AS avg_einzel,
   SUM(cnt_cases) AS cnt_cases,
   SUM(cnt_item_1) AS cnt_item_1
  FROM ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_item_pas_fts_1 AS SECITEM
  GROUP BY spaceman_section_sid,
   section_selection_id,
   metric_system_id,
   pas_type) AS secitem ON SELECTION.section_selection_id = secitem.section_selection_id AND sec.metric_system_id =
    secitem.metric_system_id AND sec.pas_type = secitem.pas_type
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_int_org_measurement_1 AS ORG_MEAS1 ON sec.int_org_sid = ORG_MEAS1.int_org_sid
    AND sec.metric_system_id = ORG_MEAS1.metric_system_id
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_measurement_1 AS MEAS1 ON ORG_MEAS1.metric_system_id = MEAS1.metric_system_id
    AND sec.pas_type = MEAS1.pas_type;