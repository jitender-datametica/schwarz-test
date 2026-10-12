-- 16.08.2013 twie: Dummyfiliale 0 hinzugefügt

-- 31.08.2017 twie: SPEC0025359 es gibt nur noch ein Landattr. in KMR, wenn vorhanden den Mandant des WUPs, sonst den Mandant des Tickets nehmen

-- 12.02.2016 twie: Flag, ob Gutscheine am Ticket hängen
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_f_geku_ticket (geku_ticket_id
, geku_artikel_uid, beschwerde_antwort_id, abschlussgrund_id, wmd_austraeger_gebiet_uid, geku_eingangskanal_id,
geku_emotion_id, dat_start, dat_ende, wup_id, nb_id, mandant_id, dat_zufriedenheit_abfrage, geku_antwortkanal_id,
geku_prioritaet_id, geku_status_id, hat_gutschein_fg) AS SELECT v01.geku_ticket_id,
 v01.geku_artikel_uid,
 v01.beschwerde_antwort_id,
 v01.abschlussgrund_id,
 v01.wmd_austraeger_gebiet_uid,
 v01.geku_eingangskanal_id,
 v01.geku_emotion_id,
 v01.dat_start,
 v01.dat_ende,
 COALESCE(v01.wup_id, 0) AS wup_id,
  CASE
  WHEN v01.wup_id IS NULL
  THEN - 1
  ELSE v01.nb_id
  END AS nb_id,
  CASE
  WHEN v01.wup_id IS NULL
  THEN v01.mandant_id
  ELSE v01.mandant_id_wup
  END AS mandant_id,
 v01.dat_zufriedenheit_abfrage,
 v01.geku_antwortkanal_id,
 v01.geku_prioritaet_id,
 v01.geku_status_id,
  CASE
  WHEN v02.geku_ticket_id IS NULL
  THEN 0
  ELSE 1
  END AS hat_gutschein_fg
FROM kfl_production_dbp_view.v_geku_ticket AS v01
 LEFT JOIN (SELECT DISTINCT geku_ticket_id
  FROM kfl_production_dbp_view.v_gutschein
  WHERE transaktion_id = 4 -- aktivierte Gutscheine
 -- nur GEKU Gutscheine
 AND ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005') AS v02 ON v01.geku_ticket_id = v02.geku_ticket_id;