CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_LAGER_BEWART_SPR_ZU_2
-- 11.10.2013 twie: Neue Lookup
(
lager_bewart_id
,lager_bewart_bez
,mandant_id
)
AS
   SELECT
  lager_bewart_id, lager_bewart_bez, mandant_id

   FROM dbp_view.v_lager_bewart_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id

   WHERE mandant_id in (1,2);