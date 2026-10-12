-- Rekursion
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_agg_grund_rek_spr_zu_1 AS WITH RECURSIVE CTE_RECURSION AS
  (SELECT BASIS.mandant_id,
    BASIS.beurteilung_id,
    BASIS.sb_ebene,
    BASIS.sb_id,
    BASIS.sb_grund_id,
    BASIS.sb_count,
    GR_SPR_ZU.sb_grund_bez
   FROM kfl_production_dbp_msi_view_vis.mv_sb_agg_grund_helper_1 AS BASIS
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_sb_aggregat_grund_spr_zu_1 AS GR_SPR_ZU ON BASIS.mandant_id = GR_SPR_ZU
      .mandant_id AND BASIS.sb_grund_id = GR_SPR_ZU.sb_grund_id
   WHERE BASIS.sb_count = 1
   UNION ALL
   SELECT REKURSION.mandant_id,
    REKURSION.beurteilung_id,
    REKURSION.sb_ebene,
    REKURSION.sb_id,
    H.sb_grund_id,
     REKURSION.sb_count + 1 AS sb_count,
      REKURSION.sb_grund_bez || ', ' || GR_SPR_ZU2.sb_grund_bez AS sb_grund_bez
   FROM cte_recursion AS REKURSION
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_sb_agg_grund_helper_1 AS H ON REKURSION.mandant_id = H.mandant_id AND
         REKURSION.beurteilung_id = H.beurteilung_id AND REKURSION.sb_ebene = H.sb_ebene AND REKURSION.sb_id = H.sb_id
     AND REKURSION.sb_count + 1 = H.sb_count
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_sb_aggregat_grund_spr_zu_1 AS GR_SPR_ZU2 ON REKURSION.mandant_id =
      GR_SPR_ZU2.mandant_id AND H.sb_grund_id = GR_SPR_ZU2.sb_grund_id) (SELECT mandant_id,
   beurteilung_id,
   sb_ebene,
   sb_id,
   sb_grund_id,
   sb_count,
   sb_grund_bez
  FROM cte_recursion);