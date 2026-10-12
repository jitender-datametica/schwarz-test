-- 2008-12-08
 -- 2009Kw17 Eur + Lw Über Waehrungstyp
 -- 2009-03-12
 -- 2008-12 Historisierte Daten Mv

-- 2011Kw37: Ueberarbeitung Ermittlung Flaechenstatus

-- 2011Kw37: Umstellen Von Flaeche_Typ_Id = F, A, W Auf 10, 30, 90, 91

-- Faktview Denormalisiert, Historisierung Durch Projektion Auf Zeit (Kjmo)

-- Review 2007-07, 2008-09 Erweiterung Zeitraum
 -- Eur + Landeswährung

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_flaeche_konditionen AS -- Basis: Aktuell Gültige Flächen

-- Projektion Zeit (Aktuelles + Voriges Gj)
 -- Historische Flächen-Daten
 -- Historische Mietvertrags-Flächen-Daten

-- Letzter Gültiger Mietvertrags-Datensatz
 -- Historische Mietvertrags-Daten
 -- Plandaten
 SELECT Fl.mandant_id,
 Fl.immo_objekt_id,
 Fl.flaeche_id,
 Fl.flaecheart_id,
 Fl.flaeche_typ_id,
 Fl.std_vertragart_id,
 Fl.wrg_id,
 Zeit.kjmo,
 MFSZP.flaeche_status_id,
 Flx.flaeche_groesse,
 COALESCE(CAST(Mv.mietvertrag_id AS BIGNUMERIC), CAST(Mvf.mietvertrag_id AS BIGNUMERIC), 0) AS mietvertrag_id,
 COALESCE(Mv.vertragart_id, Mvf.vertragart_id, '000') AS vertragart_id,
 COALESCE(CAST(Mv.konzessionaer_id AS BIGNUMERIC), CAST(Mvf.konzessionaer_id AS BIGNUMERIC), 0) AS konzessionaer_id,
 COALESCE(Mvf.branche_id, '000') AS branche_id,
  Mvf.miete_betrag * Fl.umrechnungskurs AS ist_grundmiete,
 Mvf.miete_umsatz_prozent AS ist_miete_proz,
  Mvf.miete_umsatz_abschlag * Fl.umrechnungskurs AS ist_umsatzmiete,
  COALESCE(Mvf.nk_mvf + Mv.nk_mv, Mvf.nk_mvf + Mvf.nk_mv, Mvf.nk_mvf, Mv.nk_mv) * Fl.umrechnungskurs AS ist_nebenkosten
 ,
  Mvf.sonst_betrag * Fl.umrechnungskurs AS ist_sonst,
  Mvf.immo_verw_betrag * Fl.umrechnungskurs AS ist_immovw,
  Pl.plan_grundmiete * Fl.umrechnungskurs AS plan_grundmiete,
  Pl.plan_umsatzmiete * Fl.umrechnungskurs AS plan_umsatzmiete,
  Pl.plan_nebenkosten * Fl.umrechnungskurs AS plan_nebenkosten,
  Pl.plan_sonst * Fl.umrechnungskurs AS plan_sonst,
  Pl.plan_invest * Fl.umrechnungskurs AS plan_invest,
  Pl.plan_immovw * Fl.umrechnungskurs AS plan_immovw
FROM (SELECT FL.mandant_id,
   FL.immo_objekt_id,
   FL.flaeche_id,
   FL.flaecheart_id,
   FL.std_vertragart_id,
   FL.flaeche_typ_id,
   FL.flaecheart_leerstand_id,
   FL.flaecheart_leerstand_bez,
   FL.wrg_id,
   FL.wrg_typ_id,
   K.umrechnungskurs
  FROM kfl_production_dbp_msi_view_ivs.mv_flaeche_per AS FL
   INNER JOIN kfl_production_dbp_view.v_kurs AS K ON FL.wrg_id = K.von_wrg_id AND K.kurstyp_id = 3 AND K.dat_bis =
     DATE '9999-12-31'
  WHERE FL.dat_bis = DATE '9999-12-31'
   AND FL.flaeche_typ_id IN (10, 30, 90, 91)) AS Fl
 INNER JOIN (SELECT gj,
   kjmo,
   DATE(SUBSTR(CAST(kjmo AS STRING), 1, 6)) AS datmin,
   DATE_SUB(IF(DATE(SUBSTR(SAFE_CAST(kjmo as STRING), 1, 6)) = LAST_DAY(DATE(SUBSTR(SAFE_CAST(kjmo as STRING), 1, 6))),
     LAST_DAY(DATE_ADD(DATE(SUBSTR(SAFE_CAST(kjmo as STRING), 1, 6)), INTERVAL 1 MONTH)), DATE_ADD(DATE(SUBSTR(SAFE_CAST(kjmo
         as STRING), 1, 6)), INTERVAL 1 MONTH)), INTERVAL 1 DAY) AS datmax
  FROM kfl_production_dbp_view.v_monat
  WHERE akt_gj BETWEEN - 2 AND 0) AS Zeit ON TRUE
 LEFT JOIN (SELECT mandant_id,
   flaeche_id,
   flaeche_groesse,
   dat_existiert_seit,
   dat_existiert_bis,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_view.v_ivs_flaeche_per AS FL) AS Flx ON Fl.flaeche_id = Flx.flaeche_id AND Fl.mandant_id = Flx
     .mandant_id AND Zeit.datmax BETWEEN Flx.dat_von AND Flx.dat_bis AND Zeit.datmax BETWEEN Flx.dat_existiert_seit AND
   Flx.dat_existiert_bis
 LEFT JOIN (SELECT MVF0.mandant_id,
   MVF0.mietvertrag_id,
   MVF0.flaeche_id,
   MVF0.branche_id,
   MVF0.miete_betrag,
   COALESCE(MVF0.nebenkosten_betrag + MVF0.nebenkosten_abschlag, MVF0.nebenkosten_betrag, MVF0.nebenkosten_abschlag) AS
   nk_mvf,
   MVF0.miete_umsatz_abschlag,
   MVF0.miete_umsatz_prozent,
   MVF0.immo_verw_betrag,
   MVF0.sonst_betrag,
   MVF0.dat_flaeche_uebergabe,
   MVF0.dat_flaeche_rueckgabe,
   MVF0.dat_von,
   MVF0.dat_bis,
   Mv0.vertragart_id,
   Mv0.dat_vertrag_beginn,
   Mv0.dat_vertrag_ende,
   Mv0.konzessionaer_id,
   Mv0.nk_mv
  FROM kfl_production_dbp_view.v_ivs_mietvertrag_fl_zu_per AS MVF0
   INNER JOIN (SELECT mandant_id,
     mietvertrag_id,
     vertragart_id,
     konzessionaer_id,
     COALESCE(nebenkosten_betrag + nebenkosten_abschlag, nebenkosten_betrag, nebenkosten_abschlag) AS nk_mv,
     dat_vertrag_beginn,
     dat_vertrag_ende,
     dat_von,
     dat_bis
    FROM kfl_production_dbp_view.v_ivs_mietvertrag_per AS MV00
    WHERE dat_bis = DATE '9999-12-31') AS Mv0 ON MVF0.mandant_id = Mv0.mandant_id AND MVF0.mietvertrag_id = Mv0.mietvertrag_id
     ) AS Mvf ON Fl.mandant_id = Mvf.mandant_id AND Fl.flaeche_id = Mvf.flaeche_id AND Zeit.datmax BETWEEN Mvf.dat_von
     AND Mvf.dat_bis AND Zeit.datmax BETWEEN Mvf.dat_flaeche_uebergabe AND Mvf.dat_flaeche_rueckgabe AND Zeit.datmax
   BETWEEN Mvf.dat_vertrag_beginn AND Mvf.dat_vertrag_ende
 LEFT JOIN (SELECT mandant_id,
   mietvertrag_id,
   vertragart_id,
   dat_vertrag_beginn,
   dat_vertrag_ende,
   konzessionaer_id,
   COALESCE(nebenkosten_betrag + nebenkosten_abschlag, nebenkosten_betrag, nebenkosten_abschlag) AS nk_mv,
   nebenkosten_betrag,
   nebenkosten_abschlag,
   dat_von,
   dat_bis
  FROM kfl_production_dbp_view.v_ivs_mietvertrag_per AS MV0) AS Mv ON Mvf.mandant_id = Mv.mandant_id AND Mvf.mietvertrag_id
      = Mv.mietvertrag_id AND Zeit.datmax BETWEEN Mv.dat_von AND Mv.dat_bis AND Zeit.datmax BETWEEN Mv.dat_vertrag_beginn
   AND Mv.dat_vertrag_ende
 LEFT JOIN (SELECT mandant_id,
   plan_objekt_id AS flaeche_id,
   kjmo,
   SUM(CASE
     WHEN plandetail_id IN (1, 80)
     THEN plan_wert
     ELSE NULL
     END) AS plan_grundmiete,
   SUM(CASE
     WHEN plandetail_id = 2
     THEN plan_wert
     ELSE NULL
     END) AS plan_umsatzmiete,
   SUM(CASE
     WHEN plandetail_id = 3
     THEN plan_wert
     ELSE NULL
     END) AS plan_nebenkosten,
   SUM(CASE
     WHEN plandetail_id = 4
     THEN plan_wert
     ELSE NULL
     END) AS plan_sonst,
   SUM(CASE
     WHEN plandetail_id = 5
     THEN plan_wert
     ELSE NULL
     END) AS plan_invest,
   SUM(CASE
     WHEN plandetail_id = 9
     THEN plan_wert
     ELSE NULL
     END) AS plan_immovw
  FROM kfl_production_dbp_view.v_ivs_plan
  GROUP BY mandant_id,
   flaeche_id,
   kjmo) AS Pl ON Fl.mandant_id = Pl.mandant_id AND Fl.flaeche_id = Pl.flaeche_id AND Zeit.kjmo = Pl.kjmo
 INNER JOIN kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per AS MFSZP ON Fl.mandant_id = MFSZP.mandant_id AND Fl.flaeche_id
       = MFSZP.flaeche_id AND Mvf.mietvertrag_id = MFSZP.mietvertrag_id AND Zeit.datmax BETWEEN MFSZP.dat_von AND MFSZP
    .dat_bis AND MFSZP.flaeche_status_id <> 0;