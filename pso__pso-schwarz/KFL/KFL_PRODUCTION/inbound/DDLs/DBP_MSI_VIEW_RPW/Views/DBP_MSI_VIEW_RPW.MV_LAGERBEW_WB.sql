CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LAGERBEW_WB
(
mandant_id
,lagerbew_beleg_id
,best_beleg_id
,kj
,wup_id
,nb_id
,gp_id
,einkaufsorganisation_id
,betrag_lagerbew
,betrag_verkauf
,dat_buch
,dat_beleg
,dat_erfasst
,system_id
,betrag_vk_netto
,open_fg
,open_Best_fg
,teilgebucht_fg
,gemeldet_fg
,vorgangsart_id
,ek_netto
,anz_pos
--,lager_bewart_id
)

AS


   SELECT
   lb.mandant_id,
   lb.lagerbew_beleg_id,
   d.best_beleg_id    AS best_beleg_id,
   lb.kj,
   d.wup_id,
   d.nb_id,
   d.gp_id,
   d.einkaufsorganisation_id,
   d.betrag_lagerbew,
   CASE WHEN d.betrag_verkauf = 0 THEN d.betrag_lagerbew ELSE d.betrag_verkauf END  AS betrag_verkauf_,
   lb.dat_buch,
   lb.dat_beleg,
   lb.dat_erfasst,
   7 AS system_id,
   d.betrag_vk_netto,
   d.open_fg,
   0 AS open_best_fg,
   d.teilgebucht_fg,
   1 AS gemeldet_fg,
   d.vorgangsart_id,
   d.betrag_lagerbew AS ek_netto,
   d.anz_pos
   --,d.lager_bewart_id
   FROM
   dbp_view.v_lagerbew lb
   INNER JOIN
   (
   SELECT
   d.mandant_id                                    AS mandant_id,
   d.lagerbew_beleg_id                             AS lagerbew_beleg_id,
   d.kj                                            AS kj,
   d.dat_buch                                      AS dat_buch,
   d.wup_id                                        AS wup_id,
   d.nb_id                                         AS nb_id,
   d.gp_id                                         AS gp_id,
   d.einkaufsorganisation_id                       AS einkaufsorganisation_id,
   CASE WHEN d.lager_bewart_id IN ('101', '901', '905', '906', '102', '902') THEN 'WE' ELSE 'WA' END AS vorgangsart_id,
   SUM(betrag_lagerbew)                            AS betrag_lagerbew,
   SUM(COALESCE(betrag_verkauf, betrag_lagerbew))  AS betrag_verkauf,
   SUM(betrag_vk_netto)                            AS betrag_vk_netto,
   COUNT(d.mandant_id)                             AS anz_pos,
   SUM(CASE WHEN r.lagerbew_beleg_id IS NULL THEN 0 ELSE 1 END) AS anz_Gebucht,
   CASE WHEN ((anz_gebucht > 0) OR  (anz_gebucht  - anz_pos = 0))  THEN 1 ELSE 0 END AS teilgebucht_fg,
   MAX(CASE WHEN r.lagerbew_beleg_id IS NULL THEN 1 ELSE 0 END) AS open_fg,
   --MAX(lager_bewart_id) AS lager_bewart_id,
   MAX(d.best_beleg_id) AS best_beleg_id

   FROM dbp_view.v_lagerbew_det d
   LEFT OUTER JOIN dbp_view.v_besch_rech_det r
   ON r.mandant_id = d.mandant_id
   AND r.lagerbew_beleg_id = d.lagerbew_beleg_id
   AND r.lagerbew_beleg_pos_id = d.lagerbew_beleg_pos_id
   AND r.kj = d.kj

   WHERE d.einkaufsorganisation_id = 1000 AND
   d.lager_bewart_id IN ('101',  '102', '161', '162', '901', '902', '905', '906', '907', '908', '912' )

   GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9

   ) d
   ON lb.mandant_id = d.mandant_id
   AND lb.lagerbew_beleg_id = d.lagerbew_beleg_id
   AND lb.kj = d.kj
   AND lb.dat_buch = d.dat_buch

   WHERE lb.mandant_id = 1
   AND d.dat_buch = lb.dat_buch
   AND d.vorgangsart_id IN ('WA', 'WE')

   --AND d.nb_id <> 99

   UNION ALL

   SELECT
   rb.mandant_id                                             AS mandant_id,
   rb.rech_beleg_id                                          AS lagerbew_beleg_id,
   NULL     AS best_beleg_id,
   rb.gj                                                     AS kj,
   d.wup_id                                                  AS wup_id,
   d.nb_id                                                   AS nb_id,
   rb.gp_id                                                  AS gp_id,
   rb.einkaufsorganisation_id                                AS einkaufsorganisation_id,
   d.betrag_netto                                            AS betrag_lagerbew,
   CASE WHEN d.betrag_beleg = 0 THEN d.betrag_netto ELSE d.betrag_beleg END  AS betrag_verkauf_,
   rb.dat_buch                                               AS dat_buch,
   rb.dat_beleg                                              AS dat_beleg,
   CAST(rb.dat_erfasst AS DATE)                              AS dat_erfasst,
   7                                                         AS system_id,
   0                                                         AS betrag_vk_netto,
   0                                                         AS open_fg,
   0                                                         AS  open_Best_fg,
   0                                                         AS teilgebucht_fg,
   0                                                         AS gemeldet_fg,
   CASE WHEN d.row_grund_id = '107' THEN 'WA' ELSE 'WE' END  AS vorgangsart_id,
   0                                                         AS ek_netto,
   d.anz_pos                                                 AS anz_pos
   --, '' AS lager_bewart_id
   FROM
   dbp_view.v_besch_rech rb
   INNER JOIN
   (
   SELECT
   mandant_id,
   rech_beleg_id,
   gj,
   wup_id,
   nb_id,
   row_grund_id,
   SUM(betrag_netto) AS betrag_netto,
   SUM(betrag_beleg) AS betrag_beleg,
   COUNT(mandant_id) AS anz_pos
   FROM dbp_view.v_besch_rech_det_kont
   WHERE row_grund_id IN ('107', '138')
   GROUP BY 1, 2, 3, 4, 5, 6
   )d
   ON rb.mandant_id = d.mandant_id
   AND rb.rech_beleg_id = d.rech_beleg_id
   AND rb.gj = d.gj

   WHERE rb.mandant_id = 1
   AND d.row_grund_id IN ('107', '138')
   --AND d.nb_id <> 99

   UNION ALL

   SELECT
   k.mandant_id                    AS mandant_id,
   k.best_beleg_id                 AS lagerbew_beleg_id,
   k.best_beleg_id                             AS best_beleg_id,
   0                               AS kj,
   k.empfaenger_wup_id             AS wup_id,
   w.nb_id                         AS nb_id,
   k.gp_id                         AS gp_id,
   k.einkaufsorganisation_id       AS einkaufsorganisation_id,
   0                               AS betrag_lagerbew,
   0                               AS betrag_verkauf,
   k.dat_best_beleg                AS dat_buch,
   k.dat_best_beleg                AS dat_beleg,
   k.dat_best_beleg                AS dat_erfasst,
   7                               AS system_id,
   0                               AS betrag_vk_netto,
   0                               AS open_fg,
   1                               AS  open_Best_fg,
   0                               AS teilgebucht_fg,
   0                               AS gemeldet_fg,
   ''                              AS vorgangsart_id,
   0                               AS ek_netto,
   anz_pos_offen                   AS anz_pos
   --,'-1' AS lager_bewart_id
   FROM
   dbp_view.v_besch_best   k
   INNER JOIN dbp_view.v_wup w
   ON
   k.empfaenger_wup_id = w.wup_id AND
   k.mandant_id =  w.mandant_id


   WHERE k.mandant_id = 1
   and k.einkaufsorganisation_id <> 5000
 --AND w.nb_id <> 99
 ;