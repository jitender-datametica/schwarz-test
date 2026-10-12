CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_QUARTAL_GJ
(
gjqu
,akt_gjqu
,akt_gjqu_komplett
,gj, akt_gj
,akt_gj_komplett
)
AS
   SELECT  gjqu,
   akt_gjqu,
   akt_gjqu_komplett,
   gj,
   akt_gj,
   akt_gj_komplett
  FROM dbp_view.v_quartal_gj
  WHERE gjqu > 200104;