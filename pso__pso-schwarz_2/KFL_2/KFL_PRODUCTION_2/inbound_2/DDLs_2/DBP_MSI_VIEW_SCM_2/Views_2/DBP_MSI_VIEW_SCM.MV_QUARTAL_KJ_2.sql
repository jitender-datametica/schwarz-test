CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_QUARTAL_KJ_2 as
   SELECT
   kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj, akt_kj_komplett
   FROM dbp_view.v_quartal_kj_2
   WHERE kjqu>200104;