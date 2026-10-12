--==============================================================
-- Table: art_man_spanne_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_man_spanne_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_MAN_SPANNE_PER (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikel ID',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   konditionsart_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.',
   dat_von                             DATE             NOT NULL COMMENT 'gültig-ab aus gm_vld_fr',
   ek_faktor                           NUMBER(9,4)      COMMENT 'Faktor wird aus dem Original-Prozentwert errechnet aus kwert',
   dat_bis                             DATE             NOT NULL COMMENT 'gültig-bis aus gm_vld_to',
   loesch_fg                           NUMBER(38,0)     NOT NULL COMMENT 'Das Flag kennzeichnet die Kondition als gelöscht aus lvorm',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_MAN_SPANNE_PER PRIMARY KEY (art_id, mandant_id, konditionsart_id, dat_von) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Faktoren zur EK Bewertung auf Ebene Artikel der manuellen Spannenpflege aus a445';

