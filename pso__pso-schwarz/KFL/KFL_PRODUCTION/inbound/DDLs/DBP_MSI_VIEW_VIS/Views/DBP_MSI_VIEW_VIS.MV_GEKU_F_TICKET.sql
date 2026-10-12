CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_F_TICKET as
   -- GEKU Fakt Ticket
   -- Mapping mandant_id!
   -- 2011KW46 Initial
   -- 08.08.2018 twie: SPEC0038089 Entfernung Filterung auf Status und Anpassung Mandantlogik an KMR, damit Zahlen vergleichbar sind

   SELECT
   geku_ticket_id, geku_artikel_uid, beschwerde_antwort_id, abschlussgrund_id, wmd_austraeger_gebiet_uid, geku_eingangskanal_id, geku_emotion_id, dat_start, dat_ende, dat_zufriedenheit_abfrage, geku_antwortkanal_id, geku_prioritaet_id, CASE
   WHEN wup_id IS NULL THEN mandant_id
   ELSE mandant_id_wup
   END AS geku_mandant_id, CASE
   WHEN wup_id IS NULL THEN mandant_id
   ELSE mandant_id_wup
   END AS mandant_id, CASE
   WHEN wup_id IS NULL THEN -1
   ELSE nb_id
   END AS nb_id, COALESCE(wup_id, 0) AS wup_id
   FROM dbp_view.v_geku_ticket
;