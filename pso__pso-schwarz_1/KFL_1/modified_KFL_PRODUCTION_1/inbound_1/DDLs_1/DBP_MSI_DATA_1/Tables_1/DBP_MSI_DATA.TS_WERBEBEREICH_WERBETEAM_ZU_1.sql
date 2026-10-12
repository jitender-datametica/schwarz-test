--==============================================================
-- Table: ts_werbebereich_werbeteam_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_werbebereich_werbeteam_zu_1
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WERBEBEREICH_WERBETEAM_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wg_id                               INTEGER     NOT NULL COMMENT 'ID der Warengruppe.',
   werbebereich_cd                     VARCHAR(100)     COMMENT 'Code des Werbebereichs.',
   werbeteam_cd                        VARCHAR(100)     COMMENT 'Code des Werbeteams',
   werbeteam_bez                       VARCHAR(100)     COMMENT 'Werbeteam - Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WERBEBEREICH_WERBETEAM_ZU PRIMARY KEY (mandant_id, wg_id) NOT ENFORCED
)  COMMENT = 'Transaktionservice Tabelle mit Informationen über Werbebereich und Werbeteam einer Warengruppe.';
