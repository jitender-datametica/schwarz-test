CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_AIS_MANDANT_WUP_1
(
mandant_id
,wup_id
,nb_id
,gp_id
)
AS
   SELECT
  mandant_id,
   wup_id,
   CAST(0 AS SMALLINT) AS nb_id,
   gp_id
   FROM dbp_msi_v_view.v_ais_mandant_wup_1
   WHERE mandant_id <> 1;