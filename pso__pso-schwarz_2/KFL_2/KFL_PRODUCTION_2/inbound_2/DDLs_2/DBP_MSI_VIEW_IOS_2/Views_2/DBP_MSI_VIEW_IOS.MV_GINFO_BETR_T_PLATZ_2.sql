CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_GINFO_BETR_T_PLATZ_2 as

   SELECT
   gb.betreiberart_id, l.betreiberart_bez, gb.techn_platz_id, gb.dat_von, gb.dat_bis

   FROM dbp_view.v_ginfo_betr_t_platz_zu_per_2   gb

   JOIN dbp_view.v_l_ginfo_betreiberart_2 l
   ON l.betreiberart_id = gb.betreiberart_id

   WHERE gb.dat_bis = '9999-12-31';