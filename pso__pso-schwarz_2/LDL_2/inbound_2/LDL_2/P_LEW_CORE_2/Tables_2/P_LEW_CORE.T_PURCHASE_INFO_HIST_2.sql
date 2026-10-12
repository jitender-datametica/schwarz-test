/* --------------------------------------------------------------------------------
   DDL for table: t_purchase_info_hist_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PURCHASE_INFO_HIST_2 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   sup_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Lieferant; FK auf SUPPLIER_2; SAP-Retail: a017.lifnr; SAP-BW: z_ds_a017.lifnr',
   pur_org_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Einkaufsorganisation (transitiv mit loc_sid); FK auf PURCHASE_ORG; SAP-Retail: a017.ekorg; SAP-BW: z_ds_a017.ekorg',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: a017.matnr; SAP-BW: z_ds_a017.matnr',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrieb; FK auf LOCATION_2; SAP-Retail: a017.werks; SAP-BW: z_ds_a017.werks',
   pur_cond_sid                        NUMBER(38,0)     COMMENT 'Einkaufskondition; FK auf PURCHASE_COND; SAP-Retail: a017.knumh   ',
   cond_type_cd                        VARCHAR(20)      NOT NULL COMMENT 'Konditionstyp; SAP-Retail: a017.kschl; SAP-BW: z_ds_a017.kschl; ELWIS: t_s_pur_cond_a017.cond_type
            ',
   einfo_type_cd                       VARCHAR(20)      COMMENT 'Typ des Einkaufsinfosatzes; (AK-Teil); SAP-Retail: a017.esokz; SAP-BW: z_ds_a017.esokz; ELWIS: t_s_pur_cond_a017.einfo_type
            ',
   application_cd                      VARCHAR(20)      COMMENT 'Applikation; (AK-Teil - keine multiplen Attributsauspragungen); SAP-Retail: a017.kappl; SAP-BW: z_ds_a017.kappl; ELWIS: t_s_pur_cond_a017.cond_appl
            ',
   general_purchase_info_fg            NUMBER(38,0)     COMMENT 'Kennzeichnet allgemeingultige Infosatze. Kommt der Satz aus SAP-Retail-Tabelle A018_2 ist das Flag zu setzen',
   active_from_dt                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn des Konditionssatzes; SAP-Retail: a017.datab; SAP-BW: z_ds_a017.datab; ELWIS: t_s_pur_cond_a017.access_valid_from_dat',
   active_to_dt                        DATE             NOT NULL COMMENT 'Gueltigkeitsende des Konditionssatzes; AK-Teil; SAP-Retail: a017.datbi; SAP-BW: z_ds_a017.datbi; ELWIS: t_s_pur_cond_a017.access_valid_to_dat',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Purchase Info ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PURCHASE_INFO_HIST PRIMARY KEY (sup_sid, item_sid, loc_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PUINH; Artikelinfosatz;
             Verbindung zw. Einkaufsinfosaetzen (PINFO) und Kond-arten
             SAP-Retail: a017_2 & a018_2;
             SAP-BW: z_ds_a017 & z_ds_a018;
             ELWIS: t_s_pur_cond_a017 & t_s_pur_cond_a018
             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx';

