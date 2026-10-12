CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_SAISON
--- MR 20.12.2011 erstellt
(
mandant_id
,saison_id
)
AS

   SELECT
   v01.mandant_id,
   v01.saison_id

   FROM dbp_view.v_l_saison v01
   WHERE
   v01.mandant_id <> 1;