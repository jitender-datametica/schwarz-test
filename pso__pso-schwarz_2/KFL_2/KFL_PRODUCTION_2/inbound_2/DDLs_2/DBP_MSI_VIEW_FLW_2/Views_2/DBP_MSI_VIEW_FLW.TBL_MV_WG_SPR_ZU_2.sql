CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_WG_SPR_ZU_2
--31.01.2012 twie: Mandant_2 2 hinzugefuegt und Join zu user_spr_zu_2
--18.09.2018 naku: Sicherung wegen WG Umstellung und Anpassungen
AS
   SELECT
   v01.wg_id, v01.spr_id, v01.arthiertyp_id, v01.mandant_id, v01.wg_bez, CASE WHEN v01.wg_id < 10 THEN '00' || CAST(v01.wg_id AS VARCHAR(3))
   WHEN v01.wg_id < 100 THEN '0' || CAST(v01.wg_id AS VARCHAR(3))
   ELSE CAST(v01.wg_id AS VARCHAR(3)) END|| '  ' ||v01.wg_bez AS wg_id_bez
   FROM dbp_view.v_wg_spr_zu_2 v01
   WHERE   v01.arthiertyp_id=2
   AND v01.mandant_id IN (1,2)
   --17.07.10: Filterung der Korrektur- WG aus VIS/MIS
   AND v01.wg_id >= -3;