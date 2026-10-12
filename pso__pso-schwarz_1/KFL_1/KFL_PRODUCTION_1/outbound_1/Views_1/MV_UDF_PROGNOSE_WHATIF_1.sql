CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_udf_prognose_whatif_1 AS WITH TOP_DAT_BERECHNUNG AS (SELECT
  DISTINCT dat_beladung
  FROM kfl_production_dbp_view.v_udf_prognose_whatif_1
  ORDER BY dat_beladung DESC NULLS FIRST
  LIMIT 5) (SELECT V01.mandant_id,
   V01.art_id,
   V01.nb_id,
   V05.aktuell_wup_id AS wup_id,
   V01.angebot_id,
   V01.dat_von,
   V01.dat_bis,
   V01.menge_prognose_basis,
   V01.menge_prognose_saison,
   V01.menge_prognose_feiertag,
   V01.menge_prognose_preisaenderung,
   V01.menge_prognose_kaufanreize,
   V01.menge_prognose_uplift,
   V01.menge_prognose_werbemittel,
   V01.menge_prognose_praemienkaufanreize,
   V01.menge_prognose_kundenkarte,
   V01.menge_prognose_verfuegbarkeit,
   V01.menge_prognose_faktoren,
   V01.menge_prognose_gesamt,
   V01.dat_erstellung,
    CASE
    WHEN V01.mandant_id IN (4, 7) AND V01.dat_beladung <> CURRENT_DATE
    THEN DATE_ADD(V01.dat_beladung, INTERVAL 1 DAY)
    ELSE V01.dat_beladung
    END AS dat_beladung_,
   V01.dat_prognose_werbung_zuletzt_gesteuert,
   V01.prognose_offer_nullwert_fg,
   V01.prognose_preis_nullwert_fg,
   V01.prognose_preis_faktor_fg,
   V01.prognose_tactic_nullwert_fg,
   V01.menge_prognose_faktor_fg,
   V01.menge_prognose_nullwert_fg,
   V01.quelle_alt_prioren_fg,
   V01.dat_prognose_normal_zuletzt_gesteuert,
   V01.anz_prior_gesamt,
   V01.anz_prior_eigen,
   V01.anz_prior_ref,
   V01.anz_prior_hpr,
   V01.anz_prior_default,
   V02.kjwo
  FROM kfl_production_dbp_view.v_udf_prognose_whatif_1 AS V01
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
        .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS V02 ON V01.dat_von = V02.dat
   INNER JOIN TOP_DAT_BERECHNUNG AS V99 ON CASE
     WHEN V01.mandant_id IN (4, 7) AND V01.dat_beladung <> CURRENT_DATE
     THEN DATE_ADD(V01.dat_beladung, INTERVAL 1 DAY)
     ELSE V01.dat_beladung
     END = V99.dat_beladung);