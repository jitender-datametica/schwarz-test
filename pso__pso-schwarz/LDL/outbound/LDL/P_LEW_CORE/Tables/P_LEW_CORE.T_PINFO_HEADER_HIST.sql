/* --------------------------------------------------------------------------------
   DDL for table: t_pinfo_header_hist
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pinfo_header_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
pinfo_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description=' Surrogate Key PINFO HEADER'),
infnr STRING(20)
OPTIONS(description='Nummer des Einkaufsinfosatzes; SAP-Retail: eina.INFNR; SAP BW: 0info_rec_attr.INFNR'),
sup_sid BIGNUMERIC(38,0)
OPTIONS(description='Lieferant; FK auf SUPPLIER; SAP Retail: eina.LIFNR; SAP BW: 0info_rec_attr.LIFNR'),
item_sid BIGNUMERIC(38,0)
OPTIONS(description='Artikel; FK  auf ITEM; SAP Retail: eina.MATNR; SAP BW: 0info_rec_attr.MATNR'),
uom_sid_base BIGNUMERIC(38,0)
OPTIONS(description='Basismengeneinheit; FK auf UNIT OF MEASUREMENT; SAP Retail: eina.LMEIN; SAP BW: 0info_rec_attr.lmein'),
uom_sid_order BIGNUMERIC(38,0)
OPTIONS(description='Bestellmengeneinheit; FK auf UNIT OF MEASUREMENT; SAP Retail: eina.MEINS; SAP BW: 0info_rec_attr.meins'),
uom_cd_base STRING(20) OPTIONS(description='Basismengeneinheit; SAP Retail: eina.LMEIN; SAP BW: 0info_rec_attr.lmein'),
uom_cd_order STRING(20)
OPTIONS(description='Bestellmengeneinheit; SAP Retail: eina.MEINS; SAP BW: 0info_rec_attr.meins'),
main_supplier_fg BIGNUMERIC(38,0)
OPTIONS(description='Lieferant ist Regellieferant; SAP-Retail: eina.RELIF; SAP-BW: 0info_rec_attr.RELIF; eLWIS: t_s_einfo.rule_sup_fg'),
deliverable_from_dt DATE
OPTIONS(description='Lieferbar ab; SAP-Retail: eina.LIFAB; SAP-BW: 0info_rec_attr.LIFAB; eLWIS: t_s_einfo.avail_start_dat'),
deliverable_to_dt DATE
OPTIONS(description='Lieferbar bis; SAP-Retail: eina.LIFBI; SAP-BW: 0info_rec_attr.LIFBI; eLWIS: t_s_einfo.avail_end_dat'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Pinfo Header ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (pinfo_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. PINHH; Einkaufsinfosatz - allgemeine Daten;              SAP-Retail: eina;              SAP BW: 0info_rec_attr;             ELWIS: t_s_einfo');