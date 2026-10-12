CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_MIETERTRAG_DENORM as
   -- 2013-04-11
   -- FAKTVIEW Mietertraege Debitoren pro Immobilie
   -- Denormalisiert (Spalten) ueber alle Konten
   -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten
   -- 2013-04-18 : Update / Erweiterung Salden
   -- 20130627 : Anpassung Berechnung Haben Fruehinfo, Luecken in Zeitreihe (fehlende abzug_id)

   SELECT
   sub01.mandant_id,
   sub01.debitor_id,
   sub01.immo_objekt_id,
   sub01.kjmo,
   (sub03.anz_immo)       AS anz_immo,
   (bet_miete * kurs)     AS betrag_miete,
   (bet_zahlung * kurs)   AS betrag_zahlung,
   (bet_ruecklast * kurs) AS betrag_ruecklast,
   (bet_storno * kurs)    AS betrag_storno,
   (bet_sonst * kurs)     AS betrag_sonst,
   (betrag_miete + betrag_zahlung + betrag_ruecklast + betrag_storno + betrag_sonst) AS betrag_gesamt,
   (sub02.max_abzug_id)                 AS abzug_id,
   (TRUNC(saldo_vortrag * kurs / anz_immo))    AS wert_vortrag,
   (TRUNC(summe_soll * kurs / anz_immo))       AS wert_soll,
   (wert_vortrag + wert_soll)           AS wert_faellig,
   (TRUNC(summe_haben * -1 * kurs / anz_immo)) AS wert_haben   -- Vorzeichenwechsel bleibt!
   ,
   (wert_soll + wert_haben)             AS wert_offen   -- Abgleich betrag_gesamt
   ,
   (TRUNC(saldo_konto * kurs / anz_immo))      AS wert_saldo,
   COALESCE(TRUNC((summe_haben_10) * kurs / anz_immo), 0)  AS wert_haben10,
   COALESCE(TRUNC((summe_haben_20 - summe_haben_10) * kurs / anz_immo), 0)  AS wert_haben20,
   COALESCE(TRUNC((summe_haben_30 - COALESCE(summe_haben_20, summe_haben_10)) * kurs / anz_immo), 0)  AS wert_haben30,
   COALESCE(TRUNC((summe_haben_0  - COALESCE(summe_haben_30, summe_haben_20, summe_haben_10)) * kurs / anz_immo), 0)  AS wert_haben00,
   kurs.wrg_id,
   kurs.wrg_typ_id
  FROM ( -- Mietertrag pro Debitor/Objekt gruppiert nach Belegart
  SELECT
  mandant_id,
   debitor_id,
   immo_objekt_id,
   kjmo,
   wrg_id,
   SUM(CASE WHEN (mandant_id=1 AND belegart_id IN ('AD','AM','AN','BM','BN','EK','PV'))
  OR (mandant_id<>1 AND belegart_id IN ('DG','DR','JD','JQ','RV')) THEN konto_betrag ELSE 0.00 END) AS bet_miete,
   SUM(CASE WHEN (mandant_id=1 AND belegart_id IN ('45','46','EA','EB','EE','ES','EU','GE','GZ','KO','SX'))
  OR (mandant_id<>1 AND belegart_id IN ('KO','ZP','SB')) THEN konto_betrag ELSE 0.00 END) AS bet_zahlung,
   SUM(CASE WHEN (mandant_id=1 AND belegart_id IN ('GA','GL')) THEN konto_betrag ELSE 0.00 END) AS bet_ruecklast,
   SUM(CASE WHEN (mandant_id=1 AND belegart_id IN ('31','36','37','38','39','49','79','ZE'))
  OR (mandant_id<>1 AND belegart_id IN ('JB')) THEN konto_betrag ELSE 0.00 END) AS bet_storno,
   SUM(CASE WHEN (mandant_id=1 AND belegart_id NOT IN ('AD','AM','AN','BM','BN','EK','PV','45','46','EA','EB','EE','ES','EU','GE','GZ','KO','SX','GA','GL','31','36','37','38','39','49','79','ZE'))
  OR (mandant_id<>1 AND belegart_id NOT IN ('DG','DR','JD','JQ','RV','KO','ZP','SB','JB')) THEN konto_betrag ELSE 0.00 END) AS bet_sonst
  FROM dbp_view.v_ivs_mietertrag_detail
  GROUP BY
  mandant_id
  , debitor_id
  , immo_objekt_id
  , kjmo
  , wrg_id
  ) sub01

  JOIN ( -- Offene Posten
  SELECT
  sub021.mandant_id,
   sub021.debitor_id,
   sub021.kjmo,
   sub022.max_abzug_id,
   sub021.saldo_vortrag,
   sub021.summe_soll,
   sub021.summe_haben,
   sub021.saldo_konto,
   sub022.summe_haben_10,
   sub022.summe_haben_20,
   sub022.summe_haben_30,
   sub022.summe_haben_0,
   sub021.saldo_soll,
   sub021.saldo_haben,
   sub021.wrg_id
  FROM dbp_view.v_ivs_debitor_kontostand  sub021
   JOIN ( -- Ermittlung des letzten Abzugs, Verteilung Haben pro Abzug inkl. vorzeichenwechsel
   SELECT
   mandant_id,
   debitor_id,
   kjmo,
   wrg_id,
   CASE WHEN MIN(abzug_id) = 0 THEN 0 ELSE MAX(abzug_id) END AS max_abzug_id,
   SUM(CASE WHEN abzug_id = 10 THEN summe_haben * -1 END)  AS summe_haben_10 -- Vorzeichenwechsel!
   ,
   SUM(CASE WHEN abzug_id = 20 THEN summe_haben * -1 END)  AS summe_haben_20 -- Vorzeichenwechsel!
   ,
   SUM(CASE WHEN abzug_id = 30 THEN summe_haben * -1 END)  AS summe_haben_30 -- Vorzeichenwechsel!
   ,
   SUM(CASE WHEN abzug_id =  0 THEN summe_haben * -1 END)  AS summe_haben_0  -- Vorzeichenwechsel!
  FROM dbp_view.v_ivs_debitor_kontostand

  GROUP BY
  mandant_id
  , debitor_id
  , kjmo
  , wrg_id
  ) sub022
   ON sub021.mandant_id = sub022.mandant_id
   AND sub021.debitor_id = sub022.debitor_id
   AND sub021.kjmo = sub022.kjmo
   AND sub021.abzug_id = sub022.max_abzug_id
   AND sub021.wrg_id = sub022.wrg_id
   ) sub02
   ON sub01.mandant_id = sub02.mandant_id
   AND sub01.debitor_id = sub02.debitor_id
   AND sub01.kjmo = sub02.kjmo
   AND sub01.wrg_id = sub02.wrg_id

   JOIN ( -- Anzahl Immo-Objekte pro Debitor
   SELECT
   mandant_id,
   debitor_id,
   kjmo,
   wrg_id,
   COUNT(DISTINCT immo_objekt_id) anz_immo
  FROM dbp_view.v_ivs_mietertrag_detail
  GROUP BY
  mandant_id
  , debitor_id
  , kjmo
  , wrg_id
  ) sub03
   ON sub01.mandant_id = sub03.mandant_id
   AND sub01.debitor_id = sub03.debitor_id
   AND sub01.kjmo = sub03.kjmo
   AND sub01.wrg_id = sub03.wrg_id
   INNER JOIN dbp_view.v_monat  zeit
   ON zeit.kjmo = sub01.kjmo
   INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per  kurs
   ON kurs.mandant_id = sub01.mandant_id
   AND zeit.max_dat BETWEEN kurs_dat_von AND kurs_dat_bis;