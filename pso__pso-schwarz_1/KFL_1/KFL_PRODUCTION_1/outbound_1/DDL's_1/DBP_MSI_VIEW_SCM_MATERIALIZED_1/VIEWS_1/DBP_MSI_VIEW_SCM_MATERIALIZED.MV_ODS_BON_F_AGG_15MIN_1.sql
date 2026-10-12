CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_ods_bon_f_agg_15min_1 (dat, zeit_stunde, zeit_15min
, wup_id, nb_id, mandant_id, kasse_nr, kasse_typ_id, umsatz_brutto, umsatz_netto, anz_artikel, anz_kunden, kassierzeit,
registrierzeit, zahlzeit) AS SELECT V01.dat,
 V01.zeit_stunde,
 V01.zeit_15min,
 V05.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 V01.mandant_id,
 V01.kasse_nr,
 COALESCE(KTP.kasse_typ_id, V01.kasse_typ_id) AS kasse_typ_id,
 V01.umsatz_brutto,
 V01.umsatz_netto,
 V01.anz_artikel,
 V01.anz_kunden,
 V01.kassierzeit,
 V01.registrierzeit,
 V01.zahlzeit
FROM kfl_production_dbp_v_ods.v_ods_bon_agg_15min_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_kasse_typ_per_1 AS KTP ON V01.mandant_id = KTP.mandant_id AND V01.wup_id = KTP.wup_id
      AND V01.kasse_nr = KTP.kasse_nr AND V01.dat BETWEEN KTP.dat_von AND KTP.dat_bis;