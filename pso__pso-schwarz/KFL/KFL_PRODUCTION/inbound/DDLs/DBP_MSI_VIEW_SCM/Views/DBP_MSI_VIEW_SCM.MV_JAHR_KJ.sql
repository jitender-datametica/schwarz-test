CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_JAHR_KJ as
   SELECT
   kj, akt_kj, akt_kj_komplett
   FROM dbp_view.v_jahr_kj
   WHERE kj>2003;