--==============================================================
-- Table: ts_wup_dat_leergut_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wup_dat_leergut_1
   generated from Powerdesigner on Dienstag, 25. März 2025 12:42:40
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WUP_DAT_LEERGUT_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer',
   nb_id                               INTEGER     NOT NULL COMMENT 'Nebenbetriebs ID, bei Märkten immer = 0',
   dat                                 DATE             NOT NULL COMMENT 'Datum der Zählung des Leerguts.',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   betrag_leergut_zaehlung             NUMBER(29,5)     COMMENT 'Hausleiter zählt regelmäßig das Leergut und trägt dann den Wert in Landeswährung ein. Wird von Frontend (Transaction) per update/insert gepflegt.',
   betrag_leergut_inventur             NUMBER(29,5)     COMMENT 'Inventurwert von Leergut. Wird DWH intern aus Inventuren befüllt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WUP_DAT_LEERGUT PRIMARY KEY (mandant_id, wup_id, nb_id, dat) NOT ENFORCED
)  COMMENT = 'Der Betrag des Leerguts in einer Filiale. Diese Information wird entweder durch eine_1 jährliche Inventur_1 oder eine_1 monatliche Zählung,die vom Hausleiter durchgeführt wird,bekannt. Wird per Transaction und per AbInitio befüllt.';
