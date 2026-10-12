CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_PRODUKTGRUPPE_2
(
mandant_id
,produktgruppe_id
,platzierungswg_id
)
AS
   SELECT
   mandant_id,
   produktgruppe_id,
   platzierungswg_id
   FROM dbp_view.v_l_produktgruppe_2
   WHERE mandant_id <> 1;