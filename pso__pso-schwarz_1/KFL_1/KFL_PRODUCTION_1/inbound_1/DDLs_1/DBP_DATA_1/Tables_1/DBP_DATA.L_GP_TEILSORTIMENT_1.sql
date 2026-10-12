--==============================================================
-- Table: l_gp_teilsortiment_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_gp_teilsortiment_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:11:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_GP_TEILSORTIMENT_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   gp_teilsortiment_id                 VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Teilsortiment aus SAP ltsnr',
   einkaufsorganisation_id             NUMBER(38,0)     NOT NULL COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
   zahlungsziel_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Zahlungsziel  aus lfm2.zterm',
   zek_id                              VARCHAR(3)       NOT NULL COMMENT 'Einkäufergruppe aus lfm2.ekgrp',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_GP_TEILSORTIMENT PRIMARY KEY (mandant_id, gp_id, gp_teilsortiment_id, einkaufsorganisation_id) NOT ENFORCED
)  COMMENT = 'AIS_KMO- Lookup-Tabelle der Teilsortimente pro Lieferant aus den Quellen SAP wyt1t_1 und lfm2_1';
