--==============================================================
-- Table: hfm_inventur_termin_owg_wup_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hfm_inventur_termin_owg_wup_zu_2
   generated from Powerdesigner on Freitag, 16. Februar 2024 10:27:53
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HFM_INVENTUR_TERMIN_OWG_WUP_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   owg_id                              INTEGER     NOT NULL COMMENT 'ID der Oberwarengruppe',
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   dat_plan_zaehlung                   DATE             NOT NULL COMMENT 'Geplantes Datum der Inventurzählung (Datum der Inventurdurchführung)',
   inventurart_int_id                  INTEGER     NOT NULL COMMENT 'SRS: Inventurart international (Gruppierung für die Vereinheitlichung und Reportingebene; Bsp. 1=Flop)',
   dat_vorletzte_zaehlung              DATE             NOT NULL COMMENT 'Datum der vorletzten Inventur_2 (wird ermittelt aus ISEG auf Markt/Artikel_2/Inventurart_INT-Ebene, ausgehend vom dat_letzt_zaehlung, welches war der vorherige Termin (dat_letzt_zaehlung))',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_vk_netto_sum                 NUMBER(29,4)     NOT NULL COMMENT 'Summierter Wert des Umsatzes für den Zeitraum dat_vorletzte_zaehlung bis dat_plan_zaehlung (dat_letzt_zaehlung)',
   inventur_wert_vk_netto              NUMBER(29,2)     NOT NULL DEFAULT 0 COMMENT 'Wert der gebuchten Inventurdifferenzen (lagerbew_det.wert_vk_netto - mseg.vkwra) zum Stichtag dat_plan_zaehlung',
   betrag_netto_diebstahl_abschrift    NUMBER(29,4)     COMMENT 'Betrag entählt die durch Abschriften_2 aufgrund von Diebstahl veursachte Inventurdifferenz. Bezieht sich auf den Zeitraum zwischen dat_plan_zaehlung und dat_vorletzte_zaehlung.',
   betrag_netto_preis_abschrift        NUMBER(29,4)     COMMENT 'Betrag enthält die durch Preisabschriften verursachte Inventurdifferenz. Bezieht sich auf den Zeitraum zwischen dat_plan_zaehlung und dat_vorletzte_zaehlung.',
   betrag_netto_total_abschrift        NUMBER(29,4)     COMMENT 'Betrag enthält die durch Totalabschriften verursachte Inventurdifferenz. Bezieht sich auf den Zeitraum zwischen dat_plan_zaehlung und dat_vorletzte_zaehlung.',
   betrag_kalk_inventur_diff           NUMBER(29,4)     COMMENT 'Betrag enthält die kalkulatorische Inventurdifferenz. Inventuren können nicht immer am letzten Tag_2 des Zeitraums ermittelt werden. Die entstehende Inventurverluste zwischen dem Erfassungszeitpunkt und dem Ende des Inventurzeitraums werden vom Controlling in der kalkulatorischen Inventurdifferenz berechnet.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HFM_INVENTUR_TERMIN_OWG_WUP_ZU PRIMARY KEY (mandant_id, wup_id, nb_id, owg_id, arthiertyp_id, dat_plan_zaehlung, inventurart_int_id, dat_vorletzte_zaehlung) NOT ENFORCED
)  COMMENT = 'VIS: Excel-Upload (manuell erstellt durch FB) von Kennzahlen für das Reporting der Inventurergebnisse der Filialen.';
