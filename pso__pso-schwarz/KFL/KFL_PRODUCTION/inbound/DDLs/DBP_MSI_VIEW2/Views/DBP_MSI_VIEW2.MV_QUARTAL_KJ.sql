CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_QUARTAL_KJ (kjqu,akt_kjqu,akt_kjqu_komplett, kj, akt_kj,akt_kj_komplett)
AS
   SELECT kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj, akt_kj_komplett  FROM dbp_view.v_quartal_kj where kjqu>200104;