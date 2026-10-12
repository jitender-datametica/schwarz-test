CREATE OR REPLACE VIEW P_LEW_MART_CM.V_LIL_RPT_CCLIAM_RTL_GRP_REL_2
   (
        rtl_id
      , ccliam_rtl_grp_id
   )
   AS
      SELECT
      rtl_id,
      CAST(ccliam_rtl_grp_id AS SMALLINT) AS ccliam_rtl_grp_id
      FROM p_lew_process_mstr_ac.v_lil_rpt_ccliam_rtl_grp_rel_2;