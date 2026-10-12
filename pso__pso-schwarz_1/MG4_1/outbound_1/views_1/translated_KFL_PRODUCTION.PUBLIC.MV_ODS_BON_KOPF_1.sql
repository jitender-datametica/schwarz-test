CREATE OR REPLACE VIEW kfl_production_public.mv_ods_bon_kopf_1 (bon_id, bon_dat, wup_id, nb_id, mandant_id, bon_nr,
kasse_nr, kassierer_nr, kunde_fg, bon_beginn, bon_ende, umsatz_mwst, umsatz_brutto, bon_booking, dat_booking,
turnover_fg, wrg_id, kasse_typ_id, zeitstempel_druck) AS SELECT k.bon_id,
 k.bon_dat,
 k.wup_id,
 0 AS nb_id,
 k.mandant_id,
 k.bon_nr,
 k.kasse_nr,
 k.kassierer_nr,
 k.kunde_fg,
 k.bon_beginn,
 k.bon_ende,
 k.umsatz_mwst,
 k.umsatz_brutto,
 k.bon_booking,
 k.dat_booking,
 k.turnover_fg,
 k.wrg_id,
 k.kasse_typ_id,
 COALESCE(a.zeitstempel_druck, CAST('9999-12-31 23:59:59' AS DATETIME)) AS zeitstempel_druck
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS k
 LEFT JOIN kfl_production_dbp_msi_v_view.v_ods_bon_abhol_liste_1 AS a ON k.bon_id = a.bon_id AND k.mandant_id = a.mandant_id
     AND k.wup_id = a.wup_id;