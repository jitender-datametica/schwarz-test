CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WUG
(
mandant_id
, wg_id
, wug_id
, arthiertyp_id
, wgi_id
)
AS

   SELECT v01.mandant_id,
   v01.wg_id,
   v01.wug_id,
   v01.arthiertyp_id,
   CASE
  WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
   ELSE TO_VARCHAR(v01.wg_id, 'FM000') END ||
   CASE
   WHEN v01.wug_id < 0 THEN TO_VARCHAR(v01.wug_id, 'FM000')
   ELSE TO_VARCHAR(v01.wug_id, 'FM000') END AS wgi_id

   FROM dbp_view.v_wug v01

   WHERE v01.mandant_id <> 1
   AND v01.arthiertyp_id = 2;