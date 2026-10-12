/* --------------------------------------------------------------------------------
   DDL for table: t_pinfo_header_hist
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PINFO_HEADER_HIST CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   pinfo_sid                           NUMBER(38,0)     NOT NULL COMMENT ' Surrogate Key PINFO HEADER',
   infnr                               VARCHAR(20)      COMMENT 'Nummer des Einkaufsinfosatzes; SAP-Retail: eina.INFNR; SAP BW: 0info_rec_attr.INFNR',
   sup_sid                             NUMBER(38,0)     COMMENT 'Lieferant; FK auf SUPPLIER; SAP Retail: eina.LIFNR; SAP BW: 0info_rec_attr.LIFNR',
   item_sid                            NUMBER(38,0)     COMMENT 'Artikel; FK  auf ITEM; SAP Retail: eina.MATNR; SAP BW: 0info_rec_attr.MATNR',
   uom_sid_base                        NUMBER(38,0)     COMMENT 'Basismengeneinheit; FK auf UNIT OF MEASUREMENT; SAP Retail: eina.LMEIN; SAP BW: 0info_rec_attr.lmein',
   uom_sid_order                       NUMBER(38,0)     COMMENT 'Bestellmengeneinheit; FK auf UNIT OF MEASUREMENT; SAP Retail: eina.MEINS; SAP BW: 0info_rec_attr.meins',
   uom_cd_base                         VARCHAR(20)      COMMENT 'Basismengeneinheit; SAP Retail: eina.LMEIN; SAP BW: 0info_rec_attr.lmein',
   uom_cd_order                        VARCHAR(20)      COMMENT 'Bestellmengeneinheit; SAP Retail: eina.MEINS; SAP BW: 0info_rec_attr.meins',
   main_supplier_fg                    NUMBER(38,0)     COMMENT 'Lieferant ist Regellieferant; SAP-Retail: eina.RELIF; SAP-BW: 0info_rec_attr.RELIF; eLWIS: t_s_einfo.rule_sup_fg',
   deliverable_from_dt                 DATE             COMMENT 'Lieferbar ab; SAP-Retail: eina.LIFAB; SAP-BW: 0info_rec_attr.LIFAB; eLWIS: t_s_einfo.avail_start_dat',
   deliverable_to_dt                   DATE             COMMENT 'Lieferbar bis; SAP-Retail: eina.LIFBI; SAP-BW: 0info_rec_attr.LIFBI; eLWIS: t_s_einfo.avail_end_dat',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Pinfo Header ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PINFO_HEADER_HIST PRIMARY KEY (pinfo_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PINHH; Einkaufsinfosatz - allgemeine Daten; 
             SAP-Retail: eina; 
             SAP BW: 0info_rec_attr;
             ELWIS: t_s_einfo';

