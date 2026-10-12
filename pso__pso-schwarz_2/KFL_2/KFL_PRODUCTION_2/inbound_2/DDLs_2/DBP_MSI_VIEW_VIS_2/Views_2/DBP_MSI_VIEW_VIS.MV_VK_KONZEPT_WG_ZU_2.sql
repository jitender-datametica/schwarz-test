CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VK_KONZEPT_WG_ZU_2 as
   -- ZUORDNUNG : Verkaufskonzept zu Warengruppe
   -- Befuellung Tabelle ueber INIT-Skript
   -- Join ueber wg_per_2 (Gueltigkeit)
   -- 2012KW46 : Initiial (nur DE)

   SELECT
   v01.mandant_id, v01.abt_id, COALESCE(v02.vk_konzept_id, -1) AS vk_konzept_id, v01.wg_id
   FROM
   (
   SELECT
   mandant_id, abt_id, wg_id
   FROM dbp_view.v_wg_per_2
   WHERE dat_bis = '9999-12-31'
   AND arthiertyp_id = 2
   ) v01
   LEFT JOIN dbp_msi_v_view.v_vk_konzept_wg_zu_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.wg_id = v02.wg_id

   UNION ALL
   SELECT
   mandant_id, 0::SMALLINT AS abt_id, -1::SMALLINT AS vk_konzept_id, -999::SMALLINT AS wg_id
   FROM dbp_view.v_mandant_2
   WHERE mandant_id =1;