--==============================================================
-- Table: retail_company
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: retail_company
   generated from Powerdesigner on Freitag, 21. Februar 2025 12:34:58
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.RETAIL_COMPANY (
   ext_system_name                     VARCHAR(50)      NOT NULL COMMENT 'Name des (externen) Quellsystems, das Daten für Reviews liefert, z.B. predict42.',
   ext_retail_company_id               INTEGER     NOT NULL COMMENT 'ID des Einzelhändlers im externen System.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH.',
   retail_company_code                 VARCHAR(50)      NOT NULL COMMENT 'Code des Einzelhändlers, wie vom Quellsystem bereitgestellt.',
   retail_company_name                 VARCHAR(50)      NOT NULL COMMENT 'Name des Marktes.',
   competitor_fg                       INTEGER     NOT NULL COMMENT 'Flag, das angibt, ob es sich um ein Kaufland-Unternehmen (Wert 0) oder einen Mitbewerber (Wert 1) handelt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_RETAIL_COMPANY PRIMARY KEY (ext_system_name, ext_retail_company_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle enthält 1 Zeile pro Markt. Einschließlich Kaufland und Wettbewerber.';
