CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STR_DAY_OVEN_BKG_PRG
AS
   SELECT
     client_id,
   wh_loc_sid,
   wh_id,
   loc_sid_store_move_to,
   aspect_id,
   currency_iso_cd,
   oven_id,
   oven_brand,
   baking_prog_id,
   dat_formdate,
   cy_week,
   cy_month,
   busyear,
   cnt_bkg_prg_fnshd,
   cnt_bkg_chmbr_idle_tm
  FROM p_lew_mart_lead.v_agg_str_day_oven_bkg_prg
;