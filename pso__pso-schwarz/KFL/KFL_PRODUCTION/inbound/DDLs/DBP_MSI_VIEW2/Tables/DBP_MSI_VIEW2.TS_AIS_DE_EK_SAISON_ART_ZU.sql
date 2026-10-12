--==============================================================
-- Table: ts_ais_de_ek_saison_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_ek_saison_art_zu
   generated from Powerdesigner on Donnerstag, 1. Februar 2024 16:08:34
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW2.TS_AIS_DE_EK_SAISON_ART_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH.',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   ek_saison_id                        NUMBER(38,0)     NOT NULL COMMENT 'Cluster ID des zugehörigen Saisonclusters zum Artikel.',
   dat_gueltig_von                     DATE             NOT NULL COMMENT 'Beginn Saison-Gültigkeitszeitraum des Artikels.',
   dat_gueltig_bis                     DATE             NOT NULL COMMENT 'Ende Saison-Gültigkeitszeitraum des Artikels.',
   kl_art_id_liste_txt                 VARCHAR(10000)   NOT NULL,
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AIS_DE_EK_SAISON_ART_ZU PRIMARY KEY (mandant_id, art_id, ek_saison_id, dat_gueltig_von) NOT ENFORCED
)  COMMENT = 'AIS DE - Für eine bestimme Saison und Zeitraum werden Artikelgruppen gepflegt, welche aus dem Einkauf (Fachbereich) vorgegeben werden.
             ACHTUNG: Diese Tabelle hier ist als Zischenlösung gedacht, bis der Prozess für den Umgang mit Transaction Service Tabellen, die Notwendigkeit Daten manuell ins DWH zu bringen, oder der Umgang mit nicht standardisierten geklärt ist.';
