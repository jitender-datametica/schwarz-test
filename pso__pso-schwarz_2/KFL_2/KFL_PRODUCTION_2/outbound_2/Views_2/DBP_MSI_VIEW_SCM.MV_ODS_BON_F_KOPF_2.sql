CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ods_bon_f_kopf_2 (bon_id, bon_dat, wup_id, nb_id, mandant_id,
bon_nr, kasse_nr, kassierer_nr, kunde_fg, bon_beginn, bon_ende, umsatz_mwst, umsatz_brutto, bon_booking, dat_booking,
turnover_fg, wrg_id, kasse_typ_id) AS SELECT V01.bon_id,
 V01.bon_dat,
 V05.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 V01.mandant_id,
 V01.bon_nr,
 V01.kasse_nr,
 V01.kassierer_nr,
 V01.kunde_fg,
 V01.bon_beginn,
 V01.bon_ende,
 V01.umsatz_mwst,
 V01.umsatz_brutto,
 V01.bon_booking,
 V01.dat_booking,
 V01.turnover_fg,
 V01.wrg_id,
 V01.kasse_typ_id
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
WHERE (V01.bon_id, cast(V01.wup_id as bignumeric), Cast(V01.mandant_id as bignumeric)) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_2);
