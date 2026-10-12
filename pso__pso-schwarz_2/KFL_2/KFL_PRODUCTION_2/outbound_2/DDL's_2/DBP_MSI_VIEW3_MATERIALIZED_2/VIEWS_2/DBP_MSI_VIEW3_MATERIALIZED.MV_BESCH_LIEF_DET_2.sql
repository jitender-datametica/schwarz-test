-- 04.12.2018 mkub1811, AP0032032, SPEC0046895, Erweiterung um lief_pal_typ_id

-- 27.11.2019 nwag2310, AP0041558, added KJ in join (LIKP/LIPS)

-- nb_id_kunde existiert nicht in Kopf und muss hier 'erfunden' werden

-- 13.06.2018 srom0404: NSR0211557 umwandeln nicht-numerisch auf numerisch jetzt mit TRYCAST

-- 13.02.2020 nwag2310, AP0041558, bugfix

-- 19.07.2017, AP0013197 SPEC0022485, srom0404, mapping best_beleg_id und vorlage_beleg_id

-- 01.02.2018, AP0013197 SPEC0022485, srom0404, JOIN auf Kopf besch_lief_2 eingeführt.

-- 09.07.2018 srom0404: AP0013197 SPEC0037744, erweiterung um bestellart_id

-- 2023-12-11, dknop, adding lagernummer_id, lief_typ_id,gp_id,  werbeware_id,gp_id,versandstelle_id,vertr_beleg_typ_id,wg_verkett_fg,wg_verkett_lief

-- Erforderlich, da Kunde nicht auf Detail Ebene vorlag. Microstrategy dies aber vom Schema bzgl. Disporhythmus erforderte.

-- 2022-04-25, dknop, AP0128635_SPEC0151986, adding auslieferungsgruppe_id

-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_2 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3_materialized.mv_besch_lief_det_2 (USERID STRING) AS -- dbp_msi.akt_msi_user_wrg_typ_zu_2 v06
 SELECT V01.aktions_pos_kz,
 V01.annahmeverweigerung_id,
 V01.art_id,
 V01.besch_palette_fg,
 V01.bruttogew,
 V01.dat_aenderung,
 V01.dat_haltbarkeit,
 V01.diff_id,
 V01.lagerort_id,
 V01.lief_beleg_id,
 V01.lief_beleg_pos_id,
 V01.mandant_id,
 V01.menge_lief_ist_bme,
 V01.menge_lief_soll_kolli,
 V01.menge_lief_palette,
 V01.nb_id,
 V01.system_id,
 V01.verk_menge_einh_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.wup_id,
 V01.dat_lief_soll,
 V01.menge_lief_soll_bme,
 V01.menge_lief_ist_kolli,
 V01.menge_lief_ist_lme,
  CASE
  WHEN V01.wrg_typ_id = 0
  THEN V01.betrag_lief_ist * V01.umrechnungskurs * V04.ek_anzeige_fg
  ELSE V01.betrag_lief_ist * V04.ek_anzeige_fg
  END AS betrag_lief_ist,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE CASE
   WHEN V01.wrg_typ_id = 0
   THEN V01.betrag_lief_soll * V01.umrechnungskurs * V04.ek_anzeige_fg
   ELSE V01.betrag_lief_soll * V04.ek_anzeige_fg
   END
  END AS betrag_lief_soll,
  CASE
  WHEN V01.dat_lief_soll < DATE '2005-04-12'
  THEN 0
  ELSE CASE
   WHEN V01.wrg_typ_id = 0
   THEN (V01.betrag_lief_soll - V01.betrag_lief_ist) * V01.umrechnungskurs * V04.ek_anzeige_fg
   ELSE (V01.betrag_lief_soll - V01.betrag_lief_ist) * V04.ek_anzeige_fg
   END
  END AS betrag_lief_fehl,
 V01.menge_lief_fehl_bme,
 V01.menge_lief_fehl_kolli,
 V01.wrg_id,
 V01.menge_kolli,
 V01.wrg_typ_id,
 V01.vk_netto_lief_soll,
 V01.vk_netto_lief_ist,
 V01.vk_netto_lief_fehl,
 V01.letzter_we_markt_lief,
 V01.bestellart_id,
 V01.kj,
 V01.mandant_id_kunde,
 V01.kunde_id,
 V01.nb_id_kunde,
 V01.lief_pal_typ_id,
 V01.auslieferungsgruppe_id,
 V01.lagernummer_id,
 V01.lief_typ_id,
 V01.werbeware_id,
 V01.gp_id,
 V01.versandstelle_id,
 V01.vertr_beleg_typ_id,
 V01.wg_verkett_fg,
 V01.wg_verkett_lief
FROM kfl_production_dbp_msi_view3_materialized.tbl_mv_besch_lief_det_2 AS V01
 INNER JOIN kfl_production_dbp_msi_view3_materialized.mv_akt_msi_user_prj_wrg_typ_zu_2(USERID) AS V06 ON V01.wrg_typ_id = V06.wrg_typ_id
  
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_2 AS V04 ON TRUE;
