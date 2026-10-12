--==============================================================
-- Table: art_bewertungskreis_periode_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_bewertungskreis_periode_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_BEWERTUNGSKREIS_PERIODE_2 CLUSTER BY (MANDANT_ID) (
   gjmo                                INTEGER     NOT NULL COMMENT 'Geschäftsjahresmonat',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig);',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   bewertungskreis_id                  VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'der Bewertungskreis enthält die wup_id. Theoretisch kann auch ein Buchungskreis enthalten sein. Über den Bewertungskreis wird die Verbindung zum Gleitenden Durchschnittspreis hergestellt aus bwkey
            
            ',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   dat_aenderung                       DATE             NOT NULL COMMENT 'Aenderungsdatum des Satzes im SAP Quellsystem.',
   menge_bestand_bme                   NUMBER(29,3)     NOT NULL COMMENT 'Gesamtbestand in Basismengeneinheiten aus lbkum',
   wert_bestand                        NUMBER(29,4)     NOT NULL COMMENT 'Entspricht nicht dem Produkt aus Menge und Preis und muss daher als eigener Wert gespeichert werden. Aus salk3',
   vk_wert                             NUMBER(29,2)     NOT NULL COMMENT 'Zum Verkaufspreis bewerteter Bestand aus vksal',
   mbew_fg                             INTEGER     NOT NULL COMMENT 'kenneichnet die Quelltabelle des Satzes. Wenn aus mbew, dann = 1, mbewh = 0',
   gjmo_bis                            INTEGER     NOT NULL COMMENT 'Geschäftsjahresmonat bis. Wird im DWH angereichert, um die Abfrage bei "Lücken" in den Monaten zu vereinfachen',
   bewertung_klasse_id                 VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Die Bewertungsklasse bestimmt u.a. die Sachkonten, die fortgeschrieben werden. Quelle ist bklas',
   preis_steuer_kz                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Preissteuerkennzeichen.S= S- Preis, V=GLD. Aus vprsv',
   gld                                 NUMBER(29,6)     NOT NULL COMMENT 'Gleitender Durchschnittspreis. In KMO die Basis zur Bewertung der Bestände. Ist unabhängig vom preis_steuer_kz vorhanden. Quelle ist verpr',
   standard_preis                      NUMBER(29,4)     NOT NULL DEFAULT 0 COMMENT 'Der Standardpreis ist nur bei entsprechend gesetztem preis_steuer_kz gefüllt (S). Quelle ist stprs',
   dat_letzte_preisaenderung           DATE             COMMENT 'Datum der letzten Preisaenderung aus der Tabelle mbew,  Feld laepr',
   vk_wert_netto                       NUMBER(29,2)     NOT NULL COMMENT 'Zum Netto-Verkaufspreis bewerteter Bestand.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_BEWERTUNGSKREIS_PERIODE PRIMARY KEY (gjmo, art_id, mandant_id, bewertungskreis_id) NOT ENFORCED
)  COMMENT = 'WWC - Bewerteter Bestand aus den SAP Datenquellen MBEWH und MBEW ';

