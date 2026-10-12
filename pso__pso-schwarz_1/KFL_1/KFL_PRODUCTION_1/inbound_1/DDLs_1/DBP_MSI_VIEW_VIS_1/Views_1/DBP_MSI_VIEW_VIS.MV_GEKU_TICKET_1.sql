CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_TICKET_1 as
   -- GEKU Lookup/Zuordnung
   -- Mapping Mandant_1!
   -- 2011KW46 Initial
   -- 08.08.2018 twie: SPEC0038089 Entfernung Filterung auf Status_1 und Anpassung Mandantlogik an KMR, damit Zahlen vergleichbar sind

   SELECT
   geku_ticket_id, geku_artikel_uid, beschwerde_antwort_id, abschlussgrund_id, wmd_agentur, wmd_austraeger_gebiet_uid, geku_eingangskanal_id, geku_emotion_id, dat_start, dat_ende, wmd_kunde, kunde_plz, v01.kunde_strasse, v01.kunde_land_id, v01.dat_zufriedenheit_abfrage, v01.kunde_ort, v01.kunde_viertel, v01.geku_antwortkanal_id, v01.geku_prioritaet_id, v01.auto_zwischenbescheid_fg, v01.mehrfachanliegen_nr, CASE
   WHEN wup_id IS NULL THEN mandant_id
   ELSE mandant_id_wup
   END AS geku_mandant_id, CASE
   WHEN wup_id IS NULL THEN mandant_id
   ELSE mandant_id_wup
   END AS mandant_id, CASE
   WHEN wup_id IS NULL THEN -1
   ELSE nb_id
   END AS nb_id, COALESCE(wup_id, 0) AS wup_id
   FROM dbp_view.v_geku_ticket_1  v01
;