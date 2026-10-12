--==============================================================
-- Table: art_vw_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_vw_wup_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_VW_WUP_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   vw_id                               INTEGER     NOT NULL COMMENT 'ID des Vertriebsweges',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   rabatt_zul_fg                       INTEGER     NOT NULL COMMENT 'Flag zeigt an, ob ein Rabatt zulässig ist. Aus rbzul. Zulääsig = 1, sonst 0',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_VW_WUP_ZU PRIMARY KEY (mandant_id, wup_id, vw_id, art_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Artikel-Markt_Vertriebsweg Tabelle aus der Quelle wlk2';

