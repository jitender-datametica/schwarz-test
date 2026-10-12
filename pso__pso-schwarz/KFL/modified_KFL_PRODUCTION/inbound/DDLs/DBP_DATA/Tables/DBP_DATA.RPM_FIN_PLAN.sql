--==============================================================
-- Table: rpm_fin_plan
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: rpm_fin_plan
   generated from Powerdesigner on Freitag, 23. September 2022 10:55:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RPM_FIN_PLAN (
   fin_gruppe_hierarchie_id            VARCHAR(32)     COLLATE 'en-ci' NOT NULL COMMENT 'Hierarchie ID der Finanzgruppe',
   dat_start                           DATE            NOT NULL COMMENT 'Startdatum aus period',
   rpm_plantyp_id                      INTEGER    NOT NULL COMMENT 'ID das Plantyps, z.Zt. zwischen 1 und 11',
   dat_von                             DATE            NOT NULL COMMENT 'Die Tabelle wird im DWH historisiert. Das Datum wird bei der Versorgung gesetzt',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   mandant_id                          INTEGER    COMMENT 'Mandant im DWH',
   betrag                              NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'geplanter Betrag aus amount',
   dat_bis                             DATE            NOT NULL COMMENT 'Die Tabelle wird im DWH historisiert. Das Datum wird bei der Versorgung gesetzt. Aktuelle Saetze haben das Datum 31.12.9999',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RPM_FIN_PLAN PRIMARY KEY (fin_gruppe_hierarchie_id, dat_start, rpm_plantyp_id, dat_von) NOT ENFORCED
)  COMMENT = 'RPM - Finanzplandaten für rpm-Elemente aus rpm_fin_plan';
