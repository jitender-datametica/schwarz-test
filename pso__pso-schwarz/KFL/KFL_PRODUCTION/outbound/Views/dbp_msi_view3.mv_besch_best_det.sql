-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

-- NSR0828595, mcie, 03/07/2019, added loesch_fg=0 in where clause

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view3.mv_besch_best_det(USERID STRING) AS SELECT V01.art_id,
 V01.best_beleg_id,
 V01.best_beleg_pos_id,
 V01.best_preis_menge_einh_id,
 V01.best_menge_einh_id AS best_basismenge_einh_id,
 V01.dat_aenderung,
 V01.dat_best_beleg,
 V01.endlief_fg,
 V01.lagerort_id,
 V01.loesch_fg,
 V01.mandant_id,
 V01.menge_best_bme,
 V01.menge_best_kolli,
 V01.menge_best_palette,
 V01.nb_id,
 V01.selbstabhol_fg,
 V01.wup_id,
 V01.filiale_id,
 V01.kunde_id,
 V01.bestellart_id,
 V01.gp_id,
 V01.lieferndeswerk,
 V01.lieferndeswerk_nb_id,
  CASE
  WHEN V01.wrg_typ_id = 0
  THEN V01.betrag_best * V01.umrechnungskurs * V05.ek_anzeige_fg
  ELSE V01.betrag_best * V05.ek_anzeige_fg
  END AS betrag_best,
 V01.wrg_id,
 V01.wrg_typ_id,
 V01.menge_block_bestand,
 V01.gp_teilsortiment_id
FROM kfl_production_dbp_msi_view3.tbl_mv_besch_best_det AS V01
 INNER JOIN kfl_production_dbp_msi_view3.mv_akt_msi_user_prj_wrg_typ_zu(USERID) AS V06 ON V01.wrg_typ_id = V06.wrg_typ_id
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu(USERID) AS V05 ON TRUE;