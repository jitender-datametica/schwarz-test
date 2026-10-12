CREATE OR REPLACE VIEW DBP_VIEW.V_TS_SCM_GESCHAEFTSVORFALL_GRP_SPR_ZU_1 AS 
    SELECT 
        scm_gv_grp_id
        ,spr_id
        ,scm_gv_grp_bez


FROM DBP_DATA.ts_scm_geschaeftsvorfall_grp_spr_zu_1 ;