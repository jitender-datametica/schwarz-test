CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cost_store_basis AS /* Todo: Add SAP LJ cost */
-- Uitsplitsing overige kosten
 SELECT store_cost.orig_store_nr,
 store_cost.cy_month,
 store_cost.classification_2,
 store_cost.kosten_total,
 store_cost.kosten_contractlonen,
 store_cost.kosten_gewerkte_uren_oproep,
 store_cost.kosten_meeruren,
 store_cost.kosten_toeslaguren,
 store_cost.kosten_uitbet_vakantierechten_adv,
 store_cost.kosten_betaalde_feestdaguren,
 store_cost.reservering_hk_meer_toeslag,
 store_cost.kosten_total_overige_temp,
 store_cost.kosten_total_overige,
 store_cost.kosten_externe,
 store_cost.kosten_afkoopsom,
 store_cost.kosten_ziekengeld,
 store_cost.kosten_premiebedragen,
 store_cost.kosten_vakantietoeslag,
 store_cost.kosten_kalkulatorische_pk,
 store_cost.kosten_sociale_lasten,
 store_cost.kosten_vut_en_pensioen,
 store_cost.kosten_overig,
 store_cost.kosten_geen_personeelskosten,
 PLAN.plan_turnover_netto,
 PLAN.plan_cost_total_perc,
 PLAN.plan_cost_total_abs,
 PLAN.plan_perf_netto,
 PLAN.plan_perf_hours_netto
FROM (SELECT C_CENTER.orig_store_nr,
   ALL_COST.cy_month,
   C_CENTER.classification_2,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Contractlonen') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_contractlonen,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Gewerkte uren (oproep)') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_gewerkte_uren_oproep,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Meeruren') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_meeruren,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Toeslaguren') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_toeslaguren,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Uitbet. Vakantierechten/ADV') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_uitbet_vakantierechten_adv,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Betaalde feestdaguren') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_betaalde_feestdaguren,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Reservering HK-Meer-Toeslag') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS reservering_hk_meer_toeslag,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Externe') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_externe,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Afkoopsom') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_afkoopsom,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Ziekengeld') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_ziekengeld,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Premiebedragen') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_premiebedragen,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Vakantietoeslag') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_vakantietoeslag,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Kalkulatorische PK') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_kalkulatorische_pk,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Sociale lasten') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_sociale_lasten,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten VUT en Pensioen') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_vut_en_pensioen,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Overig') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_overig,
   SUM(CASE
     WHEN ALL_COST.cost_component_desc LIKE '%Kosten Afkoopsom%' OR ALL_COST.cost_component_desc LIKE
             '%Kosten Ziekengeld%' OR ALL_COST.cost_component_desc LIKE '%Kosten Premiebedragen%' OR ALL_COST.cost_component_desc
           LIKE '%Kosten Vakantietoeslag%' OR ALL_COST.cost_component_desc LIKE '%Kosten Kalkulatorische PK%' OR
         ALL_COST.cost_component_desc LIKE '%Kosten Sociale lasten%' OR ALL_COST.cost_component_desc LIKE
        '%Kosten VUT en Pensioen%' OR ALL_COST.cost_component_desc LIKE '%Kosten Overig%'
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_total_overige_temp,
    SUM(CASE
      WHEN ALL_COST.cost_component_desc LIKE '%Kosten Afkoopsom%' OR ALL_COST.cost_component_desc LIKE
              '%Kosten Ziekengeld%' OR ALL_COST.cost_component_desc LIKE '%Kosten Premiebedragen%' OR ALL_COST.cost_component_desc
            LIKE '%Kosten Vakantietoeslag%' OR ALL_COST.cost_component_desc LIKE '%Kosten Kalkulatorische PK%' OR
          ALL_COST.cost_component_desc LIKE '%Kosten Sociale lasten%' OR ALL_COST.cost_component_desc LIKE
         '%Kosten VUT en Pensioen%' OR ALL_COST.cost_component_desc LIKE '%Kosten Overig%'
      THEN ALL_COST.saldo_amount
      ELSE 0
      END) - SUM(CASE
      WHEN STRPOS(ALL_COST.cost_component_desc, 'Reservering HK-Meer-Toeslag') <> 0
      THEN ALL_COST.saldo_amount
      ELSE 0
      END) AS kosten_total_overige,
           SUM(CASE
             WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Contractlonen') <> 0
             THEN ALL_COST.saldo_amount
             ELSE 0
             END) + SUM(CASE
             WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Gewerkte uren (oproep)') <> 0
             THEN ALL_COST.saldo_amount
             ELSE 0
             END) + SUM(CASE
            WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Meeruren') <> 0
            THEN ALL_COST.saldo_amount
            ELSE 0
            END) + SUM(CASE
           WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Toeslaguren') <> 0
           THEN ALL_COST.saldo_amount
           ELSE 0
           END) + SUM(CASE
          WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Uitbet. Vakantierechten/ADV') <> 0
          THEN ALL_COST.saldo_amount
          ELSE 0
          END) + SUM(CASE
         WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Betaalde feestdaguren') <> 0
         THEN ALL_COST.saldo_amount
         ELSE 0
         END) + (SUM(CASE
          WHEN ALL_COST.cost_component_desc LIKE '%Kosten Afkoopsom%' OR ALL_COST.cost_component_desc LIKE
                  '%Kosten Ziekengeld%' OR ALL_COST.cost_component_desc LIKE '%Kosten Premiebedragen%' OR ALL_COST.cost_component_desc
                LIKE '%Kosten Vakantietoeslag%' OR ALL_COST.cost_component_desc LIKE '%Kosten Kalkulatorische PK%' OR
              ALL_COST.cost_component_desc LIKE '%Kosten Sociale lasten%' OR ALL_COST.cost_component_desc LIKE
             '%Kosten VUT en Pensioen%' OR ALL_COST.cost_component_desc LIKE '%Kosten Overig%'
          THEN ALL_COST.saldo_amount
          ELSE 0
          END) - SUM(CASE
          WHEN STRPOS(ALL_COST.cost_component_desc, 'Reservering HK-Meer-Toeslag') <> 0
          THEN ALL_COST.saldo_amount
          ELSE 0
          END)) + SUM(CASE
       WHEN STRPOS(ALL_COST.cost_component_desc, 'Reservering HK-Meer-Toeslag') <> 0
       THEN ALL_COST.saldo_amount
       ELSE 0
       END) + SUM(CASE
      WHEN STRPOS(ALL_COST.cost_component_desc, 'Kosten Externe') <> 0
      THEN ALL_COST.saldo_amount
      ELSE 0
      END) AS kosten_total,
   SUM(CASE
     WHEN STRPOS(ALL_COST.cost_component_desc, 'Geen Personeelskosten') <> 0
     THEN ALL_COST.saldo_amount
     ELSE 0
     END) AS kosten_geen_personeelskosten
  FROM ldl_s_conl_workbench.v_cost_all AS ALL_COST
   INNER JOIN ldl_s_conl_workbench.v_m_cost_center_all AS C_CENTER ON ALL_COST.cost_center = C_CENTER.cost_center AND
    C_CENTER.orig_store_nr IS NOT NULL
  GROUP BY C_CENTER.orig_store_nr,
   ALL_COST.cy_month,
   C_CENTER.classification_2) AS store_cost
 LEFT JOIN ldl_s_conl_workbench.v_cost_perf_plan_fm101 AS PLAN ON store_cost.orig_store_nr = PLAN.orig_store_nr AND
   store_cost.cy_month = PLAN.cy_month;