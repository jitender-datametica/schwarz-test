CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_ROUTE_2
--14.09.2018 mmzy2302: Neuanlegen der View mit explizitem Ausweis aller Felder
(
mandant_id
, werk_id
, route_id
)
AS
   SELECT
  mandant_id, werk_id, route_id
   FROM dbp_view.v_flw_l_route_2;