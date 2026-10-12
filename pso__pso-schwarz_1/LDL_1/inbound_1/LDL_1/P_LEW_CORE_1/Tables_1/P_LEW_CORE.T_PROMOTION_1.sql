/* --------------------------------------------------------------------------------
   DDL for table: t_promotion_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PROMOTION_1 CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   prom_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PROMOTION',
   src_aktnr                           VARCHAR(20)      COMMENT 'Aktionsschluessel (SAP-Retail); SAP-Retail: wakh.aktnr; SAP-BW: t_bw_0rt_promo_attr.aktnr',
   prom_name                           VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Aktionsbezeichnung; SAP-Retail: wakt.aktkt; SAP-BW: t_bw_0rt_promo_text.aktkt',
   promotion_class_mark                VARCHAR(20)      COMMENT 'Aktionsart - Code; SAP-Retail: wakh.akart; SAP-BW: t_bw_0rt_promo_attr.akart',
   promotion_class_label               VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Aktionsart - Beschreibung; 0004=Erw. Prsfindg Aktion_1;Z001=Ubergeordnete Aktion_1;Z002=Operative Aktion_1;Z003=Beschaffungsaktion',
   promotion_type_mark                 VARCHAR(20)      COMMENT 'Aktionstyp - Code; SAP-Retail: wakh.aktyp; SAP-BW: t_bw_0rt_promo_attr.aktyp',
   promotion_type_label                VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Aktionstyp - Beschreibung; 0001=Werbung Hauszeitung;0002=Verkaufsforderung;0003=Sonderprospekt;Z001=LIDL Handelsaktion',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PROMOTION PRIMARY KEY (prom_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. PROM; Aktionen; 
             SAP-Retail: wakh_1, wakt; 
             SAP-BW: t_bw_0rt_promo_attr, t_bw_0rt_promo_text;
             ELWIS: t_h_promotion;
             WAWI: ';

