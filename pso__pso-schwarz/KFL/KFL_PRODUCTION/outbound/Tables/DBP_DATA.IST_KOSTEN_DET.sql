--==============================================================
-- Table: ist_kosten_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ist_kosten_det
   generated from Powerdesigner on Montag, 30. Juni 2025 16:54:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ist_kosten_det (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mengeneinheit aus meinh'),
psp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='eindeutiger numerischer Schlüssel eines Psp-Elements aus pspnr'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr, Format JJJJ'),
buchungsperiode_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Buchungsperiode innerhalb des Geschäftsjahres (z.B. 01 = März, 02 = April für DE, bis 16)'),
krk_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='globale ID des Kostenrechnungskreises'),
soll_haben_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Soll-/Haben-Kennzeichen Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt.Aus shkzg'),
kostenart_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'),
dat_beleg DATE NOT NULL OPTIONS(description='Belegdatum aus bldat'),
beleg_id STRING(20) NOT NULL OPTIONS(description='Belegnummer aus belnr'),
beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegposition aus buzei'),
betrag NUMERIC(18,2) OPTIONS(description='Betrag der Belegposition aus swg'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
geschaeftsbereich_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Der Geschaeftsbereich ist eine interne Organisationseinheit, fuer den eine interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber'),
beleg_bez STRING(50) COLLATE 'und:ci'
OPTIONS(description='Beschreibung der Belegposition - Wird mit Camset-Funktion compressed'),
in_lief_id BIGNUMERIC(38,0) OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
nebenkontierung_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='ID der Nebenkontierung, z.Bsp. NC3074695008. Attribut des internen Rechnungswesens. Compress'),
nebenkontierungsart_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Nebenkontierungsobjektart aus RSAUXACCTYPE'),
berichts_position_it_id BIGNUMERIC(38,0)
OPTIONS(description='Die Berichtsposition für Kostenarten Quelle Z_KL_TRANSACTION_CLASS - Lookup_id wird im DWH durch eine fortlaufende Nummer ersetzt'),
berichts_position_invest_id BIGNUMERIC(38,0)
OPTIONS(description='Die Berichtsposition für Investitionen wird direkt im DWH gepflegt '),
sparte_id BIGNUMERIC(38,0) OPTIONS(description='ID der Sparte'),
auftrag_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Auftragsnummer aus aufnr. Compress'),
in_art_id BIGNUMERIC(38,0) OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
buchungskreis_id BIGNUMERIC(38,0)
OPTIONS(description='Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland'),
anlage_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='ID der Anlagen Hauptnummer aus anln1. Ist in allen Fällen numerisch! Compress'),
anlage_sub_id BIGNUMERIC(38,0) OPTIONS(description='ID der Anlagen Unternummer aus anln2'),
dat_buch DATE OPTIONS(description='Buchungsdatum aus budat'),
menge NUMERIC(18,3) OPTIONS(description='Menge aus dem Feld smeg'),
menge_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Mengeneinheit aus dem Feld meinh'),
kostenstelle_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Eindeutiger sprechender Schlüssel der Kostenstelle aus kostl. Hat Referenz zur Tabelle in_kostenstelle_per, ist aber modellmäßig wegen dat_von nicht mit dieser verbunden'),
gegenkonto_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Gegenkonto und Lieferant wird vom FB oft synonym verwendet. Aus coep.gkont. Lookuptabelle ist kostenart'),
gegenkontoart_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Art des Gegenkontos aus gkoar. Keine Lookup Tabelle vorhanden'),
ref_beleg_id INTEGER OPTIONS(description='Referenzbelegnummer aus refbn'),
ref_fi_beleg_id STRING(20) COLLATE 'und:ci'
OPTIONS(description='Referenz Belegnummer aus dem Finanzbelegkopf bkpf, Quellfeld  xblnr. Könnte auch als Referenz zu dieser (im DWH nicht abgebildeten Tabelle) abgebildet werden. Compressed'),
in_fi_belegkopftext STRING(50) COLLATE 'und:ci'
OPTIONS(description='Belegkopftext aus dem Finanzbelegkopf bkpf, Quellfeld  bktxt Könnte auch als Referenz zu dieser (im DWH nicht abgebildeten Tabelle) abgebildet werden. Wird mit Camset-Funktion compressed'),
best_beleg_id INTEGER OPTIONS(description='Belegnummer des Einkaufsbelegs aus ebeln'),
best_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Belegposition des Einkaufsbelegs aus ebelp'),
partner_objektart_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Art des Partnerobjekts aus cobk.obart. Inhalt 0CCT = Kostenstelle, 0ATY = Kostenstelle/Leistungsart, 0COR = Auftrag, 0ABC = Geschäftsprozess, 0POS = PSP-Element, 0SDP = Kundenauftrag'),
partner_objekt_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='ID des Partnerobjekts aus parob. Bei PSP-Elementen ist hier die Nummer des alten Elements vor der Migration hinterlegt. Compress'),
bestell_text STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bestelltext. Quelle ist ekpo.txz01. Wird mit Camset-Funktion compressed'),
ref_buchungskreis_id BIGNUMERIC(38,0) OPTIONS(description='Referenzbuchungskreis aus fibk'),
belegart_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Die Belegart gruppiert die FI Belege (z.B. FI Belege aus Mietvorgängen Belegart ID, IP, RV) Zahlungen (z. B. SA) usw.Aus blart. Im DWH vorhandene Lookuptabelle l_belegart aus Retail keine vollständige Referenz'),
belastungs_kz STRING(1) COLLATE 'und:ci'
OPTIONS(description='Belastungskennzeichen aus coep.beknz, z.Bsp. A für Sender-Entlastung aus Abrechnung'),
ref_vorgang_id STRING(7) COLLATE 'und:ci'
OPTIONS(description='Referenzvorgang aus cobk.awtyp. Z.Bsp ergibt der Inhalt auak zusammen mit Belastungskennzeichen H ein Merkmal A, das wieder für spezielle Anwendungsfälle gebraucht wird.'),
hb2_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Flag kennzeichnet Datensätze, die neuem Hauptbuch (hb2) entsprechen. Wird durch DWH-Versorgung gesetzt'),
co_leistungsart_id STRING(50) COLLATE 'und:ci' DEFAULT '       ' NOT NULL
OPTIONS(description='ID der CO-Leistungsart. Referenz zur Tabelle  in_l_leistungsart.Wird in der Versorgung aus dem Quellfeld COEP.uspob extrahiert'),
bedarf_nr STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL
OPTIONS(description='Bedarfsnummer - SAP EKPO.BEDNR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, psp_id, gj, buchungsperiode_id, dat_beleg, beleg_id, beleg_pos_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='IMS - Ist-Einzelkosten aus den SAP Quellen cobk und coep');