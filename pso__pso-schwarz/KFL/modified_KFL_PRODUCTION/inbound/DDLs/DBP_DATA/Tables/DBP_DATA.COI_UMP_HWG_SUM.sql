--==============================================================
-- Table: coi_ump_hwg_sum
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: coi_ump_hwg_sum
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.COI_UMP_HWG_SUM (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'WUP_ID entspricht der Marktnummer / Fililalnummer in SAP (WERKS)',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   dat                                 DATE             NOT NULL COMMENT 'Datumswert des Umsatzes',
   hwg_id                              INTEGER     NOT NULL COMMENT 'ID der Hauptwarengruppe',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   umsatz_netto                        NUMBER(29,4)     NOT NULL COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_COI_UMP_HWG_SUM PRIMARY KEY (mandant_id, wup_id, nb_id, dat, hwg_id) NOT ENFORCED
)  COMMENT = 'WWC - COI Umsatzplanung - Aggregat für BE';

