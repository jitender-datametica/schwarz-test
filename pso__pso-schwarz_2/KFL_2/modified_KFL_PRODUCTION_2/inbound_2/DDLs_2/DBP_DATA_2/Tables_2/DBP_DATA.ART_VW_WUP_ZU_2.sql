--==============================================================
-- Table: art_vw_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_vw_wup_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_VW_WUP_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   vw_id                               INTEGER     NOT NULL COMMENT 'ID des Vertriebsweges',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   rabatt_zul_fg                       INTEGER     NOT NULL COMMENT 'Flag zeigt an, ob ein Rabatt zulässig ist. Aus rbzul. Zulääsig = 1, sonst 0',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_VW_WUP_ZU PRIMARY KEY (mandant_id, wup_id, vw_id, art_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Artikel_2-Markt_Vertriebsweg Tabelle aus der Quelle wlk2_2';

