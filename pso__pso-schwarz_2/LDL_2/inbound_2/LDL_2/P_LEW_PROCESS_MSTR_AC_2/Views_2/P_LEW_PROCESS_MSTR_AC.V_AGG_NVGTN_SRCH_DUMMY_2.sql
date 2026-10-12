CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_AGG_NVGTN_SRCH_DUMMY_2
   (
      cy_month
    , dummy_week
    , one_week_fg
   )
   AS
      SELECT
         cy_month,
      dummy_week,
      one_week_fg
     FROM p_lew_process_mstr.v_agg_nvgtn_srch_dummy_2
;