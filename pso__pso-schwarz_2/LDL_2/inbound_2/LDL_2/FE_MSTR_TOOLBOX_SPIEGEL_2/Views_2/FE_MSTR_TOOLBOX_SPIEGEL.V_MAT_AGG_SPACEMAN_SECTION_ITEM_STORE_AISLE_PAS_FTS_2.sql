CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_SPACEMAN_SECTION_ITEM_STORE_AISLE_PAS_FTS_2(
	 INT_ORG_SID
	,SPACEMAN_SECTION_SID
	,SPACEMAN_ITEM_SID
	,CASES
	,MULT_POS_CASES				/* NEW */
	,MULT_POS_EINZEL			/* NEW */
	,CASES_EINZEL				/* NEW */
	,PLACING
	,ITEM_MERCHANDISING_TYPE_CD	/* NEW */
	,CNT_ITEM_2
	,CNT_CASES
	,AVG_KOLLI
	,AVG_EINZEL
	,AVG_CONTACT_DISTANCE_PER_ITEM
	,AVG_FACINGS_PER_ITEM
	,POTENTIAL_1
	,POTENTIAL_1_IN_CM
	,POTENTIAL_1_IN_CM_EINZEL
	,CNT_FACINGS
	,CNT_FACINGS_REDUCED
	,CNT_FACINGS_REDUCED_EINZEL	/* NEW */
	,CAPACITY
	,SECTION_SELECTION_ID
	,METRIC_SYSTEM_ID
	,PAS_TYPE					/* NEW */
	,HIGHER_MEAS
	,SHELF_METER
	,CLIENT_ID
	,MOVE_TO_STORE_ID
	,AISLE
) AS
SELECT kpi.int_org_sid 
     , kpi.spaceman_section_sid
     , kpi.spaceman_item_sid 
     , kpi.cases
	 , kpi.mult_pos_cases				/* NEW */
	 , kpi.mult_pos_einzel				/* NEW */
	 , kpi.cases_einzel					/* NEW */
     , kpi.placing
	 , kpi.item_merchandising_type_cd	/* NEW */
     , kpi.cnt_item_2 
     , kpi.cnt_cases
     , kpi.avg_kolli
	 , kpi.avg_einzel
     , kpi.avg_contact_distance_per_item
     , kpi.avg_facings_per_item 
     , kpi.potential_1
     , kpi.potential_1_in_cm
	 , kpi.potential_1_in_cm_einzel
     , kpi.cnt_facings
     , kpi.cnt_facings_reduced
     , kpi.cnt_facings_reduced_einzel	/* NEW */
     , kpi.capacity
     , kpi.section_selection_id
     , kpi.metric_system_id
	 , kpi.pas_type						/* NEW */
     , kpi.higher_meas 
     , kpi.shelf_meter
     , store.client_id
     , store.move_to_store_id
     , ssa.aisle
FROM FE_MSTR_TOOLBOX_SPIEGEL.v_agg_spaceman_section_item_pas_fts_2 kpi
INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_section_store_2 secstore
	ON kpi.spaceman_section_sid = secstore.spaceman_section_sid
INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_org_store_merge_vges_2 store
	ON secstore.loc_sid_store = store.store_id
INNER JOIN FE_MSTR_TOOLBOX_SPIEGEL.v_spaceman_section_store_aisle_2 ssa
	ON secstore.spaceman_section_sid = ssa.spaceman_section_sid 
	AND store.move_to_store_id = ssa.move_to_store_id
;
