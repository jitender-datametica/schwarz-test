--==============================================================
-- Table: fur_art_wup_frp_ltz_lauf
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fur_art_wup_frp_ltz_lauf
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FUR_ART_WUP_FRP_LTZ_LAUF (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   standardabweichung                  NUMBER(29,6)     NOT NULL DEFAULT 0 COMMENT 'Standardabweichung in Rückschauhorizont für Verbrauch',
   klassifikationsmittelwert           NUMBER(29,6)     NOT NULL DEFAULT 0 COMMENT 'Klassifikationsmittelwert (classmean)',
   drehklasse_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT '0' COMMENT 'Drehklasse auf Artikel-/ Markt-Kombination(z.B. A, B oder C (Schnell-, Mittel- und Langsamdreher )-wird im ETL-Prozess auf Basis der F&R-Daten ermittelt: Schwellwerte: A=80% des Absatz (Stückbedarf an Gesamtmenge), B= 15% des Absatz, C= 5% des Absatz)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FUR_ART_WUP_FRP_LTZ_LAUF PRIMARY KEY (mandant_id, wup_id, nb_id, art_id) NOT ENFORCED
)  COMMENT = 'SCM - F&R - Lokationsprduktdaten für / aus ltzt. FRP-Lauf - SAP F&R - /FRE/MATLOC_FRP';

