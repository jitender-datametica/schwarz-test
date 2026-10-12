CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_TICKET
(
geku_ticket_id
,geku_artikel_uid
,beschwerde_antwort_id
,abschlussgrund_id
,wmd_agentur
,wmd_austraeger_gebiet_uid
,geku_eingangskanal_id
,geku_emotion_id
,dat_start
,dat_ende
,wmd_kunde
,wup_id
,nb_id
,mandant_id
,kunde_plz
,kunde_strasse
,kunde_land_id
,dat_zufriedenheit_abfrage
,kunde_ort
,kunde_viertel
,geku_antwortkanal_id
,geku_prioritaet_id
,auto_zwischenbescheid_fg
,mehrfachanliegen_nr
,geku_mzk_grund_uid
,geku_team_id
,geku_schr_bereich_person_id
,geku_stichwort
,geku_stichwort_uid
,mandant_id_mzk
,geku_status_id
,idee_fg
,dat_non_pers_anon
,dat_pers_anon
)
AS
--17.09.2013 twie: Umstellung geku_stichwort auf geku_stichwort_uid
--23.03.2015 twie: neues idee_fg
--28.04.2015 twie: 2 neue Datumsfelder anonym
--31.08.2017 twie: SPEC0025359 es gibt nur noch ein Landattr. in KMR, wenn vorhanden den Mandant des WUPs, sonst den Mandant des Tickets nehmen

   SELECT
   geku_ticket_id
   , geku_artikel_uid
   , beschwerde_antwort_id
   , abschlussgrund_id
   , wmd_agentur
   , wmd_austraeger_gebiet_uid
   , geku_eingangskanal_id
   , geku_emotion_id
   , dat_start
   , dat_ende
   , wmd_kunde
   , COALESCE(wup_id, 0) AS wup_id
   , CASE
      WHEN wup_id IS NULL THEN -1
      ELSE nb_id
      END AS nb_id
   , CASE
      WHEN wup_id IS NULL THEN mandant_id
      ELSE mandant_id_wup
      END AS mandant_id
   , kunde_plz
   , kunde_strasse
   , kunde_land_id
   , dat_zufriedenheit_abfrage
   , kunde_ort
   , kunde_viertel
   , geku_antwortkanal_id
   , geku_prioritaet_id
   , auto_zwischenbescheid_fg
   , mehrfachanliegen_nr
   , geku_mzk_grund_uid
   , geku_team_id
   , geku_schr_bereich_person_id
   , '' AS geku_stichwort --temporär
   , geku_stichwort_uid
   , mandant_id_mzk
   , geku_status_id
   , COALESCE(idee_fg, 0) AS idee_fg
   , dat_non_pers_anon
   , dat_pers_anon
   FROM dbp_view.v_geku_ticket;