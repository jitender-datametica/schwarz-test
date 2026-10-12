--==============================================================
-- Table: gp_zusatz_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_zusatz_per_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_ZUSATZ_PER_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   dat_von                             DATE             NOT NULL COMMENT 'Gueltigkeitbeginn des Datensatzes;',
   dat_bis                             DATE             COMMENT 'Gueltigkeitsende des Datensatzes.',
   entgelt_mind_kz                     VARCHAR(1)       COMMENT 'Kennzeichen Entgeltminderungsvereinbarung (1 entspricht Entgeltminderung vereinbart).',
   ret_sperrprofil_id                  VARCHAR(3)       COMMENT 'Modus fuer Retourenabrechnung (z. B. GS fuer Gutschriftsabwicklung);',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_ZUSATZ_PER PRIMARY KEY (mandant_id, gp_id, einkaufsorganisation_id, dat_von) NOT ENFORCED
)  COMMENT = 'RPW - Zeitabhängige Informationen zu den Retouren eines Lieferanten aus den SAP Tabellen ZRP_RT_CONTR sowie ZRP_FEE_REDUCT.';
