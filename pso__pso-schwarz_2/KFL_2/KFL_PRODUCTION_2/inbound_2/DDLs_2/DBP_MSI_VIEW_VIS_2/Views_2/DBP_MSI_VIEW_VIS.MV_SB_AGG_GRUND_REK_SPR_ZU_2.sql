CREATE OR REPLACE RECURSIVE VIEW DBP_MSI_VIEW_VIS.MV_SB_AGG_GRUND_REK_SPR_ZU_2 (
mandant_id
, beurteilung_id
, sb_ebene
, sb_id
, sb_grund_id
, sb_count
, sb_grund_bez
)
AS
   SELECT
   basis.mandant_id, basis.beurteilung_id, basis.sb_ebene, basis.sb_id, basis.sb_grund_id, basis.sb_count, gr_spr_zu.sb_grund_bez
   FROM dbp_msi_view_vis.mv_sb_agg_grund_helper_2 basis
   INNER JOIN dbp_msi_view_vis.mv_sb_aggregat_grund_spr_zu_2 gr_spr_zu
   ON basis.mandant_id = gr_spr_zu.mandant_id
   AND basis.sb_grund_id = gr_spr_zu.sb_grund_id
   WHERE basis.sb_count = 1

   UNION ALL   --Rekursion
   SELECT
   rekursion.mandant_id, rekursion.beurteilung_id, rekursion.sb_ebene, rekursion.sb_id, h.sb_grund_id, rekursion.sb_count +1   AS rek_count, rekursion.sb_grund_bez || ', ' || gr_spr_zu2.sb_grund_bez
   FROM mv_sb_agg_grund_rek_spr_zu_2 rekursion
   INNER JOIN dbp_msi_view_vis.mv_sb_agg_grund_helper_2 h
   ON rekursion.mandant_id = h.mandant_id
   AND rekursion.beurteilung_id = h.beurteilung_id
   AND rekursion.sb_ebene = h.sb_ebene
   AND rekursion.sb_id = h.sb_id
   AND rekursion.sb_count +1 = h.sb_count
   INNER JOIN dbp_msi_view_vis.mv_sb_aggregat_grund_spr_zu_2 gr_spr_zu2
   ON rekursion.mandant_id = gr_spr_zu2.mandant_id
   AND h.sb_grund_id = gr_spr_zu2.sb_grund_id

   ;