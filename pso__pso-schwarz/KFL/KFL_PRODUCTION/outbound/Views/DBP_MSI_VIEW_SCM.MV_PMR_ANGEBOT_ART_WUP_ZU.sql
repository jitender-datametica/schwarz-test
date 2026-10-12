CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_pmr_angebot_art_wup_zu (dat_beladung, mandant_id, offer_id,
angebot_id, art_id, nb_id, wup_id, nb_id_vz, wup_id_vz, verkaufsorganisation_id, dat_von, dat_bis, preis_aktion,
preis_normal, preis_nachlass_perc, bestand_bme, mindestmenge_bme, maximalmenge_bme, nis_fg, aktion_id, aktion_id_pmr,
masterbonus_fg, gondelkopf_fg, topartikel_fg, pmr_werbethema_id, pmr_werbethema_beschreibung, bonuskauf_anreiztyp,
bonuskauf_geschaeftsvorfall_id, bonuskauf_konditionsart_id, bonuskauf_limit, bonuskauf_fg, bonuskauf_bedingung_id,
bonuskauf_dimension_id, bonuskauf_produktgruppenname, bonuskauf_bonusmenge, bonuskauf_kaufmenge, bonuskauf_mindestbetrag
, bonuskauf_rabatttype_id, bonuskauf_produktvariante_id, bonuskauf_rabatt_perc, bonuskauf_rabatt_zuordnung_id,
bonuskauf_promotionstyp, multi_offer_id_fg, mandant_id_vz, kjwo, kjwo_ww, ausliefergruppe_id,
werbeaenderung_artikelneuanlage_fg, werbeaenderung_artikelentfernung_fg, preis_niedrigster, preis_niedrigster_diff_perc
, opv_prospekt_fg, opv_markt_fg, stimmung_fg, preishammer_fg, ek_art_id_ref, top5_fg) AS SELECT DISTINCT V01.dat_beladung
 ,
 V01.mandant_id,
 V01.offer_id,
 ROUND(SAFE_CAST(V02.angebot_nr AS BIGNUMERIC), 0) AS angebot_id,
 V01.art_id,
 V01.nb_id,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id_vz,
 V01.wup_id_vz,
 V02.verkaufsorganisation_id,
 A.dat_angebot_gueltig_von AS dat_von,
 A.dat_angebot_gueltig_bis AS dat_bis,
 V01.preis_aktion,
 V01.preis_normal,
 V01.preis_nachlass_perc,
 aa.bestand_bme,
 aa.mindestmenge_bme,
 aa.maximalmenge_bme,
 V02.art_nis_fg AS nis_fg,
 V01.aktion_id,
 A.aktion_id AS aktion_id_pmr,
 aa.masterbonus_fg,
 aa.gondelkopf_fg,
 aa.topartikel_fg,
 W.werbethema_id AS pmr_werbethema_id,
 W.werbethema_bez,
 A.aktion_typ_id AS bonuskauf_anreiztyp,
 A.geschaeftsvorfall_id AS bonuskauf_geschaeftsvorfall_id,
 A.konditionsart_id AS bonuskauf_konditionsart_id,
 A.anz_angebot_limit AS bonuskauf_limit,
 A.bonuskauf_fg,
 0 AS bonuskauf_bedingung_id,
 0 AS bonuskauf_dimension_id,
 V02.art_werbe_prod_gruppe_name AS bonuskauf_produktgruppenname,
 V02.anz_bonuskauf_gratis AS bonuskauf_bonusmenge,
 V02.anz_bonuskauf_kauf AS bonuskauf_kaufmenge,
 V02.menge_bonuskauf_min AS bonuskauf_mindestbetrag,
 V02.rabatt_typ_id AS bonuskauf_rabatttype_id,
 0 AS bonuskauf_produktvariante_id,
 V02.proz_bonuskauf_rabatt AS bonuskauf_rabatt_perc,
 0 AS bonuskauf_rabatt_zuordnung_id,
 A.angebot_typ_cd AS bonuskauf_promotionstyp,
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
 0 AS preis_niedrigster,
 0 AS preis_niedrigster_diff_perc,
 V02.opv_prospekt_fg,
 V02.opv_markt_fg,
 aa.stimmung_fg,
 aa.preishammer_fg,
 aa.ek_art_id_ref,
  CASE
  WHEN D01.dat_beladung IS NOT NULL
  THEN 1
  ELSE 0
  END AS top5_fg
FROM kfl_production_dbp_view.v_wbs_werbeaenderungen AS V01
 LEFT JOIN kfl_production_dbp_msi_view_scm.mv_wbs_top5_dat_beladung AS D01 ON V01.dat_beladung = D01.dat_beladung
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 LEFT JOIN kfl_production_dbp_view.v_werbewoche_kl AS V09 ON V01.mandant_id = V09.mandant_id AND V01.dat_ab = V09.dat
 INNER JOIN kfl_production_dbp_view.v_angebot_art_wup_zu AS V02 ON V01.offer_id = ROUND(SAFE_CAST(V02.angebot_nr AS
       BIGNUMERIC), 0) AND V01.art_id = V02.art_id AND V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_angebot AS A ON V02.angebot_nr = A.angebot_nr AND V02.mandant_id = A.mandant_id
    AND A.angebot_geloescht_fg = 0 AND V01.dat_ab = A.dat_angebot_gueltig_von AND V01.dat_bis = A.dat_angebot_gueltig_bis
   
 LEFT JOIN kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu AS W ON A.angebot_nr = W.angebot_nr AND A.mandant_id
     = W.mandant_id AND (W.werbemittelkanal_bez <> 'keine Information verfügbar' OR W.werbethema_bez <> '' OR W.werbeflaechenabschnitt_name
      <> '')
 LEFT JOIN (SELECT mandant_id,
   angebot_nr,
   MAX(CASE
     WHEN angebot_attribut_id = 44
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS bestand_bme,
   MAX(CASE
     WHEN angebot_attribut_id = 42
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS mindestmenge_bme,
   MAX(CASE
     WHEN angebot_attribut_id = 43
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS maximalmenge_bme,
   MAX(CASE
     WHEN angebot_attribut_id = 41
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS masterbonus_fg,
   MAX(CASE
     WHEN angebot_attribut_id = 49
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS gondelkopf_fg,
   MAX(CASE
     WHEN angebot_attribut_id = 47
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS stimmung_fg,
   MAX(CASE
     WHEN angebot_attribut_id = 48
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS preishammer_fg,
   MAX(CASE
     WHEN angebot_attribut_id = 53
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS ek_art_id_ref,
   MAX(CASE
     WHEN angebot_attribut_id = 46
     THEN ROUND(SAFE_CAST(angebot_attribut_txt AS BIGNUMERIC), 0)
     ELSE NULL
     END) AS topartikel_fg
  FROM kfl_production_dbp_data.angebot_attribut_zu
  WHERE angebot_attribut_id BETWEEN 40 AND 53
  GROUP BY mandant_id,
   angebot_nr) AS aa ON A.angebot_nr = aa.angebot_nr AND A.mandant_id = aa.mandant_id
WHERE V01.dat_beladung >= DATE_SUB(CURRENT_DATE, INTERVAL 140 DAY);