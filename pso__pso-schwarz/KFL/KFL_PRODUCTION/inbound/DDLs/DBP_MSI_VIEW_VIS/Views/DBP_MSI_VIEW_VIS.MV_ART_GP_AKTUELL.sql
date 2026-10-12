CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_GP_AKTUELL as
   -- Beziehungs-Tabelle zwischen Artikel und Lieferant
   -- gefiltert auf aktuelle Sätze
   SELECT
   mandant_id, art_id, gp_id, einkaufsorganisation_id, gp_art_id, herst_id, mhd_zeitraum_dz, mutter_ek_id
   FROM dbp_view.v_art_gp_zu_per
   WHERE dat_bis = '9999-12-31'
;