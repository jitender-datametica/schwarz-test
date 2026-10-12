--==============================================================
-- Table: wup_plan_kjmo_owg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_plan_kjmo_owg
   generated from Powerdesigner on Dienstag, 28. Januar 2025 09:55:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_PLAN_KJMO_OWG (
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   kjmo                                INTEGER     NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
   hwg_id                              INTEGER     NOT NULL COMMENT 'ID der Hauptwarengruppe',
   wrg_id                              VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_netto_plan                   NUMBER(29,2)     COMMENT 'geplanter Nettoumsatz / Umsatzplanwert',
   abschriften_netto_operativ_plan     NUMBER(29,2)     COMMENT 'Abschriftenplanwert für operative Abschriften. Total- + Preisabschriften',
   betrag_vk_netto_inventur_diff_plan  NUMBER(29,4)     COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_PLAN_KJMO_OWG PRIMARY KEY (wup_id, nb_id, mandant_id, kjmo, hwg_id) NOT ENFORCED
)  COMMENT = 'VIS - Planwerte pro Markt / Mandant / Monat / Haupwarengruppe (hwg)';
