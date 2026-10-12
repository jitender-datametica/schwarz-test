CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_QUARTAL_KJ
(
kjqu
, akt_kjqu
, akt_kjqu_komplett
, kj
, akt_kj
, akt_kj_komplett
)
AS
   SELECT
  kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj, akt_kj_komplett
   FROM dbp_view.v_quartal_kj
   WHERE kjqu > 200104;