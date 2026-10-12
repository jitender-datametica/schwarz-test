/* --------------------------------------------------------------------------------
   DDL for table: t_pos_agg_sales_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_pos_agg_sales_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
aggr_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des POS-Aggregats; SAP-CAR: aggr_no'),
aggr_rec_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer des Aggregationssatzes innerhalb der Gruppe_2; SAP-CAR: record_no'),
aggr_rec_id BIGNUMERIC(38,0) OPTIONS(description='Satznummer, die auf Aggregatebene eindeutig vergeben wird; rec_id'),
aggr_grp_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer der Aggregationsgruppe; SAP-CAR: group_no'),
aggr_grp_key STRING(20) OPTIONS(description='Zusatzlicher Gruppierungsschluessel zur Verdichtung; SAP-CAR: grkey'),
loc_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Filiale; FK auf LOCATION_2; SAP-CAR: retailstoreid; ELWIS: global_loc_id'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2; FK auf ITEM_2; SAP-CAR: materialnumber; '),
uom_sid_sales BIGNUMERIC(38,0)
OPTIONS(description='Verkaufsmengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-CAR: salesuom; ELWIS: sale_uom'),
uom_sid_base BIGNUMERIC(38,0)
OPTIONS(description='Basismengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-CAR: baseuom; ELWIS: base_uom'),
curr_sid BIGNUMERIC(38,0)
OPTIONS(description='Transaktionswaehrung; FK auf CURRENCY; SAP-CAR: currency; ELWIS: trans_curr'),
item_cd STRING(20) OPTIONS(description='MATNR aus SAP-Retail/SAP-CAR; SAP-CAR: itemidqual / item_id; ELWIS: itm_ean_id'),
ean_cd STRING(20) OPTIONS(description='EAN_2-Nummer; SAP-CAR: itemidqual / item_id; ELWIS: itm_ean_id'),
receipt_type_sales_fg BIGNUMERIC(38,0)
OPTIONS(description='Belegtyp Sale; SAP-CAR: _type_: if (_type_ = S) then 1 else 0; ELWIS: sale_return_fg'),
receipt_type_returns_fg BIGNUMERIC(38,0)
OPTIONS(description='Belegtyp Retoure; SAP-CAR: _type_: if (_type_ = R) then 1 else 0; ELWIS: sale_return_fg'),
uom_cd_base STRING(20) OPTIONS(description='Basismengeneinheit; SAP-CAR: baseuom; ELWIS: base_uom'),
base_qty NUMERIC(18,5) OPTIONS(description='Menge in Basismengeneinheit; SAP-CAR: basequantity'),
uom_cd_sales STRING(20) OPTIONS(description='Verkaufsmengeneinheit; SAP-CAR: salesuom; ELWIS: sale_uom'),
sales_qty NUMERIC(18,5) OPTIONS(description='Menge in Verkaufsmengeneinheit; SAP-CAR: retailquantity'),
curr_cd STRING(20) OPTIONS(description='Transaktionswaehrung; SAP-CAR: currency; ELWIS: trans_curr'),
actual_unit_price NUMERIC(18,5) OPTIONS(description='Verkaufspreis des Artikels pro Einheit; SAP-CAR: actualunitprice'),
actual_sales_val NUMERIC(18,5) OPTIONS(description='tatsaechlicher Verkaufswert; SAP-CAR: salesamount'),
normal_sales_val NUMERIC(18,5) OPTIONS(description='normaler Verkaufswert; SAP-CAR: normalsalesamt'),
trans_start_tmsp DATETIME OPTIONS(description='SAP-CAR: trans_ts_min'),
trans_end_tmsp DATETIME OPTIONS(description='SAP-CAR: trans_ts_max'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Belegdatum / BON Datum; SAP-CAR: businessdaydate; ELWIS: record_dat'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid, dwh_cal_dt, aggr_nr, aggr_rec_nr, aggr_grp_nr) NOT ENFORCED
) CLUSTER BY dwh_cal_dt, client_id
OPTIONS(description='$Revision: 0000 $. POS-Aggregat Verkaufsdaten [Filiale, Tag_2, Artikel_2];             SAP CAR: z_ds_zpdx_aggr03_mis;             ELWIS: t_s_aggr03_mis');