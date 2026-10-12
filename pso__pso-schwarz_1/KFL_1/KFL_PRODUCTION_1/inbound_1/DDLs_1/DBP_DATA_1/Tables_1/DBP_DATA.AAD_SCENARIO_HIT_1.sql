--==============================================================
-- Table: aad_scenario_hit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_hit_1
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:35:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AAD_SCENARIO_HIT_1 (
   scenario_id                         NUMBER(38,0)     NOT NULL COMMENT 'Unique Identifier of the Scenario',
   bon_id                              VARCHAR(100)     NOT NULL COMMENT 'Eindeutige ID eines Bons, generierter Hashwert.',
   bon_dat                             DATE             NOT NULL COMMENT 'Checkoutdatum, auch Businessday bzw. Kassenkey.',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer, wird nicht gegen den Marktstamm geprüft.',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH - ein Mandant_1 pro Land.',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   bon_nr                              NUMBER(38,0)     COMMENT 'Die Bonnummer des Bons (ist eine_1 fortlaufende Nummer die in der Kasse generiert wird, im Normalfall ist diese Nummer pro Tag_1 und Kasse unique)',
   bon_booking                         TIMESTAMP_NTZ(9) COMMENT 'Buchungszeitpunkt des Bons, relevant z.Bsp. für artbew. Kann vom Bondatum abweichen, z.Bsp. wenn eine_1 Kasse offline war.',
   kasse_nr                            NUMBER(38,0)     COMMENT 'Nummer der Kasse.',
   hashed_cashier_id                   VARCHAR(255)     COMMENT 'Encrypted (hashed) Cashier ID',
   fraud_value_gross_local_val         NUMBER(18,4)     COMMENT 'Amount of the fraud',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Insert',
   dwh_updated_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'Auto generate by Update',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AAD_SCENARIO_HIT PRIMARY KEY (scenario_id, bon_id, bon_dat, wup_id, mandant_id) NOT ENFORCED
)  COMMENT = 'Contains the scenario hits - a relationship between receipts and potential fraud scenario';
