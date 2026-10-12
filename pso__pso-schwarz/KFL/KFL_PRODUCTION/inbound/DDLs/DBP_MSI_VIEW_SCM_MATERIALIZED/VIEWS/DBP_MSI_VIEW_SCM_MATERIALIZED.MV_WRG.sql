create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WRG(
	WRG_ID,
	WRG_BEZ,
	TD_UPDATE,
	TD_INSERT
) as
SELECT * FROM dbp_view.v_wrg;