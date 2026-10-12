--==============================================================
-- Table: in_kosten_prognose
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_kosten_prognose
   generated from Powerdesigner on Mittwoch, 24. April 2024 15:12:21
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_KOSTEN_PROGNOSE (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   in_projekt_id                       NUMBER(38,0)     NOT NULL COMMENT 'Projektdefinition (intern) aus pspnr',
   psp_id                              NUMBER(38,0)     NOT NULL COMMENT 'eindeutiger numerischer Schlüssel eines PSP-Elements. Im DWH generierte PSP-Elemente haben ein negatives Vorzeichen',
   in_wg_id                            VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Warengruppe aus dem Industriesystem. Quelle ist matkl',
   kosten_prognose_version_id          VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Kostenprognose Version aus zz_kos_kopvers',
   betrag_kosten_prognose              NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Wert der Kostenprognose aus zz_kos_kopwert',
   betrag_mmk_prognose                 NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Mehr- Minderkosten-Schätzung aus zz_kos_mmkwer',
   betrag_zea_prognose                 NUMBER(38,4)     NOT NULL DEFAULT 0 COMMENT 'Wert offene Aufträge aus ZEA (EinzelAbruf) Quellfeld ist zz_kos_zeawer',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   dat_kosten_prognose_version         DATE             NOT NULL DEFAULT CAST('1900-01-01' AS DATE) COMMENT 'ZZ_KOS_KOPDAT - Datum der Kostenprognose (zur Version_ID)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_KOSTEN_PROGNOSE PRIMARY KEY (mandant_id, in_projekt_id, psp_id, in_wg_id, kosten_prognose_version_id) NOT ENFORCED
)  COMMENT = 'IOS - Tabelle der Kostenprognosen aus der Quelle zfm_kostenprog';