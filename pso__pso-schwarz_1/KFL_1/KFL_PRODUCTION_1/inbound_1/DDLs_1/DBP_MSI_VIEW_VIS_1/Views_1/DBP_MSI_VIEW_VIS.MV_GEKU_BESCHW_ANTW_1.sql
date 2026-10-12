CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_BESCHW_ANTW_1 as
   SELECT
  beschwerde_antwort_id, geku_massnahme_uid, berechtigt_fg, avg_fg
   FROM dbp_view.v_geku_beschw_antw_1;