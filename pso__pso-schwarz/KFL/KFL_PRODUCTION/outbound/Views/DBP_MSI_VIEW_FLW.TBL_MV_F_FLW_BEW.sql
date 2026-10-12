CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_bew (mandant_id, best_beleg_id, best_beleg_pos_id,
lagerbew_beleg_id, bde_vorgang_id, werk_id, charge_id, lagerort_id, dat_erfasst, min_dat_erfasst, zeit_erfasst,
zeit_erfasst_ts, min_zeit_erfasst, beleg_gruppe_id, dat_haltbarkeit, betrag_bew, auftrag_id, kj, loesch_fg, in_art_id,
dme_einh_id, nettogew, menge_bme, menge_dme, menge_rework, flw_beleg_typ_id, menge_einh_id, storno_fg, status_mb,
retourenpos_fg, datzeit_erstellung, bestandsart, terminal_id, dat_herstellung, ext_tiernummer, menge_erfasst,
erfmenge_einh_id, bruttogew, taragew, schnitt_id, um_lagerort_id, um_in_art_id, um_charge_id, prueflos_id, in_lief_id,
verwendung_ziel_id, bde_vorgang_id_nachf, bde_vorgang_id_vorg, behaelter_id, erzeuger_1_id, erzeuger_2_id, wechsel_id,
schlachtbetrieb_id, transport_einheit_id, dat_schlachtung, dat_zerlegung, prueflos_id_2, tier_kategorie_id,
tier_gattung_id, vpap_id, flw_arbeitsplatz_id, pdao_job_id, lager_beleg_id, lager_beleg_pos_id, lagernummer_id,
transport_beleg_id, transport_beleg_pos_id, mfr_transport_einheit_id, pdao_bediener_id, anz_rauchstoecke, anz_rohre,
flw_arbeitsplatz_mischer_id, flw_arbeitsplatz1_id, flw_bew_grund_id, flw_ziel_id, herkunft_id, komm_auftrag_pos_id,
land_geboren_id, land_gemaestet_id, land_geschlachtet_id, land_zerlegt_id, lief_charge_id, menge_diff_rauchkammer,
menge_rauchstoecke, menge_rauchwagen, nve_id, rauchstock, rauchstoeckemenge_einh_id, rauchwagen_id,
rauchwagenmenge_einh_id, rauchwagen_gewicht, rauchstoecke_gewicht, basismenge_einh_id, wrg_id, default_wrg, wrg_id_org,
menge_basis, komponentenmenge) AS SELECT V01.mandant_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.lagerbew_beleg_id,
 V01.bde_vorgang_id,
 V01.werk_id,
 V01.charge_id,
 V01.lagerort_id,
 V01.dat_erfasst,
 V01.min_dat_erfasst,
 V01.zeit_erfasst,
 DATETIME(V01.dat_erfasst, V01.zeit_erfasst) AS zeit_erfasst_ts,
 V01.min_zeit_erfasst,
 V01.beleg_gruppe_id,
 V01.dat_haltbarkeit,
 V01.betrag_bew,
  CASE
  WHEN V01.auftrag_id <> ''
  THEN V01.auftrag_id
  ELSE '-1'
  END AS auftrag_id,
 V01.kj,
 V01.loesch_fg,
  CASE
  WHEN V01.werk_id = 5 AND V01.mandant_id = 1 AND V01.flw_beleg_typ_id = 'WA' AND v02.transport_einheit_id IS NOT NULL
  THEN V01.um_flw_art_id
  ELSE V01.flw_art_id
  END AS in_art_id,
 V01.dme_einh_id,
  V01.nettogew * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS nettogew,
  V01.menge_bme * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS menge_bme,
  V01.menge_dme * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS menge_dme,
  CASE
  WHEN V01.flw_beleg_typ_id = 'WA' OR V01.flw_beleg_typ_id = 'V1'
  THEN V01.menge_bme * CASE
     WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
     THEN - 1
     ELSE 1
     END * - 1
  ELSE V01.menge_bme * CASE
    WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
    THEN - 1
    ELSE 1
    END
  END AS menge_rework,
 V01.flw_beleg_typ_id,
 V01.altnv_menge_einh_id AS menge_einh_id,
 V01.storno_fg,
 V01.status_mb,
 V01.retourenpos_fg,
 V01.datzeit_erstellung,
 V01.bestandsart,
 V01.terminal_id,
 V01.dat_herstellung,
 V01.ext_tiernummer,
  V01.menge_erfasst * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS menge_erfasst,
 V01.erfmenge_einh_id,
  V01.bruttogew * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS bruttogew,
  V01.taragew * CASE
   WHEN V01.storno_fg = 1 OR V01.retourenpos_fg = 1
   THEN - 1
   ELSE 1
   END AS taragew,
 V01.schnitt_id,
 V01.um_lagerort_id,
 V01.um_flw_art_id AS um_in_art_id,
 V01.um_charge_id,
 V01.prueflos_id,
 V01.flw_lief_id AS in_lief_id,
 V01.verwendung_ziel_id,
 V01.bde_vorgang_id_nachf,
 V01.bde_vorgang_id_vorg,
 V01.behaelter_id,
 V01.erzeuger_1_id,
 V01.erzeuger_2_id,
 V01.wechsel_id,
 V01.schlachtbetrieb_id,
 V01.transport_einheit_id,
 V01.dat_schlachtung,
 V01.dat_zerlegung,
 V01.prueflos_id_2,
 V01.tier_kategorie_id,
 V01.tier_gattung_id,
 V01.vpap_id,
 V01.flw_arbeitsplatz_id,
 V01.pdao_job_id,
 V01.lager_beleg_id,
 V01.lager_beleg_pos_id,
 V01.lagernummer_id,
 V01.transport_beleg_id,
 V01.transport_beleg_pos_id,
 V01.mfr_transport_einheit_id,
 V01.pdao_bediener_id,
 V01.anz_rauchstoecke,
 V01.anz_rohre,
 V01.flw_arbeitsplatz_mischer_id,
 V01.flw_arbeitsplatz1_id,
 V01.flw_bew_grund_id,
 V01.flw_ziel_id,
 V01.herkunft_id,
 V01.komm_auftrag_pos_id,
 V01.land_geboren_id,
 V01.land_gemaestet_id,
 V01.land_geschlachtet_id,
 V01.land_zerlegt_id,
 V01.lief_charge_id,
 V01.menge_diff_rauchkammer,
 V01.menge_rauchstoecke,
 V01.menge_rauchwagen,
 V01.nve_id,
 V01.rauchstock,
 V01.rauchstoeckemenge_einh_id,
 V01.rauchwagen_id,
 V01.rauchwagenmenge_einh_id,
   CAST(V01.menge_rauchwagen AS STRING) || '  ' || V01.rauchwagenmenge_einh_id AS rauchwagen_gewicht,
   CAST(V01.menge_rauchstoecke AS STRING) || '  ' || V01.rauchstoeckemenge_einh_id AS rauchstoecke_gewicht,
 V01.basismenge_einh_id,
 V01.wrg_id,
 V100.default_wrg,
 V01.wrg_id AS wrg_id_org,
 v04.menge_basis,
 v04.komponentenmenge
FROM kfl_production_dbp_view.v_flw_bew AS V01
 LEFT JOIN (SELECT transport_einheit_id
  FROM kfl_production_dbp_view.v_flw_rauchverlust
  GROUP BY transport_einheit_id) AS v02 ON V01.transport_einheit_id = v02.transport_einheit_id
 LEFT JOIN kfl_production_dbp_view.v_flw_auftrag_pps AS V03 ON V01.auftrag_id = V03.auftrag_id AND V01.mandant_id = V03
   .mandant_id
 LEFT JOIN (SELECT V010.mandant_id,
   V010.werk_id,
   V010.flw_art_id AS flw_art_id_out,
   V02.flw_art_id AS flw_art_id_in,
   SUM(V010.menge_basis) AS menge_basis,
   SUM(V02.komponentenmenge) AS komponentenmenge
  FROM kfl_production_dbp_view.v_flw_stueckliste AS V010
   INNER JOIN kfl_production_dbp_view.v_flw_stueckliste_det AS V02 ON V010.mandant_id = V02.mandant_id AND V010.stueckliste_id
       = V02.stueckliste_id AND V010.stueckliste_typ_id = V02.stueckliste_typ_id
  WHERE V02.stueckliste_typ_id <> 'X'
   AND V02.komponentenmenge <> 0.001
  GROUP BY V010.mandant_id,
   V010.werk_id,
   flw_art_id_out,
   flw_art_id_in) AS v04 ON V01.mandant_id = v04.mandant_id AND V01.werk_id = v04.werk_id AND V01.flw_art_id = v04.flw_art_id_in
     AND V03.flw_art_id = v04.flw_art_id_out
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON V01.mandant_id = V100.mandant_id;