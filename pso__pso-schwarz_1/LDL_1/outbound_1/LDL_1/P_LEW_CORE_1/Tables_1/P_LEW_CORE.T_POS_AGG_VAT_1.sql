/* --------------------------------------------------------------------------------
   DDL for table: t_pos_agg_vat_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_agg_vat_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
aggr_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer des POS-Aggregats; SAP-CAR: z_ds_zpdx_aggr31_mis.aggr_no; ELWIS: t_s_aggr31_mis_vat.aggr_nr'),
aggr_rec_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer des Aggregationssatzes innerhalb der Gruppe_1; SAP-CAR: z_ds_zpdx_aggr31_mis.record_no; ELWIS: t_s_aggr31_mis_vat.aggr_rec_nr'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Transaktionswaehrung; FK auf CURRENCY; SAP-CAR: z_ds_zpdx_aggr31_mis.currency; ELWIS: t_s_aggr31_mis_vat.trans_curr'),
curr_cd STRING(20) NOT NULL
OPTIONS(description='Transaktionswaehrung; SAP-CAR: z_ds_zpdx_aggr31_mis.currency; ELWIS: t_s_aggr31_mis_vat.trans_curr'),
tax_type_cd STRING(20) NOT NULL
OPTIONS(description='Typ fur Steuern (Steuerarten) - Codes selbst sind in POS DTA im Customizing gepflegt; SAP-CAR: z_ds_zpdx_aggr31_mis.taxtypecode; ELWIS: t_s_aggr31_mis_vat.tax_type_cd'),
tax_val NUMERIC(18,5)
OPTIONS(description='Wert des Steuertyps; SAP-CAR: z_ds_zpdx_aggr31_mis.taxsaleamt; ELWIS: t_s_aggr31_mis_vat.tax_sales_amt'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Datum Tagesabschluss; SAP-CAR: z_ds_zpdx_aggr31_mis.day_end_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, aggr_nr, aggr_rec_nr, tax_type_cd) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. POS-Aggregat Steuerdaten [Steuertyp, Wahrung];             SAP CAR: z_ds_zpdx_aggr31_mis;             ELWIS: t_s_aggr31_mis_vat');