CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ods_bon_kopf_1 (bon_id, bon_dat, wup_id, nb_id, mandant_id,
bon_nr, kasse_nr, kassierer_nr, kunde_fg, bon_beginn, bon_ende, umsatz_mwst, umsatz_brutto, bon_booking, dat_booking,
turnover_fg, wrg_id, kasse_typ_id, zeitstempel_druck) AS SELECT K.bon_id,
 K.bon_dat,
 V05.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 K.mandant_id,
 K.bon_nr,
 K.kasse_nr,
 K.kassierer_nr,
 K.kunde_fg,
 K.bon_beginn,
 K.bon_ende,
 K.umsatz_mwst,
 K.umsatz_brutto,
 K.bon_booking,
 K.dat_booking,
 K.turnover_fg,
 K.wrg_id,
 K.kasse_typ_id,
 COALESCE(A.zeitstempel_druck, CAST('9999-12-31 23:59:59' AS DATETIME)) AS zeitstempel_druck
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS K
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON K.mandant_id = V05.mandant_id AND K.wup_id = V05.wup_id AND (V05.nb_id
       IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ods_bon_abhol_liste_1 AS A ON K.bon_id = A.bon_id AND K.mandant_id = A.mandant_id
     AND K.wup_id = A.wup_id;