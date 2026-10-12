-- 12.10.2022 twie: SPEC0167837 sek_kz von 1 auf 3 geändert

-- 21.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter

-- 31.08.2017 twie: SPEC0025359 mandant_id_wup als mandant_id, es gibt nur noch ein Landattr. in KMR

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_f_geku_kundenbarometer (geku_ticket_id_kundenbarometer, dat, wup_id, nb_id,
mandant_id, kdc_fg, mzk_fg, wmd_fg, sec_kz, note_auswahl, note_frische, note_qualitaet, note_beratung,
note_freundlichkeit_allg, note_freundlichkeit_theke, note_freundlichkeit_kasse, note_schnelligkeit_kasse,
note_schnelligkeit_theke, note_preis) AS SELECT geku_ticket_id_kundenbarometer,
 dat,
 wup_id,
 nb_id,
 mandant_id_wup AS mandant_id,
 1 AS kdc_fg,
 0 AS mzk_fg,
 0 AS wmd_fg,
 3 AS sec_kz,
 note_auswahl,
 note_frische,
 note_qualitaet,
 note_beratung,
 note_freundlichkeit_allg,
 note_freundlichkeit_theke,
 note_freundlichkeit_kasse,
 note_schnelligkeit_kasse,
 note_schnelligkeit_theke,
 note_preis
FROM kfl_production_dbp_view.v_geku_kundenbarometer;