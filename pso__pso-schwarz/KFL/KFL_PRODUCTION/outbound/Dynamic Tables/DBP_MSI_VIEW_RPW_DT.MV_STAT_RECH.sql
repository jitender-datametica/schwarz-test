CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_stat_rech
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT BR.wup_id,
 BR.nb_id,
 BR.dat_buch,
 BR.dat_beleg,
 DATE(BR.dat_erfasst) AS dat_erfasst,
 BR.belegart_id,
 SM.mandant_id,
 SM.statusmeldung_id,
 SM.beleg_id_orig AS rpw_beleg_zu_id,
 SM.ecm_vorgang,
 SM.zeitstempel,
 DATE(SM.zeitstempel) AS dat,
 SM.statuscode_id,
 SM.ursprung_beleg_id,
 SM.ursprung_beleg_gj,
 SM.ersteller_id,
 SM.gp_id,
 SM.einkaufsorganisation_id,
 SM.auto_fg,
  CASE
  WHEN SM.betrag_brutto >= BR.betrag_brutto
  THEN CASE
   WHEN BR.belegart_id IN ('HS', 'HK') AND (COALESCE(ROUND(SAFE_CAST(BR.buch_grund_ext_id AS BIGNUMERIC), 0), 0) < 200
        OR COALESCE(ROUND(SAFE_CAST(BR.buch_grund_ext_id AS BIGNUMERIC), 0), 0) > 299) OR BR.belegart_id IN ('32', 'HB'
       ) OR BR.belegart_id = '31' AND COALESCE(ROUND(SAFE_CAST(BR.buch_grund_ext_id AS BIGNUMERIC), 0), 0) BETWEEN 200
      AND 299
   THEN ABS(BR.betrag_brutto)
   ELSE ABS(BR.betrag_brutto) * -1
   END
  ELSE SM.betrag_brutto
  END AS betrag_brutto,
 SM.betrag_mwst,
 SM.wrg_id,
 SM.quellsystem_id,
 SM.belegklasse_id,
 7 AS system_id,
 SM.fi_beleg_id,
 SM.imprint_nr,
 SM.edi_nr,
 SM.beleg_id,
 SM.beleg_gj
FROM kfl_production_dbp_view.v_statusmeldung AS SM
 INNER JOIN kfl_production_dbp_view.v_besch_rech AS BR ON SM.beleg_id = BR.rech_beleg_id AND SM.beleg_gj = BR.gj AND SM
   .mandant_id = BR.mandant_id
WHERE SM.mandant_id = 1;