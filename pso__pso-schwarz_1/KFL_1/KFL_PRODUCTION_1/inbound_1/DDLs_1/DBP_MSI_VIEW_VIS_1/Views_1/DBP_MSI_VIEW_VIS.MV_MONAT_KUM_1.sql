CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MONAT_KUM_1 as
   SELECT
   a.gj, a.kjmo, b.kjmo kjmo_kum, b.kjmo_vj kjmo_vj_kum
   FROM dbp_view.v_monat_1 a
   INNER JOIN dbp_view.v_monat_1 b
   ON  a.kjmo >= b.kjmo
   AND a.gj = b.gj
   WHERE a.gj >= 2012
   AND a.akt_gj <= 1
   ;