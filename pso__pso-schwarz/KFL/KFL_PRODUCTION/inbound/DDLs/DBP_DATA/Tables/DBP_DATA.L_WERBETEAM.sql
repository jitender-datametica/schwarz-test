--==============================================================
-- Table: l_werbeteam
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbeteam
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBETEAM (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   werbeteam_cd                        VARCHAR(100)     NOT NULL COMMENT 'Code des Werbeteams',
   werbebereich_cd                     VARCHAR(100)     COMMENT 'Code des Werbebereichs',
   werbeteam_bez                       VARCHAR(100)     COMMENT 'Werbeteam - Bezeichnung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBETEAM PRIMARY KEY (mandant_id, werbeteam_cd) NOT ENFORCED
)  COMMENT = 'Fachlich verantwortliche Personen (auch Planer genannt) die für eine Kategorie an Artikel die über die WGs identifziert werden, die Werbungen in Deutschland planen.
             ';
