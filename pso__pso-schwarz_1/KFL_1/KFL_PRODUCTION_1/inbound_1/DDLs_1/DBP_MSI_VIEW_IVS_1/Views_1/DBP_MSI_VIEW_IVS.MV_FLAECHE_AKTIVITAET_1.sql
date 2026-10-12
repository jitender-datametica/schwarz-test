CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_FLAECHE_AKTIVITAET_1
AS
   -- 20090715
   -- FAKTVIEW Flaechenkommentare
   -- 2009KW37 Redesign fuer Pflegeberichte (outer join auf Flaeche)
   -- 2011KW35 aktivitaet_obkejt_leiter, aktivitaet_notiz entfernt
   -- 2011KW37 Umstellung auf SAP Aktivitaeten
   -- 20120307 Anpassung Aktivitaet -99 / Ergebnis
   -- 20120503 Review (komplett)

   SELECT
   sub01.mandant_id,
   sub01.flaeche_id,
   sub01.aktivitaet_ergebnis,
   COALESCE(sub02.aktivitaet_status, 0) AS aktivitaet_status,
   COALESCE(sub02.dat_aktivitaet, '1900-01-01') dat_aktivitaet,
   COALESCE(sub02.aktivitaet_typ_id, 17) AS aktivitaet_typ_id,
   COALESCE(sub02.aktivitaet_bez, 'Sonstige') AS aktivitaet_bez
  FROM
  (
  SELECT
  v01.mandant_id,
   v01.flaeche_id,
   COALESCE(v02.ergebnis, '') AS aktivitaet_ergebnis
  FROM dbp_view.v_ivs_flaeche_per_1 v01
   LEFT OUTER JOIN
   (
   SELECT
   mandant_id,
   flaeche_id,
   MAX(COALESCE(TRIM(aktivitaet_ergebnis),' - ')) AS ergebnis
  FROM dbp_view.v_ivs_flaeche_aktivitaet_1
  GROUP BY
  mandant_id
  , flaeche_id
  )v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.flaeche_id = v02.flaeche_id
   WHERE v01.dat_bis = '9999-12-31'
   ) sub01
   LEFT OUTER JOIN dbp_view.v_ivs_flaeche_aktivitaet_1 sub02
   ON sub01.mandant_id = sub02.mandant_id
   AND sub01.flaeche_id = sub02.flaeche_id
   AND sub02.aktivitaet_typ_id > -1;