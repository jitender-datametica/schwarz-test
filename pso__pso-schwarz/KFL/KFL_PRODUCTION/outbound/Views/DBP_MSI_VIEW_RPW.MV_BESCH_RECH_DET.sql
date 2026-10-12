CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_rech_det (system_id, mandant_id, rech_beleg_id,
rech_beleg_pos_id, gj, best_beleg_id, best_beleg_pos_id, wbnk_fg, konditionsart_id, ean_id, gp_art_id, edi_pos_nr,
betrag_mwst, wg_id, gp_id, einkaufsorganisation_id, wup_id, nb_id, art_id, menge_rech, best_menge_einh_id,
best_preis_menge, best_preis_menge_einh_id, buch_grund_int_id, buch_grund_ext_id, arthiertyp_id, lagerbew_beleg_id,
lagerbew_beleg_pos_id, kj, mengenabw_rpw_fg, preisabw_rpw_fg, menge_rechsteller, rechsteller_menge_einh_id,
betrag_kondition, kondition_einh_id, kondition_menge_einh_id, kondition_preis_einh_id, preis_vk_brutto, betrag_vk_brutto
, betrag_beleg, soll_haben_kz, vk_wrg_id, pos_manuell_erstellt_fg, dat_rpw, dat_buch, dat_beleg, dat_erfasst,
dat_rech_eingang, sap_mwst_id, betrag_korrektur_netto, mwst) AS SELECT 7 AS system_id,
 A.mandant_id,
 A.rech_beleg_id,
 A.rech_beleg_pos_id,
 A.gj,
 A.best_beleg_id,
 A.best_beleg_pos_id,
 A.wbnk_fg,
 COALESCE(A.konditionsart_id, '0') AS konditionsart_id,
 COALESCE(A.ean_id, 0) AS ean_id,
 A.gp_art_id,
 A.edi_pos_nr,
 A.betrag_mwst,
 C.wg_id,
 B.gp_id,
 A.einkaufsorganisation_id,
 B.wup_id,
 B.nb_id,
 A.art_id,
 CAST(A.menge_rech / ROUND(U.umrech_faktor, 21) AS NUMERIC) AS menge_rech,
 A.best_menge_einh_id,
 A.best_preis_menge,
 A.best_preis_menge_einh_id,
 COALESCE(A.buch_grund_int_id, '0') AS buch_grund_int_id,
 COALESCE(A.buch_grund_ext_id, '0') AS buch_grund_ext_id,
 A.arthiertyp_id,
 A.lagerbew_beleg_id,
 A.lagerbew_beleg_pos_id,
 A.kj,
 A.mengenabw_rpw_fg,
 A.preisabw_rpw_fg,
 A.menge_rechsteller,
 A.rechsteller_menge_einh_id,
 A.betrag_kondition,
 A.kondition_einh_id,
 A.kondition_menge_einh_id,
 A.kondition_preis_einh_id,
 A.preis_vk_brutto,
 A.betrag_vk_brutto,
 A.betrag_beleg,
 A.soll_haben_kz,
 A.vk_wrg_id,
 A.pos_manuell_erstellt_fg,
  CASE
  WHEN B.rech_beleg_status_id = '5'
  THEN CAST(B.dat_erfasst AS STRING)
  ELSE NULL
  END AS dat_rpw_,
 B.dat_buch,
 B.dat_beleg,
 B.dat_vorerfasst AS dat_erfasst,
 B.dat_rech_eingang,
 A.sap_mwst_id,
 A.betrag_korrektur_netto,
 A.mwst
FROM kfl_production_dbp_view.v_besch_rech_det AS A
 INNER JOIN kfl_production_dbp_view.v_besch_rech AS B ON A.mandant_id = B.mandant_id AND A.rech_beleg_id = B.rech_beleg_id
     AND A.gj = B.gj
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND CASE
     WHEN B.rech_beleg_status_id = '5'
     THEN DATE(B.dat_erfasst)
     ELSE NULL
     END BETWEEN C.dat_von AND C.dat_bis AND C.arthiertyp_id = 2
 INNER JOIN kfl_production_dbp_view.v_art_umrechnung_faktor_per AS U ON A.art_id = U.art_id AND A.mandant_id = U.mandant_id
      AND A.best_menge_einh_id = U.altnv_menge_einh_id AND CASE
    WHEN B.rech_beleg_status_id = '5'
    THEN DATE(B.dat_erfasst)
    ELSE NULL
    END BETWEEN U.dat_von AND U.dat_bis
WHERE A.mandant_id = 1;