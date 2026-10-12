-- Wichtig 2 Leerzeichen
 -- ZUORDNUNG REKURSIV : Filialen mit gleichem Verteilgebiet pro Filiale

-- rekursive Zuordnung der Filialen mit gleichem Verteilgebiet
 -- benoetigt mv_wup_verbund_helper
 -- 2012KW46 Initial

-- Wichtig 2 Leerzeichen
 -- REKURSION : 1 Zeile pro Filiale in Helper/Detail auf Basis der Nummerierung

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_verbund_rekursion AS WITH RECURSIVE CTE_RECURSION AS (SELECT
   DISTINCT mandant_id,
    nb_id,
    wup_id,
    verteilgebiet_id,
    0 AS counter,
    '  ' AS wup_verbund,
    '  ' AS wup_verbund_bez
   FROM kfl_production_dbp_msi_view_vis.mv_wup_verbund_helper AS BASIS
   UNION ALL
   SELECT REKURSION.mandant_id,
    REKURSION.nb_id,
    REKURSION.wup_id,
    REKURSION.verteilgebiet_id,
     REKURSION.counter + 1 AS counter,
      REKURSION.wup_verbund || TRIM(DETAIL.v_wup_id) || ' / ' AS wup_verbund,
        REKURSION.wup_verbund_bez || TRIM(DETAIL.v_wup_id) || ' ' || TRIM(DETAIL.v_wup_standort) || ' / ' AS
    wup_verbund_bez
   FROM cte_recursion AS REKURSION
    INNER JOIN kfl_production_dbp_msi_view_vis.mv_wup_verbund_helper AS DETAIL ON REKURSION.mandant_id = DETAIL.mandant_id
        AND REKURSION.wup_id = DETAIL.wup_id AND REKURSION.counter + 1 = DETAIL.wup_count
   WHERE REKURSION.counter + 1 < 20 -- Anzahl Rekursionen
) (SELECT mandant_id,
   nb_id,
   wup_id,
   verteilgebiet_id,
   counter,
   wup_verbund,
   wup_verbund_bez
  FROM cte_recursion);