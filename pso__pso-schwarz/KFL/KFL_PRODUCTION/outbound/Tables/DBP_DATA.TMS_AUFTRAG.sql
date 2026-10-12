--==============================================================
-- Table: tms_auftrag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag
   generated from Powerdesigner on Donnerstag, 24. April 2025 10:38:45
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_auftrag (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_auftrag_id STRING(30) NOT NULL OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plau.au_nr'),
tms_auftrag_unter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr'),
tms_auftrag_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_auftrag im Quellsystem. Aus plau.id_auftrag'),
lief_beleg_id BIGNUMERIC(38,0) OPTIONS(description='die Beleg ID des Lieferscheins'),
kj_lief_beleg BIGNUMERIC(38,0)
OPTIONS(description='Kalenderjahr aus LFDAT. Lookup in besch_lief, -1 für keinen Treffer'),
versandstelle_id STRING(4) OPTIONS(description='Versandstelle'),
tms_sortiment_id BIGNUMERIC(38,0) OPTIONS(description='Artikelsortiment. IDs weichen teilw. von SAP ab!'),
lieferkunde_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Lieferkunde auftrifft'),
lieferkunde_tms_gp_typ_cd STRING(3)
OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Lieferkunde auftrifft'),
auftragstext_1 STRING(100) OPTIONS(description='Auftragstext, der kundenspezifisch verwendet wird'),
auftragstext_2 STRING(100) OPTIONS(description='Auftragstext, der kundenspezifisch verwendet wird'),
auftragstext_3 STRING(100) OPTIONS(description='Auftragstext, der kundenspezifisch verwendet wird'),
tms_auftragsart_id BIGNUMERIC(38,0) OPTIONS(description='Art des Auftrags'),
beladestelle_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Beladestelle auftrifft'),
beladestelle_tms_gp_typ_cd STRING(3)
OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Beladestelle auftrifft'),
dat_best DATE OPTIONS(description='Bestelldatum'),
empfaenger_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Empfänger auftrifft'),
empfaenger_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Empfänger auftrifft'),
entladestelle_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Entladestelle auftrifft'),
entladestelle_tms_gp_typ_cd STRING(3)
OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Entladestelle auftrifft'),
quellsystem_name STRING(20) OPTIONS(description='Datenherkunft aus der Schnittstelle (z. B. EWM, LES)'),
liefergebiet_txt STRING(10)
OPTIONS(description='Liefergebiet (Geographisch lassen sich Kunden in Gebiete ähnlich Postleitzahlengebieten einteilen)'),
tms_land_cd STRING(5) OPTIONS(description='Länderkennzeichen des Lieferkunden'),
tms_lieferart_id STRING(3) OPTIONS(description='Art der Lieferung; 0 = Normal, 1 = via CD, 2 = ???'),
dat_lief DATE OPTIONS(description='Lieferdatum'),
plan_status_cd STRING(3) OPTIONS(description='Planungsstatus (z.B.\'H\' für hochgesetzt,\'T\' auf Tour)'),
sender_name STRING(12) OPTIONS(description='Versender (kein TMS-GP sondern z. B. ERP)'),
tms_tour_id BIGNUMERIC(38,0) OPTIONS(description='Tournummer'),
dat_tour DATE OPTIONS(description='Tourdatum'),
tms_tour_pos_id BIGNUMERIC(38,0)
OPTIONS(description='Entladetourposition, gibt die Reihenfolge an in der z. B. die Märkte angefahren werden sollen'),
versender_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp, welcher hier als Versender auftrifft'),
versender_tms_gp_typ_cd STRING(3) OPTIONS(description='Code für den tms_gp-Typ, welcher hier als Versender auftrifft'),
temperaturgruppe_id BIGNUMERIC(38,0)
OPTIONS(description='Temperaturgruppe des Auftrags.  0 = Nicht gesetzt, 1 = TK (Tiefgekühlt), 2 = GK (Gekühlt), 3 = TE (Temperiert), 4 = UK (Ungekühlt), 5 = TB (Thermobehälter)'),
gewicht_brutto_kg BIGNUMERIC(38,2) OPTIONS(description='Manuell erfasstes Frachtgewicht.'),
gewicht_netto_kg BIGNUMERIC(38,2) OPTIONS(description='Gesamt Gewicht des Auftrags.'),
anz_stellplatz BIGNUMERIC(38,2) OPTIONS(description='Stücke / Einheiten an Stellplätzen des gesamten Auftrags.'),
vorholspedition_tms_gp_id STRING(30)
OPTIONS(description='Geschäftspartner ID der Vorholspedition. Die Vorholspedition sammelt alles von den Beladestellen ein, ggf. an unterschiedlichen Adressen.'),
vorholspedition_tms_gp_typ_cd STRING(3) OPTIONS(description='Art der Vorholspedition.'),
tms_auftrag_orig_id STRING(30)
OPTIONS(description='Original Auftragsnummer inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.'),
best_beleg_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Bestellbelegs, bezieht sich auf in Wanko angelegte Aufträge.'),
tms_auftrag_status_cd STRING(20)
OPTIONS(description='Status der Auftragshostkommunikation: 10 = offen; 20 = in Bearbeitung; 30 = disponierbar; 40 = disponiert; 50 = avisiert; 60 = teilweise geliefert; 70 = geliefert; 99 = gelöscht.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_unter_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die relevanten Informationen zu einem Distributionsauftrag, einschließlich Auftragsart, Lieferdatum, Lieferkunde, entsprechende TMS-Tour-Detail-Bezeichnung und beteiligte Geschäftspartner. Aus Quelle plau (WANKO)');