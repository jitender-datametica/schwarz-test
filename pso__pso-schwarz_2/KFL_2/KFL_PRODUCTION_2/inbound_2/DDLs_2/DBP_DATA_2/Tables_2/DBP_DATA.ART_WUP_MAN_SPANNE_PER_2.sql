--==============================================================
-- Table: art_wup_man_spanne_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_man_spanne_per_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_MAN_SPANNE_PER_2 (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2 ID',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   konditionsart_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
   dat_von                             DATE             NOT NULL COMMENT 'gültig-ab aus gm_vld_fr',
   ek_faktor                           NUMBER(9,4)      COMMENT 'Faktor wird aus dem Original-Prozentwert errechnet aus kwert',
   dat_bis                             DATE             NOT NULL COMMENT 'gültig-bis aus gm_vld_to',
   loesch_fg                           NUMBER(38,0)     NOT NULL COMMENT 'Das Flag kennzeichnet die Kondition als gelöscht aus lvorm',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_MAN_SPANNE_PER PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, konditionsart_id, dat_von) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Daten der manuellen Spannenpflege auf Marktebene aus a406';

