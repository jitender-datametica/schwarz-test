CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WG_SPR_ZU
AS 
--31.01.2012 twie: Mandant 2 hinzugefuegt und Join zu user_spr_zu
--18.09.2018 naku: Sicherung wegen WG Umstellung und Anpassungen
   SELECT
   v01.wg_id, v01.spr_id, v01.arthiertyp_id, v01.mandant_id, v01.wg_bez, wg_id_bez
   FROM DBP_MSI_VIEW_FLW.TBL_MV_WG_SPR_ZU v01
   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;