CREATE OR REPLACE VIEW kfl_production_dbp_view.v_best_belegfluss_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
best_beleg_pos_id
OPTIONS(description='Das Feld enthält die Nummer einer Bestellbelegposition und dient zusammen mit der Bestellbeleg ID der eindeutigen Identifikation der Bestellbelegpositionen. Aus ebelp'),
best_beleg_id
OPTIONS(description='Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege. Aus ebeln'),
kontierung_pos_id
OPTIONS(description='Laufende Nummer der Kontierung: Nummer, die die Kontierung einer Bestellposition eindeutig definiert. aus zekkn'),
vorgart_best_entw_id
OPTIONS(description='Vorgangsart der Bestellentwicklung. Referenziert die Tabelle l_vorgart_best_entw.Aus vgabe'),
folge_beleg_id
OPTIONS(description='Belegnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann  Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus belnr '),
folge_beleg_pos_id
OPTIONS(description='Positionsnummer des Folgebeleges: wenn best_entw_typ_id = E (WE) oder U (WA) dann Referenz zu der Lagerbewegung, wenn best_entw_typ_id = L dann Referenz zu dem Lieferschein. Aus buzei'),
kj
OPTIONS(description='Dieses Attribut enthält das entsprechende Kalenderjahr und wird benötigt um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren. Aus gjahr '),
wup_id
OPTIONS(description='Die Wup_id entspricht der Nummer des Werks/Betriebs. Dabei kann es sich entweder um ein Verteilzentrum, ein Lager oder einen Markt handeln. Zusammen mit der nb_id kann ein Eintrag aus der DWH Tabelle wup_2 eindeutig identifiziert werden. Quelle ist werks'),
nb_id
OPTIONS(description='Die nb_id identifiziert die Nebenbetriebe (z.B. Tankstelle, Backshop, usw.) für einen Betrieb/Werk (= wup_id).'),
bestaetigung_lfd_nr OPTIONS(description='Laufende Nummer der Bestätigung. Referenz zu der Bestätigung. Aus etens'),
best_entw_typ_id
OPTIONS(description='Kennzeichen über die Art_2 des Folgebeleges aus bewtp:  E = Wareneingang, Lagerbewegung, U = Warenausgang, Lagerbewegung, L = Lieferschein'),
menge_anteil
OPTIONS(description='Mengenanteil der Gesamtbestellmenge, den Sie dieser Kontierungsposition zuordnen möchten. Aus bamng  Die eingegebene Menge bestimmt, welchen Anteil der Kosten Sie auf diese Kontierungsposition verteilen möchten. Aus bamng'),
menge_best OPTIONS(description='Menge in Bestellpreismengeneinheit aus bpmng  '), lager_bewart_id
OPTIONS(description='Schlüssel der Bewegungsarten der Lagerbewegung aus bwart.'), dat_buch
OPTIONS(description='Buchungsdatum des Beleges aus budat'), menge_basis
OPTIONS(description='Menge in Basismeingeneinheit aus menge'), betrag_ek_netto
OPTIONS(description='Mit dem ek_netto (Rechnungs-Einkaufspreis) bewertete Warenmenge: menge_basis * ek_netto (Quelle: dmbtr).'),
wrg_id OPTIONS(description='Hauswährung. Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Aus hswae'), soll_haben_kz
OPTIONS(description='Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt. Aus shkzg'),
ref_beleg_id OPTIONS(description='Belegnummer des Referenzbeleges aus lfbnr'), ref_beleg_pos_id
OPTIONS(description='Position des Referenzbeleges aus lfpos'), ref_gj
OPTIONS(description='Geschäftsjahr des Referenzbeleges aus lfgja.'), system_id
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'), betrag_wrbtr
OPTIONS(description='Betrag in Belegwährung aus wrbtr. Muss unbedingt 1:1 aus SAP kommen, um Kursdifferenzen zum GLD auszuwerten'),
wrg_id_beleg
OPTIONS(description='Belegwährung - Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Referenz zur Tabelle wrg. Aus waers'),
endlief_fg
OPTIONS(description='Flag gibt an, ob die Bestellposition als endgeliefert gilt (Endlieferungskennzeichen). Quelle EKBE.ELIKZ.'),
dat_erfassung
OPTIONS(description='Systemdatum, an dem der Buchhaltungs- bzw. Warenbewegungsbeleg physisch im System erfasst wurde (Datum der Dateneingabe). Quelle EKBE.CPUDT. Da Buchungen rückwirkend (retroaktiv) durchgeführt werden können, kann das Erfassungsdatum sich vom fachlichen Beleg- oder Buchungsdatum(dat_buch) unterscheiden.'))
AS SELECT mandant_id,
 best_beleg_pos_id,
 best_beleg_id,
 kontierung_pos_id,
 vorgart_best_entw_id,
 folge_beleg_id,
 folge_beleg_pos_id,
 kj,
 wup_id,
 nb_id,
 bestaetigung_lfd_nr,
 best_entw_typ_id,
 menge_anteil,
 menge_best,
 lager_bewart_id,
 dat_buch,
 menge_basis,
 betrag_ek_netto,
 wrg_id,
 soll_haben_kz,
 ref_beleg_id,
 ref_beleg_pos_id,
 ref_gj,
 system_id,
 betrag_wrbtr,
 wrg_id_beleg,
 endlief_fg,
 dat_erfassung
FROM kfl_production_dbp_data.best_belegfluss_2;