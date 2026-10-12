CREATE OR REPLACE VIEW kfl_production_dbp_v_ods.v_ods_bon_kopf_1 (bon_id
OPTIONS(description='Eindeutige ID eines Bons, generierter Hashwert.'), bon_dat
OPTIONS(description='Checkoutdatum, auch Businessday bzw. Kassenkey.'), mandant_id
OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'), wup_id
OPTIONS(description='Marktnummer, wird nicht gegen den Marktstamm geprüft.'), kasse_typ_id
OPTIONS(description='Kassentyp. Folgende Typen kommen vor: 1 = default (Sales_1 POS), 2 = Info, 3 = Leergut (Empties), 4 = Server (Back-Office), 5 = Imbiss, 6 = Mobile, 7 = Emergency, 8 = SCO (SelfCheckOut),  -1 = unbekannt.'),
kundenkarte_typ_id OPTIONS(description='ID zum Kundenkartentyp mit Werten 0, 1, 2. '), bon_nr
OPTIONS(description='Die Bonnummer des Bons (ist eine_1 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_1 und Kasse unique).'),
kasse_nr OPTIONS(description='Nummer der Kasse.'), kassierer_nr OPTIONS(description='Nummer des Kassierers.'), kunde_fg
OPTIONS(description='Gibt an, ob dieser Bon für die Kundenzählung relevant ist. 1 = ja, 0 = nein.'), bon_beginn
OPTIONS(description='Start-Zeitpunkt des Bons.'), bon_ende OPTIONS(description='Ende-Zeitpunkt des Bons.'), umsatz_mwst
OPTIONS(description='Auf den Mehrwertsteueranteil entfallender Betrag.'), umsatz_brutto
OPTIONS(description='Umsatz Brutto Betrag.'), bon_booking
OPTIONS(description='Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war.'),
dat_booking
OPTIONS(description='Buchungsdatum des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war. Redundant zu bon_booking aus Performancegründen.'),
turnover_fg OPTIONS(description='Flag kennzeichnet die Umsatzrelevanz des Bons. 1 = relevant.'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'), reactivated_fg
OPTIONS(description='SPALTE WIRD NICHT BEFÜLLT / FUNKTIONIERT NICHT. Bons können zurückgestellt und später reaktiviert werden (= 1), wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im System und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
personal_id OPTIONS(description='Personalnummer (nur bei Personalrabatt) als Hashwert verfremdet (Compress).'),
betrag_personal_rabatt OPTIONS(description='Mitarbeiterrabatt als Geldbetrag.'), kpos_kasse_typ
OPTIONS(description='Im Kassensystem KPOS verwendete nicht-numerische Kassentypen.'), wagen_nr
OPTIONS(description='Nummer des Einkaufswagens.'), kundenkarte_id
OPTIONS(description='Beinhaltet die gehashte Kundennummer.'), druecken_summentaste
OPTIONS(description='Zeitstempel wird erzeugt wenn die Summentaste an der Kasse gedrückt wird; Zeitstempel wird nur einmalig erzeugt.'),
schliessen_kassenschublade
OPTIONS(description='Zeitstempel wird an der Kasse erzeugt, wenn die Kassenlade geschlossen wird.'), fiskalisierung_fg
OPTIONS(description='Kennzeichnung für einen Bon, ob dieser für Fiskalisierung relevant ist.'), bon_nr_fiscal
OPTIONS(description='In Kombination mit Kasse und Markt einmalig kombiniertes Feld (Fiscal invoice receipt).'),
alternative_karte_id
OPTIONS(description='Beinhaltet gehashte kundenkartennummer, außer KCARD ( Z.B:TCBO, Payback).Es können in einigen Ländern beide Kartentyp gleichzeitig, Kaufland Card und eine_1 andere, an der Kasse gezeigt werden, in welchem Fall dann die KL-Card Kundennummer in Spalte kundenkarte_id geschrieben wird und in dieser Spalte die Nummer der anderen Karte.'),
suspended_fg OPTIONS(description='Flag: Kennzeichnung des Suspended-Status_1 der Transaktion. 1 = suspended'),
suspended_bon_nr
OPTIONS(description='Bonnummer des zuvor zurückgestellten Bons. Ein reaktivierter Bon erhält eine_1 neue Bonnummer und mit dieser Spalte kann auf den vorher zurückgestellten Bon verwiesen werden.\nBons können zurückgestellt und später reaktiviert werden, wenn z.Bsp. der Kunde nicht gleich zahlen kann. Diese Bons verbleiben länger im Kassensystem und die Zeiten dürfen nicht in die Berechnungen eingehen.'),
online_fg
OPTIONS(description='Kennzeichnet einen Online Bon; Fg = 1 = Online Bon liegt vor; Fg = 0 = Offline Bon liegt vor. Sobald eine_1 Bonzeile ein Online-Verkauf ist, zählt der Bon als Online. Quelle Kassen XML aztec Code Stelle 2 E-Food / Offline mit umgekehrter Flag Logik.'),
online_transaktion_id
OPTIONS(description='Transaktionsnummer, einzigartig innerhalbt eines Bons. Tritt nur bei Online Bestellungen auf. Quelle: Kassen XML Aztec Code Stelle 5 TransactionID.'),
online_bestellung_nr
OPTIONS(description='Bestellnummer bei Online Bestellungen, alphanumerisch mit unterschiedlicher Länge. Quelle: Kassen XML Aztec Code Stelle 7 Ordernumber.'),
dienstleister_id
OPTIONS(description='Bei Online Bestellungen wird ein Dienstleister beauftragt die bestellte Ware zusammen zu stellen. ID kann 0 bis 9 annehmen. Siehe Lookup Tabelle l_dienstleister_1 und dienstleister_spr_zu. Quelle Kassen XML Aztec Code Stelle 4 VendorID.'),
geraet_id
OPTIONS(description='Gerätekennzeichnung mit dem die online bestellte Ware gescannt wurde. < 200 Waage; >200 und < 800 Geschenkkorb (MDE); > 800 MDE E-Food RO. Quelle Kassen XML Aztec Code Stelle 6 DeviceID.'),
bon_typ_id
OPTIONS(description='Kennzeichnet den Typ des Bons: 0 = rein gedruckter Bon; 1 = gedruckter Bon mit Sendung an Web Service; 2 = reiner Digitalbon. Quelle: Kassen XML digitalReceipt.'),
bon_gedruckt_fg
OPTIONS(description='Gibt an, ob der Bon ausgedruckt wurde. 1 = Bon ausgedruckt; 0 = Bon nicht ausgedruckt. Default = 1 (in ETL definiert). Quelle ./paperReceiptPrintout'),
bondruck_abgelehnt_fg
OPTIONS(description='Gibt an, ob der Kunde\""an der Kasse\"" auf Nachfrage den Bondruck abgelehnt hat. 1 = ja(abgelehnt); 0 = nein (nicht abgelehnt). Default = -1 (für Altdaten. in ETL definiert). Quelle ./customerSuppressedReceipt.\nIst beim Kunde im CRM / K Card\""kein Druck des Bons\"" hinterlegt hat, erhält diese Spalte trotzdem 0 (false). In diesem Fall wäre_1 sowohl bon_abgelehnt_fg, als auch bon_gedruckt_fg gleich 0. Bei Self Checkout Kassen gilt der Bondruck als automatisch abgelehnt, wenn der Kunde innerhalb von 5 Sekunden nicht den Audruck auswählt.'),
kundenkarte_status_bez
OPTIONS(description='Gibt den Status_1 der Kundenkarte an, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/state\nSUCCESSFUL -> Request & Response an CRM technisch erfolgreich, Karte ohne Fehler vom CRM gemeldet -> CRM Promotions angewendet/gegeben\nPENDING -> Randfall technisch: Request läuft jedoch keine Response bis zum Transaktions-Abschluss (oder Bon Abbruch cellation oder Hard-Reset) -> keine CRM Promotion angewendet\nINITIALIZED -> Randfall technisch: Request initialisiert aber Kasse wird während der Transaktion heruntergefahren oder Transaktion aus einem anderen Grund systemseitig automatisch abgebrochen -> keine CRM Promotion angewendet (ist ohnehin keine reguläre_1 SALES_1 Transaktion)\nFAILED -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird\nTIMEDOUT -> abhängig vom gemeldeten errorcode, ob CRM Promotion gewährt wird'),
kundenkarte_fehler_txt
OPTIONS(description='Errorcode der Kundenkarte, den die Kasse vom CRM in der Schnittstelle erhält. Quelle ../loyaltyCardPositions/errorcode\nERROR_ARVADO_INTERNAL (arvato state: true)                -> no CRM BBYs, only common BBYs\nERROR_ARVADO_UNSUPPORTED(arvato state: true)      -> no CRM BBYs, only common BBYs\nERROR_CARD_NOT_ACTIVATED(arvato state: true)          -> no CRM BBYs, only common BBYs\nERROR_CARD_UNKNOWN(arvato state: true)                    -> no CRM BBYs, only common BBYs\nERROR_INTERNAL(arvato state: false)                                    -> common BBYs + CRM customer BBYs granted\nERROR_INVALID_RESPONSE(arvato state: false)                -> common BBYs + CRM customer BBYs granted\nERROR_IO(arvato state: false)                                                   -> common BBYs + CRM customer BBYs granted\n\""NULL\""                                                                                                -> all promotions are granted'),
loyalty_berechtigt_fg
OPTIONS(description='Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ob eine_1 Promotion aufgrund der CRM-Karte gewährt wird, hängt sowohl vom kundenkarte_status_bez als auch vom kundenkarte_fehler_txt ab, den die Kasse vom CRM in der Schnittstelle erhält.'),
bon_id_orig OPTIONS(description='Bon-ID des Ursprungeinakufs bei Retouren.'), bon_dat_orig
OPTIONS(description='Datum des Ursprungseinkaufs bei Retouren.'), wup_id_orig
OPTIONS(description='Martknummer des Urpsrungeinkaufs bei Retouren.'), kasse_nr_orig
OPTIONS(description='Nummer der Kasse des Ursprungskauf bei Retouren.'), kundenkarte_programm_cd
OPTIONS(description='Gibt den Kundenbindungsprogramm der Karte wieder.')) AS SELECT bon_id,
 bon_dat,
 mandant_id,
 wup_id,
 kasse_typ_id,
 kundenkarte_typ_id,
 bon_nr,
 kasse_nr,
 kassierer_nr,
 kunde_fg,
 bon_beginn,
 bon_ende,
 umsatz_mwst,
 umsatz_brutto,
 bon_booking,
 dat_booking,
 turnover_fg,
 wrg_id,
 reactivated_fg,
 personal_id,
 betrag_personal_rabatt,
 kpos_kasse_typ,
 wagen_nr,
 kundenkarte_id,
 druecken_summentaste,
 schliessen_kassenschublade,
 fiskalisierung_fg,
 bon_nr_fiscal,
 alternative_karte_id,
 suspended_fg,
 suspended_bon_nr,
 online_fg,
 online_transaktion_id,
 online_bestellung_nr,
 dienstleister_id,
 geraet_id,
 bon_typ_id,
 bon_gedruckt_fg,
 bondruck_abgelehnt_fg,
 kundenkarte_status_bez,
 kundenkarte_fehler_txt,
 loyalty_berechtigt_fg,
 bon_id_orig,
 bon_dat_orig,
 wup_id_orig,
 kasse_nr_orig,
 kundenkarte_programm_cd
FROM kfl_production_dbp_ods.ods_bon_kopf_1;

