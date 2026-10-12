CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_QUARTAL_KJ
(
kjqu
, akt_kjqu
, akt_kjqu_komplett
, kj
, akt_kj
, akt_kj_komplett
, kjqu_bez
)
AS
   SELECT
  kjqu,
   akt_kjqu,
   akt_kjqu_komplett,
   kj,
   akt_kj,
   akt_kj_komplett,
   MIN(dat /*Warning, Format 'DD.MM.YY' removed, semantic information not found.*/) || '-' || MAX(dat /*Warning, Format 'DD.MM.YY' removed, semantic information not found.*/)
  FROM dbp_view.v_tag  v01
   WHERE akt_gj BETWEEN -10 AND 1
   GROUP BY
   kjqu
   , akt_kjqu
   , akt_kjqu_komplett
   , kj
   , akt_kj
   , akt_kj_komplett;