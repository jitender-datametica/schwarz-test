CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ods_bon_f_financial (bon_id, bon_dat, bon_booking
, dat_booking, wup_id, nb_id, mandant_id, kasse_nr, kunde_fg, bon_beginn, bon_ende, turnover_fg, wrg_id, kasse_typ_id,
bon_zeile, kl_art_id, ean_kasse, menge, einh_id, umsatz_brutto, reklamationsgrund_id, reklamationstyp_id, auszahlung_fg
) AS SELECT K.bon_id,
 K.bon_dat,
 K.bon_booking,
 K.dat_booking,
 V05.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 K.mandant_id,
 K.kasse_nr,
 K.kunde_fg,
 K.bon_beginn,
 K.bon_ende,
 K.turnover_fg,
 K.wrg_id,
 K.kasse_typ_id,
 F.bon_zeile,
 -1 AS kl_art_id,
 -1 AS ean_kasse,
 CAST(CASE
   WHEN F.umsatz_brutto < 0.0
   THEN -1.000
   ELSE 1.000
   END AS NUMERIC) AS menge,
 'ST' AS einh_id,
 F.umsatz_brutto,
 F.financial_grund_id AS reklamationsgrund_id,
 '-1' AS reklamationstyp_id,
 F.auszahlung_fg
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS K
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON K.mandant_id = V05.mandant_id AND K.wup_id = V05.wup_id AND (V05.nb_id
       IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_financial AS F ON K.bon_id = F.bon_id AND K.wup_id = F.wup_id AND K.mandant_id
    = F.mandant_id
WHERE (K.bon_id, K.wup_id, K.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno);