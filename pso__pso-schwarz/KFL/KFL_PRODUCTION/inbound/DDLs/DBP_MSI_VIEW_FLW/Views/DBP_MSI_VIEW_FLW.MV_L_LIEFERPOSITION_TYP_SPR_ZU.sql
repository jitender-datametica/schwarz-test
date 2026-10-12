CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_LIEFERPOSITION_TYP_SPR_ZU
-- 26.10.2011 system_id entfernt
-- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
lief_pos_typ_id
, mandant_id
--, system_id
, spr_id
, lief_pos_typ_bez
)
AS
   SELECT
   v01.lief_pos_typ_id, v01.mandant_id, v01.spr_id, v01.lief_pos_typ_bez

   FROM dbp_view.v_flw_lieferpos_typ_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;