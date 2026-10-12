CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_pmr_angebot_art_wup_zu (dat_beladung, mandant_id
, offer_id, angebot_id, art_id, nb_id, wup_id, nb_id_vz, wup_id_vz, verkaufsorganisation_id, dat_von, dat_bis,
preis_aktion, preis_normal, preis_nachlass_perc, bestand_bme, mindestmenge_bme, maximalmenge_bme, nis_fg, aktion_id,
aktion_id_pmr, masterbonus_fg, gondelkopf_fg, topartikel_fg, pmr_werbethema_id, pmr_werbethema_beschreibung,
bonuskauf_anreiztyp, bonuskauf_geschaeftsvorfall_id, bonuskauf_konditionsart_id, bonuskauf_limit, bonuskauf_fg,
bonuskauf_bedingung_id, bonuskauf_dimension_id, bonuskauf_produktgruppenname, bonuskauf_bonusmenge, bonuskauf_kaufmenge
, bonuskauf_mindestbetrag, bonuskauf_rabatttype_id, bonuskauf_produktvariante_id, bonuskauf_rabatt_perc,
bonuskauf_rabatt_zuordnung_id, bonuskauf_promotionstyp, multi_offer_id_fg, mandant_id_vz, kjwo, kjwo_ww,
ausliefergruppe_id, werbeaenderung_artikelneuanlage_fg, werbeaenderung_artikelentfernung_fg, preis_niedrigster,
preis_niedrigster_diff_perc, opv_prospekt_fg, opv_markt_fg, stimmung_fg, preishammer_fg, ek_art_id_ref) AS SELECT V01.dat_beladung
 ,
 V01.mandant_id,
 V01.offer_id,
 V02.angebot_id,
 V01.art_id,
 V01.nb_id,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id_vz,
 V01.wup_id_vz,
 V02.verkaufsorganisation_id,
 V02.dat_von,
 V02.dat_bis,
 V01.preis_aktion,
 V01.preis_normal,
 V01.preis_nachlass_perc,
 V02.bestand_bme,
 V02.mindestmenge_bme,
 V02.maximalmenge_bme,
 V02.nis_fg,
 V01.aktion_id,
 V02.aktion_id AS aktion_id_pmr,
 V02.masterbonus_fg,
 V02.gondelkopf_fg,
 V02.topartikel_fg,
 V02.pmr_werbethema_id,
 V02.pmr_werbethema_beschreibung,
 V02.bonuskauf_anreiztyp,
 V02.bonuskauf_geschaeftsvorfall_id,
 V02.bonuskauf_konditionsart_id,
 V02.bonuskauf_limit,
 V02.bonuskauf_fg,
 V02.bonuskauf_bedingung_id,
 V02.bonuskauf_dimension_id,
 V02.bonuskauf_produktgruppenname,
 V02.bonuskauf_bonusmenge,
 V02.bonuskauf_kaufmenge,
 V02.bonuskauf_mindestbetrag,
 V02.bonuskauf_rabatttype_id,
 V02.bonuskauf_produktvariante_id,
 V02.bonuskauf_rabatt_perc,
 V02.bonuskauf_rabatt_zuordnung_id,
 V02.bonuskauf_promotionstyp,
 V01.multi_offer_id_fg,
  CASE
  WHEN V01.wup_id_vz = 6140
  THEN 4
  ELSE V01.mandant_id_vz
  END AS mandant_id_vz,
 V01.kjwo,
 V09.kjwo_ww,
 COALESCE(V01.ausliefergruppe_id, ' ') AS ausliefergruppe_id,
 V01.werbeaenderung_artikelneuanlage_fg,
 V01.werbeaenderung_artikelentfernung_fg,
 V02.preis_niedrigster,
 V02.preis_niedrigster_diff_perc,
 V02.opv_prospekt_fg,
 V02.opv_markt_fg,
 V02.stimmung_fg,
 V02.preishammer_fg,
 V02.ek_art_id_ref
FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl AS V09 ON V01.mandant_id = V09.mandant_id AND V01.dat_ab = V09.dat
 INNER JOIN kfl_production_dbp_view.v_pmr_angebot_art_wup_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id =
       V02.art_id AND V01.wup_id = V02.wup_id AND V01.nb_id = V02.nb_id AND V01.dat_ab = V02.dat_von AND V01.dat_bis =
   V02.dat_bis
WHERE V01.dat_beladung >= DATE_SUB(CURRENT_DATE, INTERVAL 140 DAY);