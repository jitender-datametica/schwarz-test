CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_QUARTAL_KJ_2 (kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj, akt_kj_komplett)
AS
   SELECT kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj, akt_kj_komplett FROM dbp_view.v_quartal_kj_2 WHERE kjqu>200104;