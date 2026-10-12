CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_lagerbew_wb_2 (mandant_id, lagerbew_beleg_id, best_beleg_id, kj
, wup_id, nb_id, gp_id, einkaufsorganisation_id, betrag_lagerbew, betrag_verkauf, dat_buch, dat_beleg, dat_erfasst,
system_id, betrag_vk_netto, open_fg, open_best_fg, teilgebucht_fg, gemeldet_fg, vorgangsart_id, ek_netto, anz_pos) AS
SELECT LB.mandant_id,
 LB.lagerbew_beleg_id,
 d.best_beleg_id,
 LB.kj,
 d.wup_id,
 d.nb_id,
 d.gp_id,
 d.einkaufsorganisation_id,
 d.betrag_lagerbew,
  CASE
  WHEN d.betrag_verkauf = 0
  THEN d.betrag_lagerbew
  ELSE d.betrag_verkauf
  END AS betrag_verkauf_,
 LB.dat_buch,
 LB.dat_beleg,
 LB.dat_erfasst,
 7 AS system_id,
 d.betrag_vk_netto,
 d.open_fg,
 0 AS open_best_fg,
 d.teilgebucht_fg,
 1 AS gemeldet_fg,
 d.vorgangsart_id,
 d.betrag_lagerbew AS ek_netto,
 d.anz_pos
FROM kfl_production_dbp_view.v_lagerbew_2 AS LB
 INNER JOIN (SELECT D.mandant_id,
   D.lagerbew_beleg_id,
   D.kj,
   D.dat_buch,
   D.wup_id,
   D.nb_id,
   D.gp_id,
   D.einkaufsorganisation_id,
    CASE
    WHEN D.lager_bewart_id IN ('101', '901', '905', '906', '102', '902')
    THEN 'WE'
    ELSE 'WA'
    END AS vorgangsart_id,
   SUM(D.betrag_lagerbew) AS betrag_lagerbew,
   SUM(COALESCE(D.betrag_verkauf, D.betrag_lagerbew)) AS betrag_verkauf,
   SUM(D.betrag_vk_netto) AS betrag_vk_netto,
   COUNT(D.mandant_id) AS anz_pos,
   SUM(CASE
     WHEN R.lagerbew_beleg_id IS NULL
     THEN 0
     ELSE 1
     END) AS anz_gebucht,
    CASE
    WHEN SUM(CASE
        WHEN R.lagerbew_beleg_id IS NULL
        THEN 0
        ELSE 1
        END) > 0 OR SUM(CASE
         WHEN R.lagerbew_beleg_id IS NULL
         THEN 0
         ELSE 1
         END) - COUNT(D.mandant_id) = 0
    THEN 1
    ELSE 0
    END AS teilgebucht_fg,
   MAX(CASE
     WHEN R.lagerbew_beleg_id IS NULL
     THEN 1
     ELSE 0
     END) AS open_fg,
   MAX(D.best_beleg_id) AS best_beleg_id
  FROM kfl_production_dbp_view.v_lagerbew_det_2 AS D
   LEFT JOIN kfl_production_dbp_view.v_besch_rech_det_2 AS R ON D.mandant_id = R.mandant_id AND D.lagerbew_beleg_id = R.lagerbew_beleg_id
        AND D.lagerbew_beleg_pos_id = R.lagerbew_beleg_pos_id AND D.kj = R.kj
  WHERE D.einkaufsorganisation_id = 1000
   AND D.lager_bewart_id IN ('101', '102', '161', '162', '901', '902', '905', '906', '907', '908', '912')
  GROUP BY D.mandant_id,
   D.lagerbew_beleg_id,
   D.kj,
   D.dat_buch,
   D.wup_id,
   D.nb_id,
   D.gp_id,
   D.einkaufsorganisation_id,
   vorgangsart_id) AS d ON LB.mandant_id = d.mandant_id AND LB.lagerbew_beleg_id = d.lagerbew_beleg_id AND LB.kj = d.kj
  AND LB.dat_buch = d.dat_buch
WHERE LB.mandant_id = 1
 AND d.dat_buch = LB.dat_buch
 AND d.vorgangsart_id IN ('WA', 'WE')
UNION ALL
SELECT RB.mandant_id,
 RB.rech_beleg_id AS lagerbew_beleg_id,
 CAST(NULL AS INTEGER) AS best_beleg_id,
 RB.gj AS kj,
 d.wup_id,
 d.nb_id,
 RB.gp_id,
 RB.einkaufsorganisation_id,
 d.betrag_netto AS betrag_lagerbew,
  CASE
  WHEN d.betrag_beleg = 0
  THEN d.betrag_netto
  ELSE d.betrag_beleg
  END AS betrag_verkauf_,
 RB.dat_buch,
 RB.dat_beleg,
 DATE(RB.dat_erfasst) AS dat_erfasst,
 7 AS system_id,
 0 AS betrag_vk_netto,
 0 AS open_fg,
 0 AS open_best_fg,
 0 AS teilgebucht_fg,
 0 AS gemeldet_fg,
  CASE
  WHEN d.row_grund_id = '107'
  THEN 'WA'
  ELSE 'WE'
  END AS vorgangsart_id,
 0 AS ek_netto,
 d.anz_pos
FROM kfl_production_dbp_view.v_besch_rech_2 AS RB
 INNER JOIN (SELECT mandant_id,
   rech_beleg_id,
   gj,
   wup_id,
   nb_id,
   row_grund_id,
   SUM(betrag_netto) AS betrag_netto,
   SUM(betrag_beleg) AS betrag_beleg,
   COUNT(mandant_id) AS anz_pos
  FROM kfl_production_dbp_view.v_besch_rech_det_kont_2
  WHERE row_grund_id IN ('107', '138')
  GROUP BY rech_beleg_id,
   gj,
   mandant_id,
   row_grund_id,
   wup_id,
   nb_id) AS d ON RB.mandant_id = d.mandant_id AND RB.rech_beleg_id = d.rech_beleg_id AND RB.gj = d.gj
WHERE RB.mandant_id = 1
 AND d.row_grund_id IN ('107', '138')
UNION ALL
SELECT K.mandant_id,
 K.best_beleg_id AS lagerbew_beleg_id,
 K.best_beleg_id,
 0 AS kj,
 K.empfaenger_wup_id AS wup_id,
 W.nb_id,
 K.gp_id,
 K.einkaufsorganisation_id,
 0 AS betrag_lagerbew,
 0 AS betrag_verkauf,
 K.dat_best_beleg AS dat_buch,
 K.dat_best_beleg AS dat_beleg,
 K.dat_best_beleg AS dat_erfasst,
 7 AS system_id,
 0 AS betrag_vk_netto,
 0 AS open_fg,
 1 AS open_best_fg,
 0 AS teilgebucht_fg,
 0 AS gemeldet_fg,
 '' AS vorgangsart_id,
 0 AS ek_netto,
 K.anz_pos_offen AS anz_pos
FROM kfl_production_dbp_view.v_besch_best_2 AS K
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS W ON K.empfaenger_wup_id = W.wup_id AND K.mandant_id = W.mandant_id
WHERE K.mandant_id = 1
 AND K.einkaufsorganisation_id <> 5000;