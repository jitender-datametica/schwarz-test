create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE_AC.V_REF_SEGMENT_2(
	SEGMENT_SID COMMENT 'Surrogate Key SEGMENT.',
	SRC_SEGMENT_NR COMMENT 'Identifier of the segment in the segmentation in the source system, same segment numbers may exist for different segmentations within the same model, and in different models.',
	SEGMENT_NAME COMMENT 'Name of the segment in the segmentation.',
	SEGMENT_DESCR COMMENT 'Description of the segment in the segmentation.',
	SEGMENTATION_SID COMMENT 'Surrogate Key SEGMENTATION.',
	SEGMENTATION_NAME COMMENT 'Name of the segmentation in the model.',
	MODEL_SID COMMENT 'Surrogate Key MODEL.',
	MODEL_NAME COMMENT 'Name of the model.',
	MODEL_AREA_CD COMMENT 'sprechender Code, CX, LDL+, AP.',
	MODEL_GROUP_CD COMMENT 'Eindeutiger Code, der mit dem area_cd beginnt z.b. AP_bakeoff oder CX_store_rating.',
	DWH_LOAD_ID COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.',
	DWH_CREATED COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.',
	DWH_UPDATED COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH.'
) as 
    SELECT 
        segment_sid,
        src_segment_nr,
        segment_name,
        segment_descr,
        segmentation_sid,
        segmentation_name,
        model_sid,
        model_name,
        model_area_cd,
        model_group_cd,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_REF_SEGMENT_2 ;
