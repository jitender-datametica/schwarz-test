CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_FLAECHE_DN_AKTIVITAET_1 as
   -- 20090715
   -- FAKTVIEW Flaechenkommentare denormalisiert
   -- 2009KW37 Redesign fuer Pflegeberichte
   -- 2011KW47 Anpassen an geaenderte Abbildung in SAP
   --20120503 Review (Anpassung Ergebnisse/Filterung)

   SELECT
   sub01.mandant_id,
   sub01.flaeche_id,
   COALESCE(akt.aktivitaet1 , '') ||
  COALESCE(akt.aktivitaet2 , '') ||
  COALESCE(akt.aktivitaet3 , '') ||
  COALESCE(akt.aktivitaet4 , '') ||
  COALESCE(akt.aktivitaet5 , '') ||
  COALESCE(akt.aktivitaet6 , '') ||
  COALESCE(akt.aktivitaet7 , '') ||
  COALESCE(akt.aktivitaet8 , '') ||
  COALESCE(akt.aktivitaet9 , '') ||
  COALESCE(akt.aktivitaet10, '') ||
  COALESCE(akt.aktivitaet11, '') ||
  COALESCE(akt.aktivitaet12, '') ||
  COALESCE(akt.aktivitaet13, '') ||
  COALESCE(akt.aktivitaet14, '') ||
  COALESCE(akt.aktivitaet15, '') ||
  COALESCE(akt.aktivitaet16, '') ||
  COALESCE(akt.aktivitaet17, '')::VARCHAR(350) AS aktivitaeten_gesamt,
   sub01.ergebniss || ' '::VARCHAR(5000)   AS ergebniss_gesamt
   -- das abschliessende blank ist wichtig fuer die Anzeige
   FROM
   ( -- ergebnisse ungefiltert
   SELECT
   v01.mandant_id,
   v01.flaeche_id,
   MAX(COALESCE(TRIM(v01.aktivitaet_ergebnis),'')) AS ergebniss
  FROM dbp_view.v_ivs_flaeche_aktivitaet_1 v01
   GROUP BY
   v01.mandant_id
   , v01.flaeche_id
   ) sub01
   LEFT JOIN
   ( -- aktivitaeten der letzten 45 Tage
   SELECT
   mfl.mandant_id,
   mfl.flaeche_id,
   MAX(CASE WHEN aktivitaet_typ_id = 1  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet1,
   MAX(CASE WHEN aktivitaet_typ_id = 2  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet2,
   MAX(CASE WHEN aktivitaet_typ_id = 3  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet3,
   MAX(CASE WHEN aktivitaet_typ_id = 4  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet4,
   MAX(CASE WHEN aktivitaet_typ_id = 5  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet5,
   MAX(CASE WHEN aktivitaet_typ_id = 6  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet6,
   MAX(CASE WHEN aktivitaet_typ_id = 7  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet7,
   MAX(CASE WHEN aktivitaet_typ_id = 8  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet8,
   MAX(CASE WHEN aktivitaet_typ_id = 9  THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet9,
   MAX(CASE WHEN aktivitaet_typ_id = 10 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet10,
   MAX(CASE WHEN aktivitaet_typ_id = 11 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet11,
   MAX(CASE WHEN aktivitaet_typ_id = 12 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet12,
   MAX(CASE WHEN aktivitaet_typ_id = 13 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet13,
   MAX(CASE WHEN aktivitaet_typ_id = 14 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet14,
   MAX(CASE WHEN aktivitaet_typ_id = 15 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet15,
   MAX(CASE WHEN aktivitaet_typ_id = 16 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet16,
   MAX(CASE WHEN aktivitaet_typ_id = 17 THEN '(' || TRIM(aktivitaet_typ_id) ||  ')'  || ' ' || (dat_aktivitaet /*Warning, Format 'DD.MM.YYYY' removed.*/) ||  '    ' END) AS aktivitaet17
  FROM dbp_view.v_ivs_flaeche_aktivitaet_1 mfl
   WHERE (mfl.dat_aktivitaet >= CURRENT_DATE - 45)
   GROUP BY
   mfl.mandant_id
   , mfl.flaeche_id
   ) akt
   ON sub01.mandant_id = akt.mandant_id
   AND sub01.flaeche_id = akt.flaeche_id;