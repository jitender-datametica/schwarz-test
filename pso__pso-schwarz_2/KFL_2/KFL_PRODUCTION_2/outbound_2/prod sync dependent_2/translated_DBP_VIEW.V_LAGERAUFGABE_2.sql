CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lageraufgabe_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id OPTIONS(description='Lagernummer/Lagerkomplex'), lageraufgabe_id OPTIONS(description='Lageraufgabe_2'),
lageraufgabe_pos_id OPTIONS(description='Lageraufgabenposition'), hu_lageraufgabe_fg
OPTIONS(description='Handling-Unit_2-Lageraufgabe_2'), lagerprozessart_id OPTIONS(description='Lagerprozessart'),
lagerprozesstyp_id OPTIONS(description='Lagerprozesstyp'), lagerprozess_id OPTIONS(description='Lagerungsprozess'),
lagerprozess_extern_id OPTIONS(description='Externer Lagerungsprozessschritt'), status_id
OPTIONS(description='Lageraufgabenstatus'), ersteller_id OPTIONS(description='Ersteller'), datzeit_erstellung
OPTIONS(description='Erstellungszeitpunkt'), wt_code
OPTIONS(description='Aufrufende Applikation/Spezielle Fkt. f. LB-Erzeug./-Konfig.'), ressource_id
OPTIONS(description='Ausführende Ressource (Transportmittel oder Benutzer)'), lager_bewgrund_id
OPTIONS(description='Grund für Bewegungen im Lager'), prio OPTIONS(description='Priorität'), bestand_guid
OPTIONS(description='GUID Bestandsposition'), bestand_idx OPTIONS(description='Laufende Nummer der Schlüsseltabelle'),
art_guid OPTIONS(description='Product'), charge_guid OPTIONS(description='Charge'), bestandsart_id
OPTIONS(description='Bestandsart'), bestand_belegtyp_id
OPTIONS(description='Typ: Kundenauftragsbestand oder Projektbestand'), bestand_beleg_id
OPTIONS(description='Nummer des Kundenauftrags bzw. Projekts für Sonderbestand'), bestand_beleg_pos_id
OPTIONS(description='Kundenauftragsposition für Kundenauftragsbestand'), belegtyp_id
OPTIONS(description='Belegtyp für Belegreferenz_2 und belegbezogene Bestände'), bestandsverwendung_id
OPTIONS(description='Bestandsverwendung'), eigentuemer_id OPTIONS(description='Owner (gp_id)'), eigentuemer_rolle_id
OPTIONS(description='Partner-Rolle des Eigentümers'), verf_berechtigter_id
OPTIONS(description='Verfügungsberechtigter (gp_id)'), verf_berechtigter_rolle_id
OPTIONS(description='Partner-Rolle des Verfügungsberechtigten'), bestand_lfd_nr
OPTIONS(description='Zähler für Bestandstrennung'), charge_id OPTIONS(description='Charge'), menge_einh_id
OPTIONS(description='Basismengeneinheit'), altnv_menge_einh_id
OPTIONS(description='Alternativmengeneinheit zur Lagermengeneinheit'), menge_soll_bme
OPTIONS(description='Sollmenge in Basismengeneinheit'), menge_soll_ame
OPTIONS(description='Sollmenge in alternativer Mengeneinheit'), vorhaltemenge OPTIONS(description='Vorhaltemenge'),
le_typ_id OPTIONS(description='Handling-Unit_2-Typ'), gewicht_netto OPTIONS(description='Ladungs- / Nettogewicht'),
gew_einh_id OPTIONS(description='Gewichtseinheit'), volumen OPTIONS(description='Ladungs- oder Nettovolumen'),
vol_einh_id OPTIONS(description='Volumeneinheit'), kapa_verbrauch OPTIONS(description='Kapazitätsverbrauch'),
einlager_inv_plan_fg OPTIONS(description='Einlagerinventur geplant'), niederbest_inv_plan_fg
OPTIONS(description='Niederbestandskontrolle geplant'), dat_mhd
OPTIONS(description='Best-Before Date / Shelf Life Expiration Date'), datzeit_we
OPTIONS(description='Datum und Uhrzeit des Wareneingangs'), land_herkunft OPTIONS(description='Herkunftsland'),
gefahrstoff_fg OPTIONS(description='Gefahrstoff'), pruef_typ_id OPTIONS(description='Inspection Type'), pruefung_id
OPTIONS(description='Identifikation eines Qualitätsobjektes'), bestand_id
OPTIONS(description='Bestandsidentifikation der Lageraufgabe_2'), konsolidierungsgruppe_id
OPTIONS(description='Consolidation Group'), lagertyp_id_von OPTIONS(description='Von-Lagertyp'), lagerbereich_id_von
OPTIONS(description='Vonlagerbereich'), lagerplatz_id_von OPTIONS(description='Vonlagerplatz'), pos_hu_lagerplatz_von
OPTIONS(description='Logische Von-Position der Handling Unit_2 im Lagerplatz'), ressource_id_von
OPTIONS(description='Von-Ressource (Transportmittel oder Benutzer)'), transporteinheit_id_von
OPTIONS(description='Von-Transporteinheit (intern)'), lokationstyp_id_von OPTIONS(description='Lokationstyp'),
handling_unit_guid_von OPTIONS(description='eindeutige interne Identifikation einer Handling Unit_2'),
handling_unit_id_von OPTIONS(description='Von-Handling-Unit_2'), lagertyp_id_nach OPTIONS(description='Nach-Lagertyp'),
lagerbereich_id_nach OPTIONS(description='Nachlagerbereich'), lagerplatz_id_nach OPTIONS(description='Nachlagerplatz'),
pos_hu_lagerplatz_nach OPTIONS(description='Logische Nach-Position der Handling Unit_2 im Lagerplatz'),
transportgeraet_pos_id OPTIONS(description='Transportgerätposition (Lageraufgabe_2)'), ressource_id_nach
OPTIONS(description='Nach-Ressource (Transportmittel oder Benutzer)'), transporteinheit_id_nach
OPTIONS(description='Nach-Transporteinheit (intern)'), lokationstyp_id_nach OPTIONS(description='Lokationstyp'),
handling_unit_guid_nach OPTIONS(description='eindeutige interne Identifikation einer Handling Unit_2'),
handling_unit_id_nach OPTIONS(description='Nach-Handling-Unit_2'), nachplatz_ermittelt_durch
OPTIONS(description='Nachplatz wurde ermittelt durch'), lageraufgabe_an_subsys_fg
OPTIONS(description='Kennzeichen: Lageraufgabe_2 an SUB-System übergeben'), sollaufwand
OPTIONS(description='Sollaufwand in Lageraufgabe_2'), zeit_einh_id OPTIONS(description='Zeiteinheit'), vas_id
OPTIONS(description='LB mit Bezug zu einem LZL'), charge_keine_aend_fg
OPTIONS(description='Ändern der Charge ist nicht erlaubt'), ref_belegtyp_id
OPTIONS(description='Belegtyp für Belegreferenz_2 und belegbezogene Bestände'), ref_beleg_guid
OPTIONS(description='Belegidentifikation für Belegbezogene Bestände'), ref_beleg_pos_guid
OPTIONS(description='Belegposition für belegbezogene Bestände'), welle_id
OPTIONS(description='Welle. Logical grouping of tasks (lageraufgabe_2) that are performed together (in one wave)'),
welle_pos_id OPTIONS(description='Wellenposition'), lbart_2lk_id
OPTIONS(description='LB-Art_2 innerhalb der zweistufigen Kommissionierung'), relevanz_2lk_fg
OPTIONS(description='Relevanz für zweistufige Kommissionierung'), quitt_belegtyp_id
OPTIONS(description='Belegtyp für Belegreferenz_2 und belegbezogene Bestände'), quitt_beleg_guid
OPTIONS(description='Belegidentifikation für Belegbezogene Bestände'), quitt_beleg_pos_guid
OPTIONS(description='Belegposition für belegbezogene Bestände'), quitt_bestand_id
OPTIONS(description='Identifikationsnummer des Bestandes'), kit_fg
OPTIONS(description='Bausatzpos. in HU während d. Kommissionieren automat. erz.'), lageraufgabe_guid
OPTIONS(description='Eindeutige interne Identifikation einer Lageraufgabe_2'), dokumentationscharge_id
OPTIONS(description='Gibt Dokumentationscharge an'), mfs_segment_id OPTIONS(description='Fördertechniksegment'), psa_id
OPTIONS(description='Produktionsversorgungsbereich'), prod_auftrag_id OPTIONS(description='Produktionsauftrag'),
datzeit_erstellung_utc OPTIONS(description='Erstellungszeit in Lagerzeitzone'), datzeit_aenderung_utc
OPTIONS(description='Änderungszeit in Lagerzeitzone'), kanban_id OPTIONS(description='Eindeutige ID eines Kanban'),
bestand_menge_einh_id OPTIONS(description='Alternativmengeneinheit zur Lagermengeneinheit'), aktivitaetsbereich_id
OPTIONS(description='Aktivitätsbereich'), queue_id OPTIONS(description='Queue'), lagerauftrag_id
OPTIONS(description='Lagerauftragsnummer'), zeugnis_nr OPTIONS(description='Zeugnisnummer'), empfaenger_id
OPTIONS(description='Geschäftspartnernummer'), transporteinheit_id OPTIONS(description='Transporteinheit'),
sec_aktivitaetsbereich_id OPTIONS(description='Aktivitätsbereich SEC'), seq_aktivitaetsbereich_id
OPTIONS(description='Aktivitätsbereich SEQ'), seq_bin_srt_id OPTIONS(description='Bin SRT'), aufpack_fg
OPTIONS(description='Kennzeichen für Aufpack-Prozess'), abpack_fg OPTIONS(description='Kennzeichen für Abpack-Prozess'),
handling_unit_id_von_bulk OPTIONS(description='Von-Handling-Unit_2'), handling_unit_id_nach_packoff
OPTIONS(description='Nach-Handling-Unit_2'), menge_umpacken OPTIONS(description='Menge umpacken'), datzeit_aenderung
OPTIONS(description='Änderungszeitpunkt'), lagerbew_beleg_id OPTIONS(description='Nummer des Materialbelegs'),
lagerbew_beleg_pos_id OPTIONS(description='Materialbelegjahr'), lagerbew_beleg_zeile
OPTIONS(description='Position im Materialbeleg'), lagerbew_beleg_uid
OPTIONS(description='Eindeutige Identifikationsnummer der Belegzeile'), user_quittierung
OPTIONS(description='Quittiert von'), datzeit_quittierung OPTIONS(description='Quittierungsszeitpunkt'),
ausfuehrender_id OPTIONS(description='Ausführender'), ausnahme_code OPTIONS(description='Ausnahme_2-Code'), bus_kontext
OPTIONS(description='Business Kontext'), ausfuehr_schritt_id
OPTIONS(description='Ausführungsschritt im Business-Kontext'), datzeit_start OPTIONS(description='Startzeitpunkt'),
menge_ist_bme OPTIONS(description='Istmenge in Basismengeneinheit'), menge_ist_ame
OPTIONS(description='Istmenge in alternativer Mengeneinheit'), einlager_inv_fg
OPTIONS(description='Einlagerinventur durchgeführt'), niederbest_inv_fg
OPTIONS(description='Niederbestandskontrolle durchgeführt'), hu_entnahme_kompl_fg
OPTIONS(description='Kennzeichen: Handling Unit_2 wird komplett entnommen'), lagerbew_beleg_id_storniert
OPTIONS(description='Stornierter Lagerbeleg'), lgnum_view_von
OPTIONS(description='Lagernummersicht für globale Bestände'), lgnum_view_nach
OPTIONS(description='Lagernummersicht für globale Bestände'), menge_diff_lme
OPTIONS(description='Menge der Differenzenbuchung in Lagermengeneinheit'), menge_diff_ame
OPTIONS(description='Menge der Differenzenbuchung in alternativer Mengeneinheit'), ref_pos_lageraufgabe
OPTIONS(description='Referenzposition der Lageraufgabe_2'), extref_belegtyp_id
OPTIONS(description='Belegtyp für externe Belegreferenz_2'), extref_beleg_id
OPTIONS(description='Belegnummer für externe Belegreferenz_2'), extref_beleg_pos_id
OPTIONS(description='Belegposition für externe Belegreferenz_2'), extref_logsys_id
OPTIONS(description='Logisches System für externe Belegreferenz_2'), menge_bewertung
OPTIONS(description='Bewertungsmenge'), bew_menge_einh_id OPTIONS(description='Einheit für Bewertungsmenge'),
bew_status_id OPTIONS(description='Status_2 der Bewertungsmenge'), menge_bewertung_diff
OPTIONS(description='Bewertungsmenge'), bew_diff_status_id OPTIONS(description='Status_2 der Bewertungsmenge'),
kombination_gruppe_id OPTIONS(description='Kombination Gruppe_2'), bewegungsgrund_id
OPTIONS(description='Grund der Bewegung'), status_sync_erp
OPTIONS(description='Kommunikation der Warenbewegung nach ERP'), lagerort_id OPTIONS(description='Lagerort'),
datzeit_bestaetigung OPTIONS(description='Bestätigungszeit in Lagerzeitzone'), zeilenindex
OPTIONS(description='Zeilenindex intern'), menge_kolli OPTIONS(description='Kollimenge'), datzeit_start_max
OPTIONS(description='Spätester Starttermin (SST)      '), ewm_gv_grp_id
OPTIONS(description='Gruppe_2 des Geschäftsvorfalls '), ewm_gv_id OPTIONS(description='Geschäftsvorfallnummer'),
gv_menge_bewegt OPTIONS(description='Geschäftsvorfall bewegte Menge  '), werbeware_id
OPTIONS(description='Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'), lief_pal_typ_id
OPTIONS(description='Palettentyp der Lieferung '), gangwechselaufschlag OPTIONS(description='Gangwechselaufschlag'),
entfernungsaufschlag OPTIONS(description='Entfernungsaufschlag'), hoehenaufschlag OPTIONS(description='Höhenaufschlag '),
transportation_unit_id OPTIONS(description='Transporteinheit '), pack_on_gk_fg
OPTIONS(description='Flag Pack on Gondelkopf'), aufschlag_lagerplatztyp OPTIONS(description='Aufschlag Lagerplatztyp'),
distanz_reserve_fixplatz OPTIONS(description='TDC Reserve zu Fixplatz'), distanz_bsf_reserve
OPTIONS(description='TDC BSF zu Reserve'), distanz_hoehe OPTIONS(description='TDC Höhenaufschlag'), ewm_exc_kategorie_id
OPTIONS(description='Exception Code category'), dat_bereitstellung OPTIONS(description='Bereitstelldatum'),
zeit_bereitstellung OPTIONS(description='Bereitstelllzeit'), datzeit_bereitstellung
OPTIONS(description='Bereitstelllzeitstempel')) AS SELECT mandant_id,
 lagernummer_id,
 lageraufgabe_id,
 lageraufgabe_pos_id,
 hu_lageraufgabe_fg,
 lagerprozessart_id,
 lagerprozesstyp_id,
 lagerprozess_id,
 lagerprozess_extern_id,
 status_id,
 ersteller_id,
 datzeit_erstellung,
 wt_code,
 ressource_id,
 lager_bewgrund_id,
 prio,
 bestand_guid,
 bestand_idx,
 art_guid,
 charge_guid,
 bestandsart_id,
 bestand_belegtyp_id,
 bestand_beleg_id,
 bestand_beleg_pos_id,
 belegtyp_id,
 bestandsverwendung_id,
 eigentuemer_id,
 eigentuemer_rolle_id,
 verf_berechtigter_id,
 verf_berechtigter_rolle_id,
 bestand_lfd_nr,
 charge_id,
 menge_einh_id,
 altnv_menge_einh_id,
 menge_soll_bme,
 menge_soll_ame,
 vorhaltemenge,
 le_typ_id,
 gewicht_netto,
 gew_einh_id,
 volumen,
 vol_einh_id,
 kapa_verbrauch,
 einlager_inv_plan_fg,
 niederbest_inv_plan_fg,
 dat_mhd,
 datzeit_we,
 land_herkunft,
 gefahrstoff_fg,
 pruef_typ_id,
 pruefung_id,
 bestand_id,
 konsolidierungsgruppe_id,
 lagertyp_id_von,
 lagerbereich_id_von,
 lagerplatz_id_von,
 pos_hu_lagerplatz_von,
 ressource_id_von,
 transporteinheit_id_von,
 lokationstyp_id_von,
 handling_unit_guid_von,
 handling_unit_id_von,
 lagertyp_id_nach,
 lagerbereich_id_nach,
 lagerplatz_id_nach,
 pos_hu_lagerplatz_nach,
 transportgeraet_pos_id,
 ressource_id_nach,
 transporteinheit_id_nach,
 lokationstyp_id_nach,
 handling_unit_guid_nach,
 handling_unit_id_nach,
 nachplatz_ermittelt_durch,
 lageraufgabe_an_subsys_fg,
 sollaufwand,
 zeit_einh_id,
 vas_id,
 charge_keine_aend_fg,
 ref_belegtyp_id,
 ref_beleg_guid,
 ref_beleg_pos_guid,
 welle_id,
 welle_pos_id,
 lbart_2lk_id,
 relevanz_2lk_fg,
 quitt_belegtyp_id,
 quitt_beleg_guid,
 quitt_beleg_pos_guid,
 quitt_bestand_id,
 kit_fg,
 lageraufgabe_guid,
 dokumentationscharge_id,
 mfs_segment_id,
 psa_id,
 prod_auftrag_id,
 datzeit_erstellung_utc,
 datzeit_aenderung_utc,
 kanban_id,
 bestand_menge_einh_id,
 aktivitaetsbereich_id,
 queue_id,
 lagerauftrag_id,
 zeugnis_nr,
 empfaenger_id,
 transporteinheit_id,
 sec_aktivitaetsbereich_id,
 seq_aktivitaetsbereich_id,
 seq_bin_srt_id,
 aufpack_fg,
 abpack_fg,
 handling_unit_id_von_bulk,
 handling_unit_id_nach_packoff,
 menge_umpacken,
 datzeit_aenderung,
 lagerbew_beleg_id,
 lagerbew_beleg_pos_id,
 lagerbew_beleg_zeile,
 lagerbew_beleg_uid,
 user_quittierung,
 datzeit_quittierung,
 ausfuehrender_id,
 ausnahme_code,
 bus_kontext,
 ausfuehr_schritt_id,
 datzeit_start,
 menge_ist_bme,
 menge_ist_ame,
 einlager_inv_fg,
 niederbest_inv_fg,
 hu_entnahme_kompl_fg,
 lagerbew_beleg_id_storniert,
 lgnum_view_von,
 lgnum_view_nach,
 menge_diff_lme,
 menge_diff_ame,
 ref_pos_lageraufgabe,
 extref_belegtyp_id,
 extref_beleg_id,
 extref_beleg_pos_id,
 extref_logsys_id,
 menge_bewertung,
 bew_menge_einh_id,
 bew_status_id,
 menge_bewertung_diff,
 bew_diff_status_id,
 kombination_gruppe_id,
 bewegungsgrund_id,
 status_sync_erp,
 lagerort_id,
 datzeit_bestaetigung,
 zeilenindex,
 menge_kolli,
 datzeit_start_max,
 ewm_gv_grp_id,
 ewm_gv_id,
 gv_menge_bewegt,
 werbeware_id,
 lief_pal_typ_id,
 gangwechselaufschlag,
 entfernungsaufschlag,
 hoehenaufschlag,
 transportation_unit_id,
 pack_on_gk_fg,
 aufschlag_lagerplatztyp,
 distanz_reserve_fixplatz,
 distanz_bsf_reserve,
 distanz_hoehe,
 ewm_exc_kategorie_id,
 dat_bereitstellung,
 zeit_bereitstellung,
 datzeit_bereitstellung
FROM kfl_production_dbp_data.lageraufgabe_2;