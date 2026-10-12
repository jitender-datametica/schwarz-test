CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TS_SCM_GESCHAEFTSVORFALL_GRP_MAP(
	GESCHAEFTSVORFALL_ID,
	EWM_FG,
	SCM_GV_GRP_ID,
	SCM_GV_PROZESS_ID
) AS

-- 2022-11-28, AP0145540, SPEC0169641, initial, dknop
--2023-05-12, dknop, adding UNIONs (adding defaults, adding missing geschaeftsvorfall_id for ewm )
--2023-07-11, dknop, changing scm_gv_prozess_id to number
    SELECT 
         geschaeftsvorfall_id
        ,ewm_fg
        ,scm_gv_grp_id
        ,TO_NUMBER(scm_gv_prozess_id)


FROM DBP_VIEW.v_ts_scm_geschaeftsvorfall_grp_map 
UNION ALL
-- adding defaults:
 SELECT 
         '-1'
        ,ewm_fg
        ,'-1'
        ,-1
 FROM DBP_VIEW.v_ts_scm_geschaeftsvorfall_grp_map 
 GROUP BY ewm_fg
UNION ALL
-- adding missing geschaeftsvorfall_id for ewm
  SELECT DISTINCT
   CAST(v01.ewm_gv_id AS VARCHAR(18))
    ,1 AS ewm_fg
    ,'-1'
    ,-1
   FROM dbp_view.v_ewm_geschaeftsvorfall_spr_zu v01
   WHERE (ewm_gv_id) NOT IN (SELECT geschaeftsvorfall_id FROM DBP_VIEW.v_ts_scm_geschaeftsvorfall_grp_map WHERE ewm_fg=1)
   
;