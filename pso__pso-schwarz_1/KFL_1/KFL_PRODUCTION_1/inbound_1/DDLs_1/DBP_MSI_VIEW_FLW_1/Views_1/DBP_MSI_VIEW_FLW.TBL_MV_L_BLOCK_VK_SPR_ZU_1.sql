CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_L_BLOCK_VK_SPR_ZU_1 
-- 08.01.2014 twie: Sprachtabelle fuer Mutter-Kind Block, von AIS_DE uebernommen
--19.09.2018 naku:  WG Umstellung und Anpassungen: Alte wg_id durch neue ersetzt
(
   muki_block_vk_id,
   mandant_id,
   muki_block_vk_bez,
   spr_id
) AS
SELECT
   v01.art_id AS muki_block_vk_id,
   v01.mandant_id,
   v02.art_bez AS muki_block_vk_bez,
   v02.spr_id
FROM
   dbp_view.v_art_1 v01
   INNER JOIN dbp_view.v_art_spr_zu_1 v02 ON v01.art_id = v02.art_id
   AND v01.mandant_id = v02.mandant_id
   INNER JOIN dbp_view.v_art_wg_zu_per_1 v04 ON v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id -- Mutterartikel kann selbst keine weitere Mutter haben
WHERE
   (
      v01.mutter_vk_id IS NULL
      OR v01.mutter_vk_id = v01.art_id
   )
   AND v01.dat_bis = '9999-12-31'
   AND v01.mandant_id IN (1, 2) -- eindeutigen Datensatz aus art_wg_zu_per_1 ermitteln
   AND v04.dat_bis = '9999-12-31'
   AND v04.arthiertyp_id = 2 -- nur FLW Artikel_1
   -- Naku  Alte wg_id (1, 2, 3, 5, 9, 10, 12, 13, 19) durch neue laut Mapping Tabelle in SPEC0034878 ersetzt
   AND v04.wg_id IN (
      003,
      122,
      128,
      134,
      135,
      136,
      137,
      138,
      139,
      141,
      142,
      144,
      145,
      146,
      147,
      158,
      159,
      184,
      186,
      232,
      233,
      234,
      235,
      236,
      237,
      238,
      239,
      331,
      242,
      243,
      244,
      245,
      246
   );