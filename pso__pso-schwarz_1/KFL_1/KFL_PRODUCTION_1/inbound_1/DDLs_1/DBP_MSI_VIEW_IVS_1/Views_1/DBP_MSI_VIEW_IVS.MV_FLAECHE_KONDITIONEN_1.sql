CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_FLAECHE_KONDITIONEN_1 as
   -- 2009-03-12
   -- 2008-12-08
   -- Faktview Denormalisiert, Historisierung Durch Projektion Auf Zeit_1 (Kjmo)
   -- Eur + Landeswährung
   -- Review 2007-07, 2008-09 Erweiterung Zeitraum
   -- 2008-12 Historisierte Daten Mv
   -- 2009Kw17 Eur + Lw Über Waehrungstyp
   -- 2011Kw37: Umstellen Von Flaeche_Typ_Id = F, A, W Auf 10, 30, 90, 91
   -- 2011Kw37: Ueberarbeitung Ermittlung Flaechenstatus

   SELECT
   Fl.Mandant_Id,
   Fl.Immo_Objekt_Id,
   Fl.Flaeche_Id,
   Fl.Flaecheart_Id,
   Fl.Flaeche_Typ_Id,
   Fl.Std_Vertragart_Id,
   Fl.Wrg_Id,
   Zeit.Kjmo,
   mfszp.flaeche_status_id,
   Flx.Flaeche_Groesse,
   COALESCE (Mv.Mietvertrag_Id, Mvf.Mietvertrag_Id, 0)    AS Mietvertrag_Id,
   COALESCE (Mv.Vertragart_Id, Mvf.Vertragart_Id, '000')  AS Vertragart_Id,
   COALESCE (Mv.Konzessionaer_Id, Mvf.Konzessionaer_Id,0) AS Konzessionaer_Id,
   COALESCE (Mvf.Branche_Id,'000')                        AS Branche_Id,
   Mvf.Miete_Betrag * umrechnungskurs                     AS Ist_Grundmiete,
   Mvf.Miete_Umsatz_Prozent                               AS Ist_Miete_Proz,
   Mvf.Miete_Umsatz_Abschlag * umrechnungskurs            AS Ist_Umsatzmiete,
   COALESCE(Mvf.Nk_Mvf + Mv.Nk_Mv, Mvf.Nk_Mvf + Mvf.Nk_Mv, Mvf.Nk_Mvf, Mv.Nk_Mv)  * umrechnungskurs  AS Ist_Nebenkosten,
   Mvf.Sonst_Betrag * umrechnungskurs                     AS Ist_Sonst,
   Mvf.Immo_Verw_Betrag * umrechnungskurs                 AS Ist_Immovw,
   Pl.Plan_Grundmiete * umrechnungskurs                   AS Plan_Grundmiete,
   Pl.Plan_Umsatzmiete * umrechnungskurs                  AS Plan_Umsatzmiete,
   Pl.Plan_Nebenkosten * umrechnungskurs                  AS Plan_Nebenkosten,
   Pl.Plan_Sonst * umrechnungskurs                        AS Plan_Sonst,
   Pl.Plan_Invest * umrechnungskurs                       AS Plan_Invest,
   Pl.Plan_Immovw * umrechnungskurs                       AS Plan_Immovw
   FROM  -- Basis: Aktuell Gültige Flächen
   (
   SELECT
   Mandant_Id,
   Immo_Objekt_Id,
   Flaeche_Id,
   Flaecheart_Id,
   Std_Vertragart_Id,
   Flaeche_Typ_Id,
   Flaecheart_Leerstand_Id,
   Flaecheart_Leerstand_Bez,
   fl.Wrg_Id,
   fl.Wrg_Typ_Id,
   k.umrechnungskurs
   FROM dbp_msi_view_ivs.Mv_Flaeche_Per_1 fl
   INNER JOIN dbp_view.v_Kurs_1 k
   ON k.Von_Wrg_Id = fl.Wrg_Id
   AND k.Kurstyp_Id = 3
   AND k.Dat_Bis = '9999-12-31'

   WHERE fl.Dat_Bis = '9999-12-31'
   AND fl.Flaeche_Typ_Id IN (10,30,90,91)
   ) Fl
   CROSS JOIN  -- Projektion Zeit_1 (Aktuelles + Voriges Gj)
   (
   SELECT
   Gj,
   Kjmo,
   TO_DATE(CAST(Kjmo AS CHAR (6)), 'yyyymm')  Datmin,
   ADD_MONTHS(Datmin, 1) - 1  Datmax
   FROM dbp_view.v_Monat_1
   WHERE Akt_Gj BETWEEN -2 AND 0
   ) Zeit_1
   LEFT JOIN  -- Historische Flächen-Daten
   (
   SELECT
   Fl.Mandant_Id,
   Fl.Flaeche_Id,
   Fl.Flaeche_Groesse,
   Fl.Dat_Existiert_Seit,
   Fl.Dat_Existiert_Bis,
   Fl.Dat_Von,
   Fl.Dat_Bis
   FROM dbp_view.v_ivs_Flaeche_Per_1 Fl
   )  Flx
   ON Fl.Flaeche_Id = Flx.Flaeche_Id AND Fl.Mandant_Id=Flx.Mandant_Id
   AND Zeit.Datmax BETWEEN Flx.Dat_Von AND Flx.Dat_Bis
   AND Zeit.Datmax BETWEEN Flx.Dat_Existiert_Seit AND Dat_Existiert_Bis
   LEFT JOIN  -- Historische Mietvertrags-Flächen-Daten
   (
   SELECT
   Mvf0.Mandant_Id,
   Mvf0.Mietvertrag_Id,
   Mvf0.Flaeche_Id,
   Mvf0.Branche_Id,
   Mvf0.Miete_Betrag,
   COALESCE(Mvf0.Nebenkosten_Betrag + Mvf0.Nebenkosten_Abschlag, Mvf0.Nebenkosten_Betrag, Mvf0.Nebenkosten_Abschlag) AS  Nk_Mvf,
   Mvf0.Miete_Umsatz_Abschlag AS Miete_Umsatz_Abschlag,
   Mvf0.Miete_Umsatz_Prozent,
   Mvf0.Immo_Verw_Betrag AS Immo_Verw_Betrag,
   Mvf0.Sonst_Betrag AS Sonst_Betrag,
   Mvf0.Dat_Flaeche_Uebergabe,
   Mvf0.Dat_Flaeche_Rueckgabe,
   Mvf0.Dat_Von,
   Mvf0.Dat_Bis,
   Mv0.Vertragart_Id,
   Mv0.Dat_Vertrag_Beginn,
   Mv0.Dat_Vertrag_Ende,
   Mv0.Konzessionaer_Id,
   Mv0.Nk_Mv
   FROM dbp_view.v_ivs_Mietvertrag_Fl_Zu_Per_1 Mvf0
   INNER JOIN  -- Letzter Gültiger Mietvertrags-Datensatz
   (
   SELECT
   Mv00.Mandant_Id,
   Mv00.Mietvertrag_Id,
   Mv00.Vertragart_Id,
   Mv00.Konzessionaer_Id,
   COALESCE(Nebenkosten_Betrag + Nebenkosten_Abschlag, Nebenkosten_Betrag, Nebenkosten_Abschlag) AS Nk_Mv,
   Mv00.Dat_Vertrag_Beginn,
   Mv00.Dat_Vertrag_Ende,
   Mv00.Dat_Von,
   Mv00.Dat_Bis
   FROM dbp_view.v_ivs_Mietvertrag_Per_1 Mv00

   WHERE Mv00.Dat_Bis = '9999-12-31'
   ) Mv0
   ON Mvf0.Mandant_Id = Mv0.Mandant_Id
   AND Mvf0.Mietvertrag_Id = Mv0.Mietvertrag_Id

   )  Mvf
   ON Fl.Mandant_Id = Mvf.Mandant_Id
   AND Fl.Flaeche_Id = Mvf.Flaeche_Id
   AND Zeit.Datmax BETWEEN Mvf.Dat_Von AND Mvf.Dat_Bis
   AND Zeit.Datmax BETWEEN Mvf.Dat_Flaeche_Uebergabe AND Mvf.Dat_Flaeche_Rueckgabe
   AND Zeit.Datmax BETWEEN Mvf.Dat_Vertrag_Beginn AND Mvf.Dat_Vertrag_Ende
   LEFT JOIN  -- Historische Mietvertrags-Daten
   (
   SELECT
   Mv0.Mandant_Id,
   Mv0.Mietvertrag_Id,
   Mv0.Vertragart_Id,
   Mv0.Dat_Vertrag_Beginn,
   Mv0.Dat_Vertrag_Ende,
   Mv0.Konzessionaer_Id,
   COALESCE(Nebenkosten_Betrag + Nebenkosten_Abschlag, Nebenkosten_Betrag, Nebenkosten_Abschlag) AS Nk_Mv,
   Nebenkosten_Betrag AS Nebenkosten_Betrag,
   Nebenkosten_Abschlag AS Nebenkosten_Abschlag,
   Mv0.Dat_Von,
   Mv0.Dat_Bis
   FROM dbp_view.v_ivs_Mietvertrag_Per_1  Mv0
   ) Mv
   ON Mvf.Mandant_Id = Mv.Mandant_Id
   AND Mvf.Mietvertrag_Id = Mv.Mietvertrag_Id
   AND Zeit.Datmax BETWEEN Mv.Dat_Von AND Mv.Dat_Bis
   AND Zeit.Datmax BETWEEN Mv.Dat_Vertrag_Beginn AND Mv.Dat_Vertrag_Ende
   LEFT JOIN  -- Plandaten
   (
   SELECT
   Mandant_Id,
   Plan_Objekt_Id  AS Flaeche_Id,
   Kjmo            AS Kjmo,
   SUM(CASE WHEN Plandetail_Id IN (1,80) THEN Plan_Wert ELSE NULL END) AS Plan_Grundmiete,
   SUM(CASE WHEN Plandetail_Id = 2       THEN Plan_Wert ELSE NULL END) AS Plan_Umsatzmiete,
   SUM(CASE WHEN Plandetail_Id = 3       THEN Plan_Wert ELSE NULL END) AS Plan_Nebenkosten,
   SUM(CASE WHEN Plandetail_Id = 4       THEN Plan_Wert ELSE NULL END) AS Plan_Sonst,
   SUM(CASE WHEN Plandetail_Id = 5       THEN Plan_Wert ELSE NULL END) AS Plan_Invest,
   SUM(CASE WHEN Plandetail_Id = 9       THEN Plan_Wert ELSE NULL END) AS Plan_Immovw
   FROM dbp_view.v_ivs_Plan_1

   GROUP BY Mandant_Id, Flaeche_Id, Kjmo
   ) Pl
   ON Fl.Mandant_Id = Pl.Mandant_Id
   AND Fl.Flaeche_Id = Pl.Flaeche_Id
   AND Zeit.Kjmo = Pl.Kjmo
   INNER JOIN dbp_view.v_ivs_miet_fl_stat_zu_per_1 mfszp
   ON mfszp.Mandant_Id = Fl.Mandant_Id
   AND mfszp.Flaeche_Id = Fl.Flaeche_Id
   AND mfszp.mietvertrag_id = Mvf.Mietvertrag_Id
   AND Zeit.Datmax BETWEEN mfszp.dat_von AND mfszp.dat_bis
   AND mfszp.flaeche_status_id <> 0;