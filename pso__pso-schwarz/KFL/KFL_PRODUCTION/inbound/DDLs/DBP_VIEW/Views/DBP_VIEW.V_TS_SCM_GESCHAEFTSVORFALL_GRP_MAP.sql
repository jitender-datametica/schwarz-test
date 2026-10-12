CREATE OR REPLACE VIEW DBP_VIEW.V_TS_SCM_GESCHAEFTSVORFALL_GRP_MAP AS 
    SELECT 
        geschaeftsvorfall_id
        ,ewm_fg
        ,scm_gv_grp_id
        ,scm_gv_prozess_id


FROM DBP_DATA.ts_scm_geschaeftsvorfall_grp_map ;