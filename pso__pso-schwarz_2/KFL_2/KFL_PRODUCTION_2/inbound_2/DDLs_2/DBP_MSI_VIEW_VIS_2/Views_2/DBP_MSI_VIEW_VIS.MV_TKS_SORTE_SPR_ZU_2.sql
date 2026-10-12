CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_TKS_SORTE_SPR_ZU_2 as
   -- SPRACHE Kraftstoffsorten
   -- Tankstellen nur DE
   -- 20120229 INITIAL

   SELECT DISTINCT
   v01.mandant_id, v01.tks_sorte_id, v01.tks_sorte_bez, '22'::SMALLINT AS spr_id
   FROM dbp_view.v_vis_tag_tks_sorte_2 v01
   WHERE v01.mandant_id = 1;