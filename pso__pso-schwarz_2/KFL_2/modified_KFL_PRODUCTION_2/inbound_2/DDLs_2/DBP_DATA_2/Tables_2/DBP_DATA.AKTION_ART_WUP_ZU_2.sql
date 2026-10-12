--==============================================================
-- Table: aktion_art_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_art_wup_zu_2
   generated from Powerdesigner on Montag, 31. Oktober 2022 14:06:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_ART_WUP_ZU_2 CLUSTER BY (MANDANT_ID)(
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH.',
   aktion_id                           VARCHAR(10)     COLLATE 'en-ci' NOT NULL COMMENT 'Eindeutige Kennung einer Aktion_2 aus der Quelle wale.aktnr.',
   art_id                              INTEGER    NOT NULL COMMENT 'Input: Artikel_2-ID einschliesslich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   bewart_id                           INTEGER    NOT NULL COMMENT 'Bewegungsart-ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang.',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter-WUP_2-ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   vk_aktion_brutto                    NUMBER(29,2)     NOT NULL COMMENT 'Aktionsverkaufspreis brutto.',
   wrg_id                              VARCHAR(3)      NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   bezugsweg_id                        INTEGER    NOT NULL COMMENT 'Kennzeichnet, ob der Artikel_2 vom Zentrallager bezogen wird (Bezugsweg = 4) oder direkt vom Lieferanten (Bezugsweg = 1).',
   grund_sperrung                      VARCHAR(1)      COLLATE 'en-ci' COMMENT 'Kennzeichnet die Sperrung eines Artikels in der Aktion. Wertevorrat: A = Lieferschwierigkeiten, B = Beschaffung unklar, C = Artikel_2 schadhaft, D = sonstiges, X = gesperrt (nur in KMO).',
   dat_sperrung                        DATE            COMMENT 'Datum, zu dem ein Artikel_2 gesperrt wurde.',
   aktion_thema_id                     VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Aktionsthema aus der SAP Tabelle WAKP.',
   vk_vor_aktion_brutto                NUMBER(29,2)     COMMENT 'Letzter Verkaufspreis vor der Aktion_2 - wird für alle Mandanten außer Mandant_2 1 gefüllt.',
   vor_aktion_wrg_id                   VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR. Für Abweichung der Währung, wie z.B. Währungsumstellung Kroatien.',
   dat_preisaktiviert                  DATE            DEFAULT CAST('1900-01-01' AS DATE) NOT NULL COMMENT 'Datum der Aktionspreisaktivierung.',
   geloescht_sap_fg                    INTEGER    COMMENT 'Flag: Aktionsartikel gelöscht in SAP.',
   dat_geloescht_sap                   DATE            COMMENT 'Datum der Löschung.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_ART_WUP_ZU PRIMARY KEY (mandant_id, aktion_id, art_id, bewart_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'AIS - Positionen der zentralen Aktionen. Zuordnung Artikel_2 Aktion_2 Filiale.';
