CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_KREISTYP_GRUPPE
--- MR 20.12.2011 erstellt
(
mandant_id
,kreistyp_gruppe_id
)
AS

   SELECT
   v01.mandant_id,
   v01.kreistyp_gruppe_id

   FROM dbp_view.v_l_kreistyp_gruppe v01
   WHERE
   v01.mandant_id <> 1;