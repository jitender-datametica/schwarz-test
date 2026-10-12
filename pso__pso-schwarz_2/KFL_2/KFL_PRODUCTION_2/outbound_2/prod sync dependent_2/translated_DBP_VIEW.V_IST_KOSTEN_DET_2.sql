CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ist_kosten_det_2 (mandant_id
OPTIONS(description='Mengeneinheit aus meinh'), psp_id
OPTIONS(description='eindeutiger numerischer Schlüssel eines Psp-Elements aus pspnr'), gj
OPTIONS(description='Geschäftsjahr, Format JJJJ'), buchungsperiode_id
OPTIONS(description='Buchungsperiode innerhalb des Geschäftsjahres (z.B. 01 = März, 02 = April für DE, bis 16)'), krk_id
OPTIONS(description='globale ID des Kostenrechnungskreises'), soll_haben_kz
OPTIONS(description='Soll-/Haben-Kennzeichen Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt.Aus shkzg'),
kostenart_id OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'), dat_beleg
OPTIONS(description='Belegdatum aus bldat'), beleg_id OPTIONS(description='Belegnummer aus belnr'), beleg_pos_id
OPTIONS(description='Belegposition aus buzei'), betrag OPTIONS(description='Betrag der Belegposition aus swg'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), geschaeftsbereich_id
OPTIONS(description='Der Geschaeftsbereich ist eine_2 interne Organisationseinheit, fuer den eine_2 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber'),
beleg_bez OPTIONS(description='Beschreibung der Belegposition - Wird mit Camset-Funktion compressed'), in_lief_id
OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'), nebenkontierung_id
OPTIONS(description='ID der Nebenkontierung, z.Bsp. NC3074695008. Attribut des internen Rechnungswesens. Compress'),
nebenkontierungsart_id OPTIONS(description='Nebenkontierungsobjektart aus RSAUXACCTYPE'), berichts_position_it_id
OPTIONS(description='Die Berichtsposition für Kostenarten Quelle Z_KL_TRANSACTION_CLASS - Lookup_id wird im DWH durch eine_2 fortlaufende Nummer ersetzt'),
berichts_position_invest_id OPTIONS(description='Die Berichtsposition für Investitionen wird direkt im DWH gepflegt '),
sparte_id OPTIONS(description='ID der Sparte'), auftrag_id OPTIONS(description='Auftragsnummer aus aufnr. Compress'),
in_art_id OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'), buchungskreis_id
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
anlage_id OPTIONS(description='ID der Anlagen Hauptnummer aus anln1. Ist in allen Fällen numerisch! Compress'),
anlage_sub_id OPTIONS(description='ID der Anlagen Unternummer aus anln2'), dat_buch
OPTIONS(description='Buchungsdatum aus budat'), menge OPTIONS(description='Menge aus dem Feld smeg'), menge_einh_id
OPTIONS(description='Mengeneinheit aus dem Feld meinh'), kostenstelle_id
OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle aus kostl. Hat Referenz zur Tabelle in_kostenstelle_per_2, ist aber modellmäßig wegen dat_von nicht mit dieser verbunden'),
gegenkonto_id
OPTIONS(description='Gegenkonto und Lieferant wird vom FB oft synonym verwendet. Aus coep.gkont. Lookuptabelle ist kostenart_2'),
gegenkontoart_id OPTIONS(description='Art_2 des Gegenkontos aus gkoar. Keine Lookup Tabelle vorhanden'), ref_beleg_id
OPTIONS(description='Referenzbelegnummer aus refbn'), ref_fi_beleg_id
OPTIONS(description='Referenz Belegnummer aus dem Finanzbelegkopf bkpf, Quellfeld  xblnr. Könnte auch als Referenz zu dieser (im DWH nicht abgebildeten Tabelle) abgebildet werden. Compressed'),
in_fi_belegkopftext
OPTIONS(description='Belegkopftext aus dem Finanzbelegkopf bkpf, Quellfeld  bktxt Könnte auch als Referenz zu dieser (im DWH nicht abgebildeten Tabelle) abgebildet werden. Wird mit Camset-Funktion compressed'),
best_beleg_id OPTIONS(description='Belegnummer des Einkaufsbelegs aus ebeln'), best_beleg_pos_id
OPTIONS(description='Belegposition des Einkaufsbelegs aus ebelp'), partner_objektart_id
OPTIONS(description='Art_2 des Partnerobjekts aus cobk.obart. Inhalt 0CCT = Kostenstelle, 0ATY = Kostenstelle/Leistungsart, 0COR = Auftrag, 0ABC = Geschäftsprozess, 0POS = PSP-Element, 0SDP = Kundenauftrag'),
partner_objekt_id
OPTIONS(description='ID des Partnerobjekts aus parob. Bei PSP-Elementen ist hier die Nummer des alten Elements vor der Migration hinterlegt. Compress'),
bestell_text OPTIONS(description='Bestelltext. Quelle ist ekpo.txz01. Wird mit Camset-Funktion compressed'),
ref_buchungskreis_id OPTIONS(description='Referenzbuchungskreis aus fibk'), belegart_id
OPTIONS(description='Die Belegart gruppiert die FI Belege (z.B. FI Belege aus Mietvorgängen Belegart ID, IP, RV) Zahlungen (z. B. SA) usw.Aus blart. Im DWH vorhandene Lookuptabelle l_belegart_2 aus Retail keine vollständige Referenz'),
belastungs_kz OPTIONS(description='Belastungskennzeichen aus coep.beknz, z.Bsp. A für Sender-Entlastung aus Abrechnung'),
ref_vorgang_id
OPTIONS(description='Referenzvorgang aus cobk.awtyp. Z.Bsp ergibt der Inhalt auak zusammen mit Belastungskennzeichen H ein Merkmal A, das wieder für spezielle Anwendungsfälle gebraucht wird.'),
hb2_fg
OPTIONS(description='Flag kennzeichnet Datensätze, die neuem Hauptbuch (hb2) entsprechen. Wird durch DWH-Versorgung gesetzt'),
co_leistungsart_id
OPTIONS(description='ID der CO-Leistungsart. Referenz zur Tabelle  in_l_leistungsart.Wird in der Versorgung aus dem Quellfeld COEP.uspob extrahiert'),
bedarf_nr OPTIONS(description='Bedarfsnummer - SAP EKPO.BEDNR')) AS SELECT mandant_id,
 psp_id,
 gj,
 buchungsperiode_id,
 krk_id,
 soll_haben_kz,
 kostenart_id,
 dat_beleg,
 beleg_id,
 beleg_pos_id,
 betrag,
 wrg_id,
 geschaeftsbereich_id,
 beleg_bez,
 in_lief_id,
 nebenkontierung_id,
 nebenkontierungsart_id,
 berichts_position_it_id,
 berichts_position_invest_id,
 sparte_id,
 auftrag_id,
 in_art_id,
 buchungskreis_id,
 anlage_id,
 anlage_sub_id,
 dat_buch,
 menge,
 menge_einh_id,
 kostenstelle_id,
 gegenkonto_id,
 gegenkontoart_id,
 ref_beleg_id,
 ref_fi_beleg_id,
 in_fi_belegkopftext,
 best_beleg_id,
 best_beleg_pos_id,
 partner_objektart_id,
 partner_objekt_id,
 bestell_text,
 ref_buchungskreis_id,
 belegart_id,
 belastungs_kz,
 ref_vorgang_id,
 hb2_fg,
 co_leistungsart_id,
 bedarf_nr
FROM kfl_production_dbp_data.ist_kosten_det_2;