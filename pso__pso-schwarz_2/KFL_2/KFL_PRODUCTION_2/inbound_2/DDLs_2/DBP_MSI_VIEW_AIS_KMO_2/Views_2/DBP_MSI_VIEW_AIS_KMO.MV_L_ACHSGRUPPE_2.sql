CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_ACHSGRUPPE_2
(
mandant_id
,achsgruppe_id
,produktgruppe_id
)
AS
   SELECT
   mandant_id,
   achsgruppe_id,
   produktgruppe_id
   FROM dbp_view.v_l_achsgruppe_2
   WHERE mandant_id <> 1;