CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ADV_INT_WEEK_REL_2

(
  cy_week
, cy
, adv_week_int
, adv_wt_nr_int
)
AS
   SELECT
     cy_week,
   cy,
   adv_week_int,
   adv_wt_nr_int
  FROM p_lew_mart_lead.v_adv_int_week_rel_2
;