CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TS_SCM_GESCHAEFTSVORFALL_PROZESS_SPR_ZU(
	SCM_GV_PROZESS_ID,
	SCM_GV_PROZESS_BEZ
) AS 

-- 2022-11-28, AP0145540, SPEC0169641, initial, dknop
--2023-07-11, dknop,changing scm_gv_prozess_id to number
    SELECT 

        TO_NUMBER(scm_gv_prozess_id),
        scm_gv_grp_bez

FROM DBP_VIEW.v_ts_scm_geschaeftsvorfall_prozess_spr_zu ;