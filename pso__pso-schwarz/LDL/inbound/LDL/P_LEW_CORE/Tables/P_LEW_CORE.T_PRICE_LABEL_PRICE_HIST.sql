CREATE TABLE P_LEW_CORE.T_PRICE_LABEL_PRICE_HIST (
   ELECTRONIC_PRICE_LABEL_TYPE_CD      VARCHAR(100)     NOT NULL COMMENT 'The code indicating the price label type.',
   PRICE_LABEL_PRODUCER_NAME           VARCHAR(100)     NOT NULL COMMENT 'The name of the company that manufactures price labels.',
   CURR_ISO_CD                         VARCHAR(3)       NOT NULL COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
   NET_PRICE                           NUMBER(38,5)     COMMENT 'Netto price in given currency.',
   DELETED_FG                          NUMBER(38,0)     NOT NULL COMMENT 'Artikel ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   DWH_VALID_FROM                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   DWH_VALID_TO                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   DWH_LOAD_ID                         NUMBER(38,0)     NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',   
   CONSTRAINT PK_T_PRICE_LABEL_PRICE_HIST PRIMARY KEY (ELECTRONIC_PRICE_LABEL_TYPE_CD, PRICE_LABEL_PRODUCER_NAME, DWH_VALID_FROM) NOT ENFORCED 
)  COMMENT = 'Contains prices of the price shields themselves. Currently contains only prices of electronic price label shields in USD.
             Source: Manual (ESL)';
