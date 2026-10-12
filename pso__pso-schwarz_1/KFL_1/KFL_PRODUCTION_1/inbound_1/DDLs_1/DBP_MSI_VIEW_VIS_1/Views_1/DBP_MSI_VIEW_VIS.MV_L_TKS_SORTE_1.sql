CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_TKS_SORTE_1 as
   -- LOOKUP Kraftstoffsorten
   -- Tankstellen nur DE
   -- 20120229 INITIAL

   SELECT DISTINCT
   v01.mandant_id, v01.tks_sorte_id
   FROM dbp_view.v_vis_tag_tks_sorte_1 v01
   WHERE mandant_id = 1;