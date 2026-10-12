/* --------------------------------------------------------------------------------
   DDL for table: t_pinfo_header
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pinfo_header (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
pinfo_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key PINFO'),
src_infnr STRING(20)
OPTIONS(description='Nummer des Einkaufsinfosatzes; SAP-Retail: eina.INFNR; SAP-BW: 0info_rec_attr.INFNR'),
sup_sid BIGNUMERIC(38,0)
OPTIONS(description='Lieferant; FK auf SUPPLIER; SAP-Retail: eina.LIFNR; SAP-BW: 0info_rec_attr.LIFNR'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel; FK  auf ITEM; SAP-Retail: eina.MATNR; SAP-BW: 0info_rec_attr.MATNR'),
sap_creation_dt DATE
OPTIONS(description='Erstellungsdatum in SAP-Retail; SAP-Retail: eina.ERDAT; SAP-BW: 0info_rec_attr.erdat; eLWIS: t_s_einfo.rec_ins_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pinfo_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PINH; Einkaufsinfosatz - allgemeine Daten;              SAP-Retail: eina;              SAP BW: 0info_rec_attr;             ELWIS: t_s_einfo');