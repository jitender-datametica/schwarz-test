--==============================================================
-- Table: art_wup_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_ZU_PER CLUSTER BY (MANDANT_ID) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT '"Der ""WUP"" beinhaltet Märkte und Läger. WUP=WarenUmschlagsPlatz
            
            Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum
            ',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat_von                             DATE             NOT NULL COMMENT 'Datum wann ein Artikel zum ersten Mal in einem Markt gelistet ist',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   bezugsweg_id                        INTEGER     COMMENT 'Kennzeichnet, ob der Artikel vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1)',
   listung_id                          INTEGER     COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Der erste Eintrag erfolgt immer aufgrund einer Listung, bei Auslistung erfolgt  ein weiterer Eintrag mit 0. Die column ist wegen art_list_wup_zu_per eigentlich obsolet',
   vk_brutto                           NUMBER(29,3),
   dat_bis                             DATE             NOT NULL COMMENT 'Ende der Gültigkeitsperiode. Format JJJJ-MM-TT
            ',
   kdis                                INTEGER     COMMENT 'kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel ist über den normalen Weg bestellbar, 1: der Artikel wird  zugeteilt',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_ZU_PER PRIMARY KEY (mandant_id, wup_id, nb_id, dat_von, art_id) NOT ENFORCED
)  COMMENT = 'TP2 AIS - Artikel-Markt-Zuordnung - MULTISET	
             Enthält Informationen, wie Artikel den Märkten zugeordnet sind, u.a. Listung, Bezugsweg und Normal-Verkaufspreise. Keine Information über Sonderaktionen enthalten';

