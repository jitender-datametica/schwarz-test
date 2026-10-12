CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_TS_WBS_VZ_TAG_1 
AS 
--AP0062304 | mayko | initial creation |

SELECT
	mandant_id
	,wup_id
	,nb_id
	,dat
	,non_adjustable_day_fg
	,kommentar

FROM DBP_VIEW.v_ts_wbs_vz_tag_1;