--==============================================================
-- Table: ts_ais_de_prognose_avq_ek_saison_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_ais_de_prognose_avq_ek_saison_tag_1
   generated from Powerdesigner on Wednesday, 15 May 2024 20:17:12
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW2.TS_AIS_DE_PROGNOSE_AVQ_EK_SAISON_TAG_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   ek_saison_id                        INTEGER     NOT NULL COMMENT 'Cluster-ID des zugehörigen EK-Saisonclusters in dem Artikel_1 gebündelt sind.',
   dat_prognose                        DATE             NOT NULL COMMENT 'Datum für das die Prognose errechnet wurde.',
   menge_absatz_prognose               NUMBER(29,3)     NOT NULL COMMENT 'Absatzprognose, immer gebündelt je Saison(-artikel_1) pro Tag. Dient der Berechnung einer Ziel-AVQ (Abverkaufsquote). Prognose je Saison grundsätzlich einheitlich je Basismengeneinheit. Vereinzelte Saisons können Stück- und Gewichtsartikel kombinieren, weshalb sich eine_1 Mengeneinheit nicht immer zweifelsfrei zuordnen lässt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_AIS_DE_PROGNOSE_AVQ_EK_SAISON_TAG PRIMARY KEY (mandant_id, ek_saison_id, dat_prognose) NOT ENFORCED
)  COMMENT = 'AIS DE - Absatzprognose für das EKCO DE AVQ (Abverkaufsquote) Dossier. Absatzprognose gebündelt auf Ebene EK-Saison und Tag. Prognose grundsätzlich je EK-Saison zwischen Stück- und Gewichtsartikel getrennt. Für einzelne Saison-Auswertungen können Stück- und Gewichtsartikel gemischt sein, weshalb sich eine_1 Mengeneinheit nicht immer zweifelsfrei zuordnen lässt.
             Achtung: Diese Tabelle hier ist als Zwischenlösung gedacht, bis der Prozess für den Umgang mit Transaction Service Tabellen, die Notwendigkeit Daten manuell ins DWH zu bringen, oder der Umgang mit nicht standardisierten Ladeprozessen geklärt ist.';
