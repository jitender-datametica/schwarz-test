CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_HWG_SPR_ZU_2
-- LOOKUP : Hauptwarengruppe
-- Aktuelle/Letzte gueltige Zuordnung (dat_bis 31.12.9999)
-- 20170508 AP0017810, SPEC0021927
--05.08.2018, AP0021792, mkub1811: OWG Umstellung
(
hwg_id
,hwg_bez
,hwg_id_bez
,mandant_id
,arthiertyp_id
,spr_id
)
AS
   SELECT v01.hwg_id, v01.hwg_bez, CASE WHEN v01.hwg_id < 0 THEN TO_VARCHAR(v01.hwg_id, 'FM000')
   ELSE TO_VARCHAR(v01.hwg_id, 'FM000')
   END || ' ' || v01.hwg_bez AS hwg_id_bez, v01.mandant_id, v01.arthiertyp_id, v01.spr_id
   FROM dbp_view.v_hwg_spr_zu_2 v01

--    JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
--    ON v01.spr_id = v02.spr_id
   WHERE v01.arthiertyp_id = 2
   ;