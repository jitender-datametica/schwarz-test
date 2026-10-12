CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_F_GEKU_TICKET
(
geku_ticket_id
,geku_artikel_uid
,beschwerde_antwort_id
,abschlussgrund_id
,wmd_austraeger_gebiet_uid
,geku_eingangskanal_id
,geku_emotion_id
,dat_start
,dat_ende
,wup_id
,nb_id
,mandant_id
,dat_zufriedenheit_abfrage
,geku_antwortkanal_id
,geku_prioritaet_id
,geku_status_id
,hat_gutschein_fg
)
AS
-- 16.08.2013 twie: Dummyfiliale 0 hinzugefügt
-- 12.02.2016 twie: Flag, ob Gutscheine am Ticket hängen
-- 31.08.2017 twie: SPEC0025359 es gibt nur noch ein Landattr. in KMR, wenn vorhanden den Mandant des WUPs, sonst den Mandant des Tickets nehmen

   SELECT
   v01.geku_ticket_id
   , geku_artikel_uid
   , beschwerde_antwort_id
   , abschlussgrund_id
   , wmd_austraeger_gebiet_uid
   , geku_eingangskanal_id
   , geku_emotion_id
   , dat_start
   , dat_ende
   , COALESCE(wup_id, 0) AS wup_id
   , CASE
      WHEN wup_id IS NULL THEN -1
      ELSE nb_id
      END AS nb_id
   , CASE
      WHEN wup_id IS NULL THEN v01.mandant_id
      ELSE mandant_id_wup
      END AS mandant_id
   , dat_zufriedenheit_abfrage
   , geku_antwortkanal_id
   , geku_prioritaet_id
   , geku_status_id
   , CASE
       WHEN v02.geku_ticket_id IS NULL THEN 0 
       ELSE 1 
       END AS hat_gutschein_fg
   
   FROM dbp_view.v_geku_ticket v01
   
   LEFT OUTER JOIN
   (
   SELECT
   DISTINCT geku_ticket_id
   FROM dbp_view.v_gutschein
   WHERE transaktion_id = 4 --aktivierte Gutscheine
   --nur GEKU Gutscheine
   AND ausgeber_id = 'KDM004'
   OR ausgeber_id = 'KDM005'
   ) v02
   ON v01.geku_ticket_id = v02.geku_ticket_id;