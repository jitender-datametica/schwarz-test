--==============================================================
-- Table: art_wup_rueckgabe_verwendung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_rueckgabe_verwendung
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 10:43:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_RUECKGABE_VERWENDUNG (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   rueckgabe_nr                        NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Rückgabe. Hochzählender Nummernkreis bei Buchung im Quellsystem.',
   dat_rueckgabe                       DATE             NOT NULL COMMENT 'Datum der Rückgabe in der Filiale.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID des Warenumschlagsplatz. Artikel können in der Regel nur in Filialen an der Info oder Kasse zurückgegeben werden.',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   reklamationsgrund_id                NUMBER(38,0)     NOT NULL COMMENT 'ID des Grundes für die Reklamation / Rückgabe des Artikels.',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   menge_art                           NUMBER(38,3)     NOT NULL COMMENT 'Anzahl der zurückgegebenen Artikel. Kann sowohl ganzzahlig (Stück) als auch Nachkommastellen haben (bspw. Gewichtsartikel).',
   einh_id                             VARCHAR(3)       NOT NULL COMMENT 'Einheit der zurückgegebenen Artikel, bspw. Stück, kg, etc.',
   wrg_id                              VARCHAR(3)       NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
   betrag_vk_netto_rueckgabe           NUMBER(38,4)     NOT NULL COMMENT 'Verkaufspreis des Artikels zum Zeitpunkt der Rückgabe.',
   betrag_vk_netto_kauf                NUMBER(38,4)     NOT NULL COMMENT 'Verkaufspreis des Artikels zum Zeitpunkt des Kaufes.',
   dat_mhd                             DATE             COMMENT 'Mindesthaltbarkeitsdatum des Artikels. Wenn MHD nicht lesbar ist, kann hier ein dummy-Datum auftreten. Bei Artikeln ohne MHD ist die Spalte Null.',
   rueckgabe_verwendung_kz             VARCHAR(10)      COMMENT 'Code definiert die Art der Weiterverwendung eines in der Filiale zurück gegebenen Artikels. Die Weiterverwendung kann sich je nach Artikel und Reklamationsgrund unterscheiden. Beispiele hierfür sind Abschreibungen, Qualitätssicherung, zurück in Verkauf, etc.',
   verarbeitet_fg                      NUMBER(38,0)     NOT NULL COMMENT 'Flag, welches angibt ob die Rückgabe verarbeitet ist. 1 = verarbeitet, 0 = nicht verarbeitet.',
   dat_verarbeitung                    DATE             COMMENT 'Datum der Verarbeitung der Rückgabe.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_RUECKGABE_VERWENDUNG PRIMARY KEY (mandant_id, rueckgabe_nr, dat_rueckgabe) NOT ENFORCED
)  COMMENT = 'Tabelle beinhaltet Informationen zur Rückgabe von Artikeln und deren weiteren Verwendung in den Filialen.';