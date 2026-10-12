CREATE OR REPLACE VIEW DBP_VIEW.V_TS_SCM_GESCHAEFTSVORFALL_PROZESS_SPR_ZU_2 AS 
    SELECT 
        scm_gv_prozess_id
        ,spr_id
        ,scm_gv_grp_bez


FROM DBP_DATA.ts_scm_geschaeftsvorfall_prozess_spr_zu_2 ;