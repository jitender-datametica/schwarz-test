--==============================================================
-- Table: coi_ump_hwg_sum_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_hwg_sum_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_HWG_SUM_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'Datumswert des Umsatzes',
   hwg_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Hauptwarengruppe',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_netto                        NUMBER(18,4)     NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_HWG_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, dat, hwg_id) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Aggregat für BE';

