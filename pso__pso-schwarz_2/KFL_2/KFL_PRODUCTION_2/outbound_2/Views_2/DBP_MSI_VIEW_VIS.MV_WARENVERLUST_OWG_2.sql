CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_warenverlust_owg_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), wup_id
OPTIONS(description='Der\""WUP_2\"" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter WUP_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
owg_hist_id OPTIONS(description='ID der Oberwarengruppe'), hwg_hist_id OPTIONS(description='ID der Hauptwarengruppe'),
abt_hist_id
OPTIONS(description='Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), inventurart_id
OPTIONS(description='Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.'),
dat_inventur_von
OPTIONS(description='Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.'),
dat_inventur_bis
OPTIONS(description='Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.'),
gj
OPTIONS(description='Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.'),
cnt_inv OPTIONS(description='Anzahl an Inventuren'), wv_umsatz_netto
OPTIONS(description='Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_preisabschrift_netto
OPTIONS(description='Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_totalabschrift_netto
OPTIONS(description='Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_menge_inventur
OPTIONS(description='Saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)'),
wv_inventur_netto_basis
OPTIONS(description='Saldierte Inventur_2-Differenz-Werte je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)'),
wv_inventur_netto_kalk
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum (nur auf OWG-Ebene vorhanden)'),
wv_inventur_netto
OPTIONS(description='Summe von saldierten und geplanten Inventurdifferenz-Werten im definierten Inventur_2-Zeitraum'),
wv_inventur_diebstahl_netto
OPTIONS(description='Betrag Diebstahl als Teilmenge der Inventur_2-Differenz-Werten (auf OWG-Ebene aggregiert)'),
wv_umsatz_netto_aufg
OPTIONS(description='Aufgelaufener Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_preisabschrift_netto_aufg
OPTIONS(description='Aufgelaufener Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_totalabschrift_netto_aufg
OPTIONS(description='Aufgelaufener Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_menge_inventur_aufg
OPTIONS(description='Aufgelaufene Saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)'),
wv_inventur_netto_aufg
OPTIONS(description='Aufgelaufene Summe von saldierten und geplanten Inventurdifferenz-Werten im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)'),
wv_umsatz_netto_vj_aufg
OPTIONS(description='Im VJ aufgelaufener Umsatz der betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_preisabschrift_netto_vj_aufg
OPTIONS(description='Im VJ aufgelaufener Wert der Preisabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_totalabschrift_netto_vj_aufg
OPTIONS(description='Im VJ aufgelaufener Wert der Totalabschriften für die betroffenen Inventur_2-Artikel_2 im definierten Inventur_2-Zeitraum je Betrieb (auf OWG-Ebene aggregiert)'),
wv_menge_inventur_vj_aufg
OPTIONS(description='Im VJ aufgelaufene Saldierte Inventur_2-Differenz-Mengen je Artikel_2 und Betrieb im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)'),
wv_inventur_netto_vj_aufg
OPTIONS(description='Im VJ aufgelaufene Summe von saldierten und geplanten Inventurdifferenz-Werten im definierten Inventur_2-Zeitraum (auf OWG-Ebene aggregiert)'),
wv_umsatz_netto_aufg_diff
OPTIONS(description='Absolute Differenz des aufgelaufenen Umsatzes vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)'),
wv_preisabschrift_netto_aufg_diff
OPTIONS(description='Absolute Differenz des aufgelaufenen Werts der Preisabschriften vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)'),
wv_totalabschrift_netto_aufg_diff
OPTIONS(description='Absolute Differenz des aufgelaufenen Werts der Totalabschriften vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)'),
wv_menge_inventur_aufg_diff
OPTIONS(description='Absolute Differenz der aufgelaufenen saldierten Inventur_2-Differenz-Mengen vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)'),
wv_inventur_netto_aufg_diff
OPTIONS(description='Absolute Differenz der Summe von saldierten und geplanten Inventurdifferenz-Werten vom aktuellem Jahr zum VJ (auf OWG-Ebene aggregiert)'),
betrag_vk_netto_plan OPTIONS(description='Geplanter Umsatz je OWG und Markt'), betrag_vk_netto_inventur_diff_plan
OPTIONS(description='Geplante Inventurdifferenz je OWG, Inventurart und Markt')) AS WITH FACTS_WARENVERLUST AS (SELECT
   mandant_id,
   wup_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj,
   COUNT(DISTINCT inventur_id) AS cnt_inv,
   SUM(wv_umsatz_netto) AS wv_umsatz_netto,
   SUM(wv_preisabschrift_netto) AS wv_preisabschrift_netto,
   SUM(wv_totalabschrift_netto) AS wv_totalabschrift_netto,
   SUM(wv_menge_inventur) AS wv_menge_inventur,
   SUM(wv_inventur_netto) AS wv_inventur_netto_basis,
   SUM(wv_inventur_diebstahl_netto) AS wv_inventur_diebstahl_netto
  FROM kfl_production_dbp_msi_view_vis.mv_warenverlust_2
  GROUP BY mandant_id,
   wup_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj), FACTS_KALKULATORISCH AS (SELECT I.mandant_id,
   WUP.aktuell_wup_id AS wup_id,
   I.owg_id AS owg_hist_id,
   H.hwg_id AS hwg_hist_id,
   H.abt_id AS abt_hist_id,
   'EUR' AS wrg_id,
   I.inventurart_id,
   I.dat_inventur_von,
   I.dat_inventur_bis,
   I.gj,
   SUM(I.betrag_vk_netto_inventur_diff_kalk) AS inventur_netto
  FROM kfl_production_dbp_view.v_inventur_warenverlust_kalk_2 AS I
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON I.mandant_id = WUP.mandant_id AND I.wup_id = WUP.wup_id
   INNER JOIN kfl_production_dbp_data.owg_per_2 AS O ON I.mandant_id = O.mandant_id AND I.owg_id = O.owg_id AND I.dat_inventur_bis
      BETWEEN O.dat_von AND O.dat_bis AND O.arthiertyp_id = 2
   INNER JOIN kfl_production_dbp_data.hwg_per_2 AS H ON O.mandant_id = H.mandant_id AND O.hwg_id = H.hwg_id AND I.dat_inventur_bis
      BETWEEN H.dat_von AND H.dat_bis AND H.arthiertyp_id = 2
  GROUP BY I.mandant_id,
   wup_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   I.inventurart_id,
   I.dat_inventur_von,
   I.dat_inventur_bis,
   I.gj), FACTS_COMBINED AS (SELECT w.mandant_id,
   w.wup_id,
   w.owg_hist_id,
   w.hwg_hist_id,
   w.abt_hist_id,
   w.wrg_id,
   w.inventurart_id,
   w.dat_inventur_von,
   w.dat_inventur_bis,
   w.gj,
   w.cnt_inv,
   w.wv_umsatz_netto,
   w.wv_preisabschrift_netto,
   w.wv_totalabschrift_netto,
   w.wv_menge_inventur,
   w.wv_inventur_netto_basis,
   k.inventur_netto AS wv_inventur_netto_kalk,
    IFNULL(w.wv_inventur_netto_basis, 0) + IFNULL(k.inventur_netto, 0) AS wv_inventur_netto,
   w.wv_inventur_diebstahl_netto
  FROM FACTS_WARENVERLUST AS w
   LEFT JOIN FACTS_KALKULATORISCH AS k ON w.mandant_id = k.mandant_id AND w.wup_id = k.wup_id AND w.owg_hist_id = k.owg_hist_id
            AND w.hwg_hist_id = k.hwg_hist_id AND w.abt_hist_id = k.abt_hist_id AND w.wrg_id = k.wrg_id AND w.inventurart_id
        = k.inventurart_id AND w.dat_inventur_bis = k.dat_inventur_bis AND w.gj = k.gj), FACTS_CUMULATED AS (SELECT
   mandant_id,
   wup_id,
   owg_hist_id,
   hwg_hist_id,
   abt_hist_id,
   wrg_id,
   inventurart_id,
   dat_inventur_von,
   dat_inventur_bis,
   gj,
   cnt_inv,
   wv_umsatz_netto,
   wv_preisabschrift_netto,
   wv_totalabschrift_netto,
   wv_menge_inventur,
   wv_inventur_netto_basis,
   wv_inventur_netto_kalk,
   wv_inventur_netto,
   wv_inventur_diebstahl_netto,
   SUM(CASE
     WHEN inventurart_id IN (1, 2, 3, 4, 5)
     THEN IFNULL(wv_umsatz_netto, 0)
     ELSE NULL
     END) OVER (PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id ORDER BY dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_umsatz_netto_aufg,
   SUM(CASE
     WHEN inventurart_id IN (1, 2, 3, 4, 5)
     THEN IFNULL(wv_preisabschrift_netto, 0)
     ELSE NULL
     END) OVER (PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id ORDER BY dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_preisabschrift_netto_aufg,
   SUM(CASE
     WHEN inventurart_id IN (1, 2, 3, 4, 5)
     THEN IFNULL(wv_totalabschrift_netto, 0)
     ELSE NULL
     END) OVER (PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id ORDER BY dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_totalabschrift_netto_aufg,
   SUM(CASE
     WHEN inventurart_id IN (1, 2, 3, 4, 5)
     THEN IFNULL(wv_menge_inventur, 0)
     ELSE NULL
     END) OVER (PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id ORDER BY dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_menge_inventur_aufg,
   SUM(CASE
     WHEN inventurart_id IN (1, 2, 3, 4, 5)
     THEN IFNULL(wv_inventur_netto, 0)
     ELSE NULL
     END) OVER (PARTITION BY mandant_id, wup_id, wrg_id, owg_hist_id, gj, inventurart_id ORDER BY dat_inventur_bis
      NULLS LAST ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS wv_inventur_netto_aufg
  FROM FACTS_COMBINED), FACTS_MAPPED_PREVIOUS_YEAR AS (SELECT f.mandant_id,
   f.wup_id,
   f.owg_hist_id,
   f.hwg_hist_id,
   f.abt_hist_id,
   f.wrg_id,
   f.inventurart_id,
   f.dat_inventur_von,
   f.dat_inventur_bis,
   f.gj,
   f.cnt_inv,
   f.wv_umsatz_netto,
   f.wv_preisabschrift_netto,
   f.wv_totalabschrift_netto,
   f.wv_menge_inventur,
   f.wv_inventur_netto_basis,
   f.wv_inventur_netto_kalk,
   f.wv_inventur_netto,
   f.wv_inventur_diebstahl_netto,
   f.wv_umsatz_netto_aufg,
   f.wv_preisabschrift_netto_aufg,
   f.wv_totalabschrift_netto_aufg,
   f.wv_menge_inventur_aufg,
   f.wv_inventur_netto_aufg,
    CASE
    WHEN f.inventurart_id IN (2, 3, 4, 5)
    THEN vji.wv_umsatz_netto_aufg
    WHEN f.inventurart_id IN (1)
    THEN vj.wv_umsatz_netto_aufg
    ELSE NULL
    END AS wv_umsatz_netto_vj_aufg,
    CASE
    WHEN f.inventurart_id IN (2, 3, 4, 5)
    THEN vji.wv_preisabschrift_netto_aufg
    WHEN f.inventurart_id IN (1)
    THEN vj.wv_preisabschrift_netto_aufg
    ELSE NULL
    END AS wv_preisabschrift_netto_vj_aufg,
    CASE
    WHEN f.inventurart_id IN (2, 3, 4, 5)
    THEN vji.wv_totalabschrift_netto_aufg
    WHEN f.inventurart_id IN (1)
    THEN vj.wv_totalabschrift_netto_aufg
    ELSE NULL
    END AS wv_totalabschrift_netto_vj_aufg,
    CASE
    WHEN f.inventurart_id IN (2, 3, 4, 5)
    THEN vji.wv_menge_inventur_aufg
    WHEN f.inventurart_id IN (1)
    THEN vj.wv_menge_inventur_aufg
    ELSE NULL
    END AS wv_menge_inventur_vj_aufg,
    CASE
    WHEN f.inventurart_id IN (2, 3, 4, 5)
    THEN vji.wv_inventur_netto_aufg
    WHEN f.inventurart_id IN (1)
    THEN vj.wv_inventur_netto_aufg
    ELSE NULL
    END AS wv_inventur_netto_vj_aufg,
    f.wv_umsatz_netto_aufg - CASE
     WHEN f.inventurart_id IN (2, 3, 4, 5)
     THEN vji.wv_umsatz_netto_aufg
     WHEN f.inventurart_id IN (1)
     THEN vj.wv_umsatz_netto_aufg
     ELSE NULL
     END AS wv_umsatz_netto_aufg_diff,
    f.wv_preisabschrift_netto_aufg - CASE
     WHEN f.inventurart_id IN (2, 3, 4, 5)
     THEN vji.wv_preisabschrift_netto_aufg
     WHEN f.inventurart_id IN (1)
     THEN vj.wv_preisabschrift_netto_aufg
     ELSE NULL
     END AS wv_preisabschrift_netto_aufg_diff,
    f.wv_totalabschrift_netto_aufg - CASE
     WHEN f.inventurart_id IN (2, 3, 4, 5)
     THEN vji.wv_totalabschrift_netto_aufg
     WHEN f.inventurart_id IN (1)
     THEN vj.wv_totalabschrift_netto_aufg
     ELSE NULL
     END AS wv_totalabschrift_netto_aufg_diff,
    f.wv_menge_inventur_aufg - CASE
     WHEN f.inventurart_id IN (2, 3, 4, 5)
     THEN vji.wv_menge_inventur_aufg
     WHEN f.inventurart_id IN (1)
     THEN vj.wv_menge_inventur_aufg
     ELSE NULL
     END AS wv_menge_inventur_aufg_diff,
    f.wv_inventur_netto_aufg - CASE
     WHEN f.inventurart_id IN (2, 3, 4, 5)
     THEN vji.wv_inventur_netto_aufg
     WHEN f.inventurart_id IN (1)
     THEN vj.wv_inventur_netto_aufg
     ELSE NULL
     END AS wv_inventur_netto_aufg_diff
  FROM FACTS_CUMULATED AS f
   LEFT JOIN FACTS_CUMULATED AS vj ON f.mandant_id = vj.mandant_id AND f.wup_id = vj.wup_id AND f.owg_hist_id = vj.owg_hist_id
            AND f.hwg_hist_id = vj.hwg_hist_id AND f.abt_hist_id = vj.abt_hist_id AND f.wrg_id = vj.wrg_id AND f.inventurart_id
        = vj.inventurart_id AND f.gj - 1 = vj.gj AND DATE_ADD(f.dat_inventur_bis, INTERVAL (-1) YEAR) BETWEEN vj.dat_inventur_von
     AND vj.dat_inventur_bis
   LEFT JOIN FACTS_CUMULATED AS vji ON f.mandant_id = vji.mandant_id AND f.wup_id = vji.wup_id AND f.owg_hist_id = vji.owg_hist_id
            AND f.hwg_hist_id = vji.hwg_hist_id AND f.abt_hist_id = vji.abt_hist_id AND f.wrg_id = vji.wrg_id AND f.inventurart_id
        IN (2, 3, 4, 5) AND vji.inventurart_id = 1 AND f.gj - 1 = vji.gj), JAHRES_BEGINN_ENDE AS (SELECT DISTINCT gj,
   MIN(dat) OVER (PARTITION BY gj RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS first_day_of_by,
   MAX(dat) OVER (PARTITION BY gj RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_day_of_by
  FROM kfl_production_dbp_view.v_tag_2), PLANNING_KPIS AS (SELECT P.mandant_id,
   P.wup_id,
   P.nb_id,
   P.gj,
   j.first_day_of_by,
   j.last_day_of_by,
   P.inventurart_id,
   P.owg_id,
   H2.hwg_id,
   A.abt_id,
   P.wrg_id,
   P.betrag_vk_netto,
   P.betrag_vk_netto_inventur_diff_plan
  FROM kfl_production_dbp_view.v_inventur_plan_2 AS P
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_owg_int_2 AS H2 ON P.owg_id = H2.owg_id
   LEFT JOIN kfl_production_dbp_msi_view_vis.mv_hwg_int_2 AS A ON H2.hwg_id = A.hwg_id
   LEFT JOIN JAHRES_BEGINN_ENDE AS j ON P.gj = j.gj) (SELECT COALESCE(f.mandant_id, p.mandant_id) AS mandant_id,
   COALESCE(f.wup_id, p.wup_id) AS wup_id,
   COALESCE(f.owg_hist_id, p.owg_id) AS owg_hist_id,
   COALESCE(f.hwg_hist_id, p.hwg_id) AS hwg_hist_id,
   COALESCE(f.abt_hist_id, p.abt_id) AS abt_hist_id,
   COALESCE(f.wrg_id, p.wrg_id) AS wrg_id,
   COALESCE(f.inventurart_id, p.inventurart_id) AS inventurart_id,
   COALESCE(f.dat_inventur_von, p.first_day_of_by) AS dat_inventur_von,
   COALESCE(f.dat_inventur_bis, p.last_day_of_by) AS dat_inventur_bis,
   COALESCE(f.gj, p.gj) AS gj,
   f.cnt_inv,
   f.wv_umsatz_netto,
   f.wv_preisabschrift_netto,
   f.wv_totalabschrift_netto,
   f.wv_menge_inventur,
   f.wv_inventur_netto_basis,
   f.wv_inventur_netto_kalk,
   f.wv_inventur_netto,
   f.wv_inventur_diebstahl_netto,
   f.wv_umsatz_netto_aufg,
   f.wv_preisabschrift_netto_aufg,
   f.wv_totalabschrift_netto_aufg,
   f.wv_menge_inventur_aufg,
   f.wv_inventur_netto_aufg,
   f.wv_umsatz_netto_vj_aufg,
   f.wv_preisabschrift_netto_vj_aufg,
   f.wv_totalabschrift_netto_vj_aufg,
   f.wv_menge_inventur_vj_aufg,
   f.wv_inventur_netto_vj_aufg,
   f.wv_umsatz_netto_aufg_diff,
   f.wv_preisabschrift_netto_aufg_diff,
   f.wv_totalabschrift_netto_aufg_diff,
   f.wv_menge_inventur_aufg_diff,
   f.wv_inventur_netto_aufg_diff,
   p.betrag_vk_netto AS betrag_vk_netto_plan,
   p.betrag_vk_netto_inventur_diff_plan
  FROM FACTS_MAPPED_PREVIOUS_YEAR AS f
   FULL JOIN PLANNING_KPIS AS p ON f.mandant_id = p.mandant_id AND f.wup_id = p.wup_id AND f.gj = p.gj AND f.inventurart_id
        = p.inventurart_id AND f.wrg_id = p.wrg_id AND f.owg_hist_id = p.owg_id);