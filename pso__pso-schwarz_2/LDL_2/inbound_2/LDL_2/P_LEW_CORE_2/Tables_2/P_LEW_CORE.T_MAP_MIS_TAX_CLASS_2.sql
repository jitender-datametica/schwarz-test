/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_tax_class_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MAP_MIS_TAX_CLASS_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   tax_class_cd                        VARCHAR(20)      NOT NULL COMMENT 'ELWIS: tax_class; pendant: t_item_tax_country_hist_2',
   mis_vat_id                          NUMBER(38,0)     NOT NULL COMMENT 'ELWIS: vat_id',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MAP_MIS_TAX_CLASS PRIMARY KEY (client_id, tax_class_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Tabelle zur Ermittlung des MIS-VAT-ID;
             Inhalt wird manuell gepflegt;
             ELWIS: t_s_tax_class_map_mis';

