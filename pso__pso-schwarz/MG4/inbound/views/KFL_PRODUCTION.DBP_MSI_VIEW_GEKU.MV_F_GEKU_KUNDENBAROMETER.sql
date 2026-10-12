create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_F_GEKU_KUNDENBAROMETER(
	GEKU_TICKET_ID_KUNDENBAROMETER,
	DAT,
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	KDC_FG,
	MZK_FG,
	WMD_FG,
	SEC_KZ,
	NOTE_AUSWAHL,
	NOTE_FRISCHE,
	NOTE_QUALITAET,
	NOTE_BERATUNG,
	NOTE_FREUNDLICHKEIT_ALLG,
	NOTE_FREUNDLICHKEIT_THEKE,
	NOTE_FREUNDLICHKEIT_KASSE,
	NOTE_SCHNELLIGKEIT_KASSE,
	NOTE_SCHNELLIGKEIT_THEKE,
	NOTE_PREIS
) as
-- 21.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter
-- 31.08.2017 twie: SPEC0025359 mandant_id_wup als mandant_id, es gibt nur noch ein Landattr. in KMR
-- 12.10.2022 twie: SPEC0167837 sek_kz von 1 auf 3 geändert

   SELECT
   geku_ticket_id_kundenbarometer
   , dat
   , wup_id
   , nb_id
   , mandant_id_wup  AS mandant_id
   , 1::BYTEINT         KDC_fg
   , 0::BYTEINT         MZK_fg
   , 0::BYTEINT         WMD_fg
   , 3::BYTEINT AS sec_kz
   , note_auswahl
   , note_frische
   , note_qualitaet
   , note_beratung
   , note_freundlichkeit_allg
   , note_freundlichkeit_theke
   , note_freundlichkeit_kasse
   , note_schnelligkeit_kasse
   , note_schnelligkeit_theke
   , note_preis

   FROM dbp_view.v_geku_kundenbarometer;