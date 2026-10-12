-- benoetigt mv_sm_food_helper
 -- rekursive Zuordnung von Profilierungs-WG mit abw. SM zu SM/SST Food

-- REKURSION : 1 Zeile pro WG in Helper/Detail auf Basis von WG Nummerierung
 -- Wichtig 2 Leerzeichen

-- References the CTE, not the View
 -- 2012KW46 Initial (Q2)
 -- FINAL SELECTION

-- ZUORDNUNG REKURSIV : Sortimentkategorie/Profilierungswarengruppen Food SB pro Filiale
 -- Wichtig 2 Leerzeichen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sm_food_rekursion AS WITH RECURSIVE CTE_RECURSION AS (SELECT DISTINCT
    -- BASIS : 1 Zeile pro Filiale
 mandant_id,
    nb_id,
    wup_id,
    sst_food_id,
    0 AS counter,
    '  ' AS wg_food,
    '  ' AS wg_food_bez
   FROM kfl_production_dbp_msi_view_vis.mv_sm_food_helper AS BASIS
   UNION ALL
   SELECT REKURSION.mandant_id,
    REKURSION.nb_id,
    REKURSION.wup_id,
    REKURSION.sst_food_id,
     REKURSION.counter + 1 AS counter,
      REKURSION.wg_food || DETAIL.wg || ', ' AS wg_food,
      REKURSION.wg_food_bez || DETAIL.wg_bez || ', ' AS wg_food_bez
   FROM cte_recursion AS REKURSION
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_sm_food_helper AS DETAIL ON REKURSION.mandant_id = DETAIL.mandant_id
      AND REKURSION.wup_id = DETAIL.wup_id AND REKURSION.counter + 1 = DETAIL.wg_count
   WHERE REKURSION.counter + 1 < 25 -- Anzahl Rekursionen
) (SELECT mandant_id,
   nb_id,
   wup_id,
   sst_food_id,
   counter,
   wg_food,
   wg_food_bez
  FROM cte_recursion);