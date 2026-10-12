CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_WG_SPR_ZU
-- 05.08.2018, AP0021792, mkub1811: OWG Umstellung
AS
   SELECT
   v01.wg_id, v01.spr_id, v01.arthiertyp_id, v01.mandant_id, v01.wg_bez, CASE WHEN v01.wg_id < 10 THEN '00' || CAST(v01.wg_id AS VARCHAR(3)) WHEN v01.wg_id < 100 THEN '0' || CAST(v01.wg_id AS VARCHAR(3)) ELSE CAST(v01.wg_id AS VARCHAR(3)) END|| ' ' || v01.wg_bez AS wg_id_bez

   FROM dbp_view.v_wg_spr_zu v01

   WHERE v01.arthiertyp_id = 2
   AND v01.wg_id >= -3
   --17.07.10: Filterung der Korrektur- WG aus VIS/MIS;;;
   ;