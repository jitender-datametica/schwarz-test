CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_auftrag_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_auftrag_id
OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plau.au_nr'), tms_auftrag_unter_id
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr'),
tms_auftrag_lfd_nr OPTIONS(description='SKey für die Tabelle tms_auftrag_2 im Quellsystem. Aus plau.id_auftrag'),
lief_beleg_id OPTIONS(description='die Beleg ID des Lieferscheins'), kj_lief_beleg
OPTIONS(description='Kalenderjahr aus LFDAT. Lookup in besch_lief_2, -1 für keinen Treffer'), versandstelle_id
OPTIONS(description='Versandstelle'), tms_sortiment_id
OPTIONS(description='Artikelsortiment. IDs weichen teilw. von SAP ab!'), lieferkunde_tms_gp_id
OPTIONS(description='ID des tms_gp_2, welcher hier als Lieferkunde auftrifft'), lieferkunde_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Lieferkunde auftrifft'), auftragstext_1
OPTIONS(description='Auftragstext, der kundenspezifisch verwendet wird'), auftragstext_2
OPTIONS(description='Auftragstext, der kundenspezifisch verwendet wird'), auftragstext_3
OPTIONS(description='Auftragstext, der kundenspezifisch verwendet wird'), tms_auftragsart_id
OPTIONS(description='Art_2 des Auftrags'), beladestelle_tms_gp_id
OPTIONS(description='ID des tms_gp_2, welcher hier als Beladestelle auftrifft'), beladestelle_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Beladestelle auftrifft'), dat_best
OPTIONS(description='Bestelldatum'), empfaenger_tms_gp_id
OPTIONS(description='ID des tms_gp_2, welcher hier als Empfänger auftrifft'), empfaenger_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Empfänger auftrifft'), entladestelle_tms_gp_id
OPTIONS(description='ID des tms_gp_2, welcher hier als Entladestelle auftrifft'), entladestelle_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Entladestelle auftrifft'), quellsystem_name
OPTIONS(description='Datenherkunft aus der Schnittstelle (z. B. EWM, LES)'), liefergebiet_txt
OPTIONS(description='Liefergebiet (Geographisch lassen sich Kunden in Gebiete ähnlich Postleitzahlengebieten einteilen)'),
tms_land_cd OPTIONS(description='Länderkennzeichen des Lieferkunden'), tms_lieferart_id
OPTIONS(description='Art_2 der Lieferung; 0 = Normal, 1 = via CD, 2 = ???'), dat_lief OPTIONS(description='Lieferdatum'),
plan_status_cd OPTIONS(description='Planungsstatus (z.B.\'H\' für hochgesetzt,\'T\' auf Tour_2)'), sender_name
OPTIONS(description='Versender (kein TMS-GP_2 sondern z. B. ERP)'), tms_tour_id OPTIONS(description='Tournummer'),
dat_tour OPTIONS(description='Tourdatum'), tms_tour_pos_id
OPTIONS(description='Entladetourposition, gibt die Reihenfolge an in der z. B. die Märkte angefahren werden sollen'),
versender_tms_gp_id OPTIONS(description='ID des tms_gp_2, welcher hier als Versender auftrifft'), versender_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Versender auftrifft'), temperaturgruppe_id
OPTIONS(description='Temperaturgruppe des Auftrags.  0 = Nicht gesetzt, 1 = TK (Tiefgekühlt), 2 = GK (Gekühlt), 3 = TE (Temperiert), 4 = UK (Ungekühlt), 5 = TB (Thermobehälter)'),
gewicht_brutto_kg OPTIONS(description='Manuell erfasstes Frachtgewicht.'), gewicht_netto_kg
OPTIONS(description='Gesamt Gewicht des Auftrags.'), anz_stellplatz
OPTIONS(description='Stücke / Einheiten an Stellplätzen des gesamten Auftrags.'), vorholspedition_tms_gp_id
OPTIONS(description='Geschäftspartner ID der Vorholspedition. Die Vorholspedition sammelt alles von den Beladestellen ein, ggf. an unterschiedlichen Adressen.'),
vorholspedition_tms_gp_typ_cd OPTIONS(description='Art_2 der Vorholspedition.'), tms_auftrag_orig_id
OPTIONS(description='Original Auftragsnummer inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.'),
best_beleg_id OPTIONS(description='ID des Bestellbelegs, bezieht sich auf in Wanko angelegte Aufträge.'),
tms_auftrag_status_cd
OPTIONS(description='Status_2 der Auftragshostkommunikation: 10 = offen; 20 = in Bearbeitung; 30 = disponierbar; 40 = disponiert; 50 = avisiert; 60 = teilweise geliefert; 70 = geliefert; 99 = gelöscht.'))
AS SELECT mandant_id,
 system_id,
 tms_auftrag_id,
 tms_auftrag_unter_id,
 tms_auftrag_lfd_nr,
 lief_beleg_id,
 kj_lief_beleg,
 versandstelle_id,
 tms_sortiment_id,
 lieferkunde_tms_gp_id,
 lieferkunde_tms_gp_typ_cd,
 auftragstext_1,
 auftragstext_2,
 auftragstext_3,
 tms_auftragsart_id,
 beladestelle_tms_gp_id,
 beladestelle_tms_gp_typ_cd,
 dat_best,
 empfaenger_tms_gp_id,
 empfaenger_tms_gp_typ_cd,
 entladestelle_tms_gp_id,
 entladestelle_tms_gp_typ_cd,
 quellsystem_name,
 liefergebiet_txt,
 tms_land_cd,
 tms_lieferart_id,
 dat_lief,
 plan_status_cd,
 sender_name,
 tms_tour_id,
 dat_tour,
 tms_tour_pos_id,
 versender_tms_gp_id,
 versender_tms_gp_typ_cd,
 temperaturgruppe_id,
 gewicht_brutto_kg,
 gewicht_netto_kg,
 anz_stellplatz,
 vorholspedition_tms_gp_id,
 vorholspedition_tms_gp_typ_cd,
 tms_auftrag_orig_id,
 best_beleg_id,
 tms_auftrag_status_cd
FROM kfl_production_dbp_data.tms_auftrag_2;