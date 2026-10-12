/* --------------------------------------------------------------------------------
   DDL for table: t_promotion
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_promotion (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
prom_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PROMOTION'),
src_aktnr STRING(20)
OPTIONS(description='Aktionsschluessel (SAP-Retail); SAP-Retail: wakh.aktnr; SAP-BW: t_bw_0rt_promo_attr.aktnr'),
prom_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Aktionsbezeichnung; SAP-Retail: wakt.aktkt; SAP-BW: t_bw_0rt_promo_text.aktkt'),
promotion_class_mark STRING(20)
OPTIONS(description='Aktionsart - Code; SAP-Retail: wakh.akart; SAP-BW: t_bw_0rt_promo_attr.akart'),
promotion_class_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Aktionsart - Beschreibung; 0004=Erw. Prsfindg Aktion;Z001=Ubergeordnete Aktion;Z002=Operative Aktion;Z003=Beschaffungsaktion'),
promotion_type_mark STRING(20)
OPTIONS(description='Aktionstyp - Code; SAP-Retail: wakh.aktyp; SAP-BW: t_bw_0rt_promo_attr.aktyp'),
promotion_type_label STRING(100) COLLATE 'und:ci'
OPTIONS(description='Aktionstyp - Beschreibung; 0001=Werbung Hauszeitung;0002=Verkaufsforderung;0003=Sonderprospekt;Z001=LIDL Handelsaktion'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (prom_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PROM; Aktionen;              SAP-Retail: wakh, wakt;              SAP-BW: t_bw_0rt_promo_attr, t_bw_0rt_promo_text;             ELWIS: t_h_promotion;             WAWI: ');