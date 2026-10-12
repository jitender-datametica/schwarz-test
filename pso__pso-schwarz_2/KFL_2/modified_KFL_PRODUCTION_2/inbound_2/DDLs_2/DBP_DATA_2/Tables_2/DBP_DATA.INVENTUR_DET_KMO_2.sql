--==============================================================
-- Table: inventur_det_kmo_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_det_kmo_2
   generated from Powerdesigner on Freitag, 17. März 2023 10:53:37
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.INVENTUR_DET_KMO_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   zeitpunkt_inv                       TIMESTAMP_NTZ(0) NOT NULL COMMENT 'Datum und Zeit_2 der Inventur_2',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   menge_inv                           NUMBER(29,3)     NOT NULL COMMENT 'Invertierte Menge',
   bestand_wert                        NUMBER(29,3)     NOT NULL COMMENT 'Bewerteter, frei verwendbarer Bestand',
   wert_eingabe                        VARCHAR(1)       COLLATE 'en-ci' COMMENT 'Neue Eingabewerte',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_INVENTUR_DET_KMO PRIMARY KEY (mandant_id, wup_id, nb_id, zeitpunkt_inv) NOT ENFORCED
)  COMMENT = 'VIS - Daten aller Bestandskorrekturen und -zaehlungen für KMO';