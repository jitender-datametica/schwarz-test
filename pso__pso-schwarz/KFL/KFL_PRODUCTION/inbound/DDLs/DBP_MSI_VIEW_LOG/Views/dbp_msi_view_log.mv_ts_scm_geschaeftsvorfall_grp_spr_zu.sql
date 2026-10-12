CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TS_SCM_GESCHAEFTSVORFALL_GRP_SPR_ZU(
	SCM_GV_GRP_ID,
	SPR_ID,
	SCM_GV_GRP_BEZ
) AS 
-- 2022-11-28, AP0145540, SPEC0169641, initial, dknop
    SELECT DISTINCT
        scm_gv_grp_id
        ,spr_id
        ,scm_gv_grp_bez


FROM DBP_VIEW.v_ts_scm_geschaeftsvorfall_grp_spr_zu ;