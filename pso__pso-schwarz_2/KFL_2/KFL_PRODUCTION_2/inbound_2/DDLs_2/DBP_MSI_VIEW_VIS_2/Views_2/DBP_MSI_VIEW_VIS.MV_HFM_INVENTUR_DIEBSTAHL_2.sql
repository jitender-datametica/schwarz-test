CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_HFM_INVENTUR_DIEBSTAHL_2 as
   -- FAKT : Diebstahl und Bestandskorrekturen pro Filiale und WG - abhaengig von Inventur_2
   -- Datenbasis VIS Marktabschriften_2 + HFM Inventur_2
   -- 2017.0620 : Initial, VTC Inventur_2
   -- 2017.0815 : Update, Outer Join Umsatz
   -- 2017.1110 : Anpassung Umrechnung/Landeswaehrung
   -- 2017.1124 : Review Logik Diebstahl, Umsatz Inventurzeitraum ergaenzt
   -- 2018.0419 : Review Umsatz, Diebstahl fuer akt. GJ ergaenzt, Jahresinventur ausgeschlossen

   SELECT
   mandant_id, nb_id, wup_id, wrg_id, wg_id, zeit.gj, inv_fg, dat_inv   -- letzte Inventur_2 ODER gestern
   , SUM(ums_netto)                 AS inv_ums_GES, SUM(ums_netto * inv_fg)        AS inv_ums_bis_inv, inv_ums_GES - inv_ums_bis_inv  AS inv_ums_nach_inv, SUM(inv_diebstahl)                         AS inv_diebstahl_GES, SUM(inv_diebstahl * inv_fg)                AS inv_diebstahl_bis_inv, SUM(inv_diebstahl * 0.00)                  AS inv_diebstahl_ohne_inv -- dummy_2
   , inv_diebstahl_GES - inv_diebstahl_bis_inv  AS inv_diebstahl_nach_inv, SUM(inv_bestand_korrektur)                                AS inv_bestand_korrektur_GES, SUM(inv_bestand_korrektur * inv_fg)                       AS inv_bestand_korrektur_bis_inv, SUM(inv_bestand_korrektur * 0.00)                         AS inv_bestand_korrektur_ohne_inv -- dummy_2
   , inv_bestand_korrektur_GES - inv_bestand_korrektur_bis_inv AS inv_bestand_korrektur_nach_inv, SUM(ums_netto * akt_gj_fg)     AS inv_ums_akt_gj -- nur akt GJ
   , SUM(inv_diebstahl * akt_gj_fg) AS inv_diebstahl_akt_gj -- nur akt GJ
   FROM (
   SELECT
   vis.mandant_id, vis.nb_id, vis.wup_id, vis.wg_id, vis.wrg_id, vis.dat, vis.ums_netto                           AS ums_netto, COALESCE(mab.inv_diebstahl, 0)          AS inv_diebstahl, COALESCE(mab.inv_bestand_korrektur, 0 ) AS inv_bestand_korrektur, COALESCE(dat_plan_zaehlung, CURRENT_DATE - 1) AS dat_inv, COALESCE(hfm.inventur_fg, 0)          AS inv_fg, CASE WHEN akt_gj = 0 THEN 1 ELSE 0 END::BYTEINT AS akt_gj_fg
   FROM (
   SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wg_id, vis0.wrg_id, vis0.dat, vis0.ums_netto, zeit.akt_gj
   FROM dbp_msi_v_view.v_vis_tag_umsatz_wg_2 vis0
   JOIN dbp_view.v_tag_2 zeit_2
   ON zeit.dat = vis0.dat AND zeit.akt_gj BETWEEN -1 AND 0 AND zeit.akt_tag < 1
   UNION ALL
   SELECT vis0.mandant_id, vis0.nb_id, vis0.wup_id, vis0.wg_id, vis0.wrg_id, (vis0.dat - 364), vis0.ums_netto_wvj, zeit.akt_gj
   FROM dbp_msi_v_view.v_vis_tag_umsatz_wg_2 vis0
   JOIN dbp_view.v_tag_2 zeit_2
   ON zeit.dat = vis0.dat AND zeit.akt_gj = -1
   ) vis
   LEFT JOIN (
   SELECT  -- Marktabschriften_2 -- 1. Landeswaehrung
   mab0.mandant_id, mab0.nb_id, mab0.wup_id, mab0.wrg_id, awg0.wg_id, mab0.dat, SUM((CASE WHEN aba0.abschriftart_int_id IN (190) THEN -1 * mab0.abschriftbetrag_netto ELSE 0 END))::DECIMAL(18,2) AS inv_diebstahl, SUM((CASE WHEN aba0.abschriftart_int_id IN (343, 344) AND mab0.positionsnummer_id <> 1 THEN -1 * mab0.abschriftbetrag_netto ELSE 0 END))::DECIMAL(18,2) AS inv_bestand_korrektur
   FROM dbp_view.v_marktabschriften_2 mab0

   JOIN dbp_view.v_abschriftart_int_zu_2 aba0
   ON aba0.abschriftart_id = mab0.abschriftart_id AND aba0.mandant_id = mab0.mandant_id
   AND aba0.abschriftart_int_id IN (190, 343, 344)

   JOIN dbp_view.v_art_wg_zu_per_2 awg0
   ON awg0.art_id =  mab0.art_id AND awg0.mandant_id = mab0.mandant_id
   AND awg0.arthiertyp_id = 2 AND awg0.dat_bis = '9999-12-31'

   GROUP BY 1,2,3,4,5,6

   UNION ALL
   SELECT -- Marktabschriften_2 -- 2. Umrechnung in EUR
   mab0.mandant_id, mab0.nb_id, mab0.wup_id, kurs0.nach_wrg_id -- EUR!
   , awg0.wg_id, mab0.dat, SUM((CASE WHEN aba0.abschriftart_int_id IN (190) THEN -1 * mab0.abschriftbetrag_netto * kurs0.umrechnungskurs ELSE 0 END))::DECIMAL(18,2) AS inv_diebstahl, SUM((CASE WHEN aba0.abschriftart_int_id IN (343, 344) AND mab0.positionsnummer_id <> 1 THEN -1 * mab0.abschriftbetrag_netto * kurs0.umrechnungskurs ELSE 0 END))::DECIMAL(18,2) AS inv_bestand_korrektur
   FROM dbp_view.v_marktabschriften_2 mab0

   JOIN dbp_view.v_abschriftart_int_zu_2 aba0
   ON aba0.abschriftart_id = mab0.abschriftart_id AND aba0.mandant_id = mab0.mandant_id
   AND aba0.abschriftart_int_id IN (190, 343, 344)

   JOIN dbp_view.v_art_wg_zu_per_2 awg0
   ON awg0.art_id =  mab0.art_id AND awg0.mandant_id = mab0.mandant_id
   AND awg0.arthiertyp_id = 2 AND awg0.dat_bis = '9999-12-31'

   JOIN dbp_view.v_mandant_2 man0
   ON man0.mandant_id = mab0.mandant_id AND man0.default_wrg <> 'EUR'

   JOIN dbp_view.v_kurs_2 kurs0
   ON kurs0.von_wrg_id = mab0.wrg_id AND kurs0.kurstyp_id = 3 AND kurs0.dat_bis = '9999-12-31'

   GROUP BY 1,2,3,4,5,6
   ) mab
   ON vis.mandant_id = mab.mandant_id AND vis.wup_id = mab.wup_id
   AND vis.wg_id = mab.wg_id AND vis.wrg_id = mab.wrg_id
   AND vis.dat = mab.dat
   LEFT JOIN ( -- HFM Inventur_2 Zeitraeume
   SELECT
   inv0.mandant_id, inv0.nb_id, inv0.wup_id, inv0.wg_id, inv0.dat_plan_zaehlung, inv0.dat_vorletzte_zaehlung, 1::BYTEINT AS inventur_fg
   FROM dbp_view.v_hfm_inventur_termin_wg_wup_zu_per_2 inv0
   WHERE inventurart_int_id <> 8 -- ohne Jahresinventur
   ) hfm
   ON vis.mandant_id = hfm.mandant_id AND vis.wup_id = hfm.wup_id
   AND vis.wg_id = hfm.wg_id
   AND vis.dat BETWEEN hfm.dat_vorletzte_zaehlung AND hfm.dat_plan_zaehlung

   ) sub01

   JOIN dbp_view.v_tag_2 zeit_2
   ON zeit.dat = sub01.dat_inv -- GJ aus Inventur_2

   GROUP BY 1,2,3,4,5,6,7,8
   ;