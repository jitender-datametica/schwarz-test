/*
#----------------------------------------------------------------------------
# Description:
# This view provides the agreggated KPIs on section and item_1 level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     10.10.2024      Simeon Nikolaev          PAS_TYPE
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_item_pas_fts_1 (int_org_sid
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
OPTIONS(description='Shelf meter')) AS SELECT int_org_sid,
 spaceman_section_sid,
 spaceman_item_sid,
 cases,
 mult_pos_cases,
 mult_pos_einzel,
 cases_einzel,
 placing,
 item_merchandising_type_cd,
 cnt_item_1,
 cnt_cases,
 cnt_cases_einzel,
 avg_kolli,
 avg_einzel,
 avg_contact_distance_per_item,
 avg_facings_per_item,
 potential_1,
 potential_1_in_cm,
 potential_1_in_cm_einzel,
 cnt_facings,
 cnt_facings_reduced,
 cnt_facings_reduced_einzel,
 capacity,
 section_selection_id,
 metric_system_id,
 pas_type,
 higher_meas,
 shelf_meter
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_spaceman_section_item_pas_fts_1;