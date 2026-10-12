--==============================================================
-- Table: ist_kosten_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ist_kosten_det_2
   generated from Powerdesigner on Montag, 30. Juni 2025 16:54:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IST_KOSTEN_DET_2 CLUSTER BY (MANDANT_ID) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mengeneinheit aus meinh',
   psp_id                              INTEGER     NOT NULL COMMENT 'eindeutiger numerischer Schlüssel eines Psp-Elements aus pspnr',
   gj                                  INTEGER     NOT NULL COMMENT 'Geschäftsjahr, Format JJJJ',
   buchungsperiode_id                  INTEGER     NOT NULL COMMENT 'Buchungsperiode innerhalb des Geschäftsjahres (z.B. 01 = März, 02 = April für DE, bis 16)',
   krk_id                              VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'globale ID des Kostenrechnungskreises',
   soll_haben_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Soll-/Haben-Kennzeichen Zeigt, auf welcher Seite des Kontos (S = Soll, H = Haben) die Fortschreibung der Verkehrszahlen erfolgt.Aus shkzg',
   kostenart_id                        VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschluessel fuer die Kostenarten',
   dat_beleg                           DATE             NOT NULL COMMENT 'Belegdatum aus bldat',
   beleg_id                            VARCHAR(20)      NOT NULL COMMENT 'Belegnummer aus belnr',
   beleg_pos_id                        INTEGER     NOT NULL COMMENT 'Belegposition aus buzei',
   betrag                              NUMBER(29,2)     COMMENT 'Betrag der Belegposition aus swg',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   geschaeftsbereich_id                VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Der Geschaeftsbereich ist eine_2 interne Organisationseinheit, fuer den eine_2 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber',
   beleg_bez                           VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Beschreibung der Belegposition - Wird mit Camset-Funktion compressed',
   in_lief_id                          INTEGER     COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   nebenkontierung_id                  VARCHAR(30)      COLLATE 'en-ci' COMMENT 'ID der Nebenkontierung, z.Bsp. NC3074695008. Attribut des internen Rechnungswesens. Compress',
   nebenkontierungsart_id              VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Nebenkontierungsobjektart aus RSAUXACCTYPE',
   berichts_position_it_id             INTEGER     COMMENT 'Die Berichtsposition für Kostenarten Quelle Z_KL_TRANSACTION_CLASS - Lookup_id wird im DWH durch eine_2 fortlaufende Nummer ersetzt',
   berichts_position_invest_id         INTEGER     COMMENT 'Die Berichtsposition für Investitionen wird direkt im DWH gepflegt ',
   sparte_id                           INTEGER     COMMENT 'ID der Sparte',
   auftrag_id                          VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr. Compress',
   in_art_id                           INTEGER     COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   buchungskreis_id                    INTEGER     COMMENT 'Zuordnung des Buchungskreises zu dem WUP_2 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_2, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   anlage_id                           VARCHAR(20)      COLLATE 'en-ci' COMMENT 'ID der Anlagen Hauptnummer aus anln1. Ist in allen Fällen numerisch! Compress',
   anlage_sub_id                       INTEGER     COMMENT 'ID der Anlagen Unternummer aus anln2',
   dat_buch                            DATE             COMMENT 'Buchungsdatum aus budat',
   menge                               NUMBER(29,3)     COMMENT 'Menge aus dem Feld smeg',
   menge_einh_id                       VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Mengeneinheit aus dem Feld meinh',
   kostenstelle_id                     VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Eindeutiger sprechender Schlüssel der Kostenstelle aus kostl. Hat Referenz zur Tabelle in_kostenstelle_per_2, ist aber modellmäßig wegen dat_von nicht mit dieser verbunden',
   gegenkonto_id                       VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Gegenkonto und Lieferant wird vom FB oft synonym verwendet. Aus coep.gkont. Lookuptabelle ist kostenart_2',
   gegenkontoart_id                    VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Art_2 des Gegenkontos aus gkoar. Keine Lookup Tabelle vorhanden',
   ref_beleg_id                        INTEGER     COMMENT 'Referenzbelegnummer aus refbn',
   ref_fi_beleg_id                     VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Referenz Belegnummer aus dem Finanzbelegkopf bkpf, Quellfeld  xblnr. Könnte auch als Referenz zu dieser (im DWH nicht abgebildeten Tabelle) abgebildet werden. Compressed',
   in_fi_belegkopftext                 VARCHAR(50)      COLLATE 'en-ci' COMMENT 'Belegkopftext aus dem Finanzbelegkopf bkpf, Quellfeld  bktxt Könnte auch als Referenz zu dieser (im DWH nicht abgebildeten Tabelle) abgebildet werden. Wird mit Camset-Funktion compressed',
   best_beleg_id                       INTEGER     COMMENT 'Belegnummer des Einkaufsbelegs aus ebeln',
   best_beleg_pos_id                   INTEGER     COMMENT 'Belegposition des Einkaufsbelegs aus ebelp',
   partner_objektart_id                VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Art_2 des Partnerobjekts aus cobk.obart. Inhalt 0CCT = Kostenstelle, 0ATY = Kostenstelle/Leistungsart, 0COR = Auftrag, 0ABC = Geschäftsprozess, 0POS = PSP-Element, 0SDP = Kundenauftrag',
   partner_objekt_id                   VARCHAR(30)      COLLATE 'en-ci' COMMENT 'ID des Partnerobjekts aus parob. Bei PSP-Elementen ist hier die Nummer des alten Elements vor der Migration hinterlegt. Compress',
   bestell_text                        VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bestelltext. Quelle ist ekpo.txz01. Wird mit Camset-Funktion compressed',
   ref_buchungskreis_id                INTEGER     COMMENT 'Referenzbuchungskreis aus fibk',
   belegart_id                         VARCHAR(2)       COLLATE 'en-ci' COMMENT 'Die Belegart gruppiert die FI Belege (z.B. FI Belege aus Mietvorgängen Belegart ID, IP, RV) Zahlungen (z. B. SA) usw.Aus blart. Im DWH vorhandene Lookuptabelle l_belegart_2 aus Retail keine vollständige Referenz',
   belastungs_kz                       VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Belastungskennzeichen aus coep.beknz, z.Bsp. A für Sender-Entlastung aus Abrechnung',
   ref_vorgang_id                      VARCHAR(7)       COLLATE 'en-ci' COMMENT 'Referenzvorgang aus cobk.awtyp. Z.Bsp ergibt der Inhalt auak zusammen mit Belastungskennzeichen H ein Merkmal A, das wieder für spezielle Anwendungsfälle gebraucht wird.',
   hb2_fg                              INTEGER     NOT NULL DEFAULT 0 COMMENT 'Flag kennzeichnet Datensätze, die neuem Hauptbuch (hb2) entsprechen. Wird durch DWH-Versorgung gesetzt',
   co_leistungsart_id                  VARCHAR(50)      NOT NULL COLLATE 'en-ci' DEFAULT '       ' COMMENT 'ID der CO-Leistungsart. Referenz zur Tabelle  in_l_leistungsart.Wird in der Versorgung aus dem Quellfeld COEP.uspob extrahiert',
   bedarf_nr                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Bedarfsnummer - SAP EKPO.BEDNR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IST_KOSTEN_DET PRIMARY KEY (mandant_id, psp_id, gj, buchungsperiode_id, krk_id, soll_haben_kz, kostenart_id, dat_beleg, beleg_id, beleg_pos_id) NOT ENFORCED
)  COMMENT = 'IMS - Ist-Einzelkosten aus den SAP Quellen cobk und coep';
