CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_EXPANSIONSHILFE_2
(
gj
,gj_vj
,krk_id
,mandant_id
,kj
,ker_mo_id
,startdate
,akt_gj
)
AS
   SELECT
  m.gj,
   m.gj-1 AS gj_vj,
   krk_id,
   mandant_id,
   kj,
   ker_mo_id,
   TRIM(gj_vj)||'-0'||TRIM(ker_mo_id)||'-01' AS StartDate,
   j.akt_gj
   FROM dbp_view.v_ker_mo_periode_zu_2 m
   INNER JOIN dbp_msi_view_ivs.mv_jahr_gj_2 j
   ON
   m.gj=j.gj
   WHERE buchungsperiode_id =1
   AND akt_gj=0;