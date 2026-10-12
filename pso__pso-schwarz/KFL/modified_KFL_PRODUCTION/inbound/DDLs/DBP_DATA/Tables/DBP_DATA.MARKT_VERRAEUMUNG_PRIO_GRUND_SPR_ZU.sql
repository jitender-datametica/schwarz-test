--==============================================================
-- Table: markt_verraeumung_prio_grund_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: markt_verraeumung_prio_grund_spr_zu
   generated from Powerdesigner on Freitag, 28. März 2025 10:02:19
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MARKT_VERRAEUMUNG_PRIO_GRUND_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   verraeumung_prio_grund_id           VARCHAR(2)       NOT NULL COMMENT 'ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.',
   verraeumung_prio_grund_bez          VARCHAR(200)     NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Verräumungs Prio Grund.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MARKT_VERRAEUMUNG_PRIO_GRUND_SPR_ZU PRIMARY KEY (mandant_id, verraeumung_prio_grund_id, spr_id) NOT ENFORCED
)  COMMENT = 'Sprachabhängige Bezeichnung der Verräumungs Prio Gründen in der Filiale. Quelle: SAP ZRS_LGBPRF_CUST';
