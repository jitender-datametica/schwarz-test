CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_bestwert_calc_2 AS WITH WARENGRUPPE AS (SELECT *
  FROM kfl_production_dbp_msi_view_vis.mv_wg_int_2
  WHERE owg_id IN (1010)), UMSATZ AS (SELECT U.mandant_id,
   U.nb_id,
   U.wup_id,
   U.wrg_id,
   U.arthiertyp_id,
   w.owg_id,
   U.dat,
   SUM(U.ums_brutto) AS ums_brutto
  FROM kfl_production_dbp_msi_data.vis_tag_umsatz_wg_2 AS U
   INNER JOIN WARENGRUPPE AS w ON U.wg_id = w.wg_id
  WHERE U.arthiertyp_id = 2
  GROUP BY U.mandant_id,
   U.dat,
   U.nb_id,
   U.wup_id,
   U.arthiertyp_id,
   U.wrg_id,
   w.owg_id), ABSCHRIFTEN_2 AS (SELECT A.mandant_id,
   A.nb_id,
   A.wup_id,
   A.wrg_id,
   A.arthiertyp_id,
   w.owg_id,
   A.dat,
   SUM(CASE
     WHEN ATH.abschriftart_thema_int_id IN (1, 4)
     THEN A.abschrift_brutto * -1.00
     ELSE NULL
     END) AS abschrift_op,
   SUM(CASE
     WHEN ATH.abschriftart_thema_int_id IN (1)
     THEN A.abschrift_brutto * -1.00
     ELSE NULL
     END) AS abschrift_ta,
   SUM(CASE
     WHEN ATH.abschriftart_thema_int_id IN (4)
     THEN A.abschrift_brutto * -1.00
     ELSE NULL
     END) AS abschrift_pa,
   SUM(CASE
     WHEN ATH.abschriftart_int_id IN (-1)
     THEN A.abschrift_brutto * -1.00
     ELSE NULL
     END) AS abschrift_ak
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg_2 AS A
   INNER JOIN WARENGRUPPE AS w ON A.wg_id = w.wg_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_zu_2 AS AI ON A.abschriftart_id = AI.abschriftart_id AND
     A.mandant_id = AI.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_abschriftart_int_thema_zu_2 AS ATH ON AI.abschriftart_int_id = ATH.abschriftart_int_id
    
  WHERE A.arthiertyp_id = 2
   AND (ATH.abschriftart_thema_int_id IN (1, 4) OR ATH.abschriftart_int_id IN (-1))
  GROUP BY A.mandant_id,
   A.nb_id,
   A.wup_id,
   A.wrg_id,
   A.arthiertyp_id,
   w.owg_id,
   A.dat), BESTELLFORTSCHREIBUNG AS (SELECT mandant_id,
   nb_id,
   wup_id,
   wrg_id,
   arthiertyp_id,
   owg_id,
   dat,
   umsatz_plan_brutto_owg AS ums_pl_br_owg,
   wareneingang_brutto_owg AS we_brutto_owg,
   schlussbestand_vormonat_brutto_owg AS bestand_vormo,
   datzeit_pflege
  FROM kfl_production_dbp_msi_data.ts_bestwertfortschreibung_2) (SELECT u.mandant_id,
   u.nb_id,
   W.aktuell_wup_id AS wup_id,
   u.wrg_id,
   u.arthiertyp_id,
   u.dat,
   u.owg_id,
   COALESCE(b.mandant_id, 0) AS bsw_fg,
   COALESCE(u.ums_brutto, 0.00) AS umsatz_brutto_owg,
   COALESCE(b.ums_pl_br_owg, 0.00) AS umsatz_plan_brutto_owg,
   COALESCE(a.abschrift_op, 0.00) AS abschrift_operativ_brutto_owg,
   COALESCE(a.abschrift_pa, 0.00) AS abschrift_preis_brutto_owg,
   COALESCE(a.abschrift_ta, 0.00) AS abschrift_total_brutto_owg,
   COALESCE(a.abschrift_ak, 0.00) AS abschrift_aktion_brutto_owg,
   COALESCE(b.we_brutto_owg, 0.00) AS wareneingang_brutto_owg,
   COALESCE(b.bestand_vormo, 0.00) AS bestand_vormonat_brutto_owg,
   0.00 AS schlussbestand_brutto_owg,
       COALESCE(b.bestand_vormo, 0.00) + COALESCE(b.we_brutto_owg, 0.00) - COALESCE(u.ums_brutto, 0.00) + COALESCE(a.abschrift_op
      , 0.00) + COALESCE(a.abschrift_ak, 0.00) AS bestand_calc,
   COALESCE(b.bestand_vormo, SUM(COALESCE(b.bestand_vormo, 0.00) + COALESCE(b.we_brutto_owg, 0.00) - COALESCE(u.ums_brutto
         , 0.00) + COALESCE(a.abschrift_op, 0.00) + COALESCE(a.abschrift_ak, 0.00)) OVER (PARTITION BY u.mandant_id, W.aktuell_wup_id
       , u.owg_id, u.wrg_id, EXTRACT(MONTH FROM u.dat), EXTRACT(YEAR FROM u.dat) ORDER BY u.dat NULLS LAST ROWS BETWEEN
     UNBOUNDED PRECEDING AND 1 PRECEDING), 0.00) AS anfangsbestand_brutto_owg
  FROM UMSATZ AS u
   LEFT JOIN ABSCHRIFTEN_2 AS a ON u.mandant_id = a.mandant_id AND u.wup_id = a.wup_id AND u.wrg_id = a.wrg_id AND u.owg_id
       = a.owg_id AND u.dat = a.dat
   LEFT JOIN BESTELLFORTSCHREIBUNG AS b ON u.mandant_id = b.mandant_id AND u.wup_id = b.wup_id AND u.wrg_id = b.wrg_id
     AND u.owg_id = b.owg_id AND u.dat = b.dat
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS W ON u.mandant_id = W.mandant_id AND u.wup_id = W.wup_id);