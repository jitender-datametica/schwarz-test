/* --------------------------------------------------------------------------------
   DDL for table: t_pos_agg_sales_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_POS_AGG_SALES_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   aggr_nr                             NUMBER(38,0)     NOT NULL COMMENT 'Nummer des POS-Aggregats; SAP-CAR: aggr_no',
   aggr_rec_nr                         NUMBER(38,0)     NOT NULL COMMENT 'Nummer des Aggregationssatzes innerhalb der Gruppe_1; SAP-CAR: record_no',
   aggr_rec_id                         NUMBER(38,0)     COMMENT 'Satznummer, die auf Aggregatebene eindeutig vergeben wird; rec_id',
   aggr_grp_nr                         NUMBER(38,0)     NOT NULL COMMENT 'Nummer der Aggregationsgruppe; SAP-CAR: group_no',
   aggr_grp_key                        VARCHAR(20)      COMMENT 'Zusatzlicher Gruppierungsschluessel zur Verdichtung; SAP-CAR: grkey',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Filiale; FK auf LOCATION_1; SAP-CAR: retailstoreid; ELWIS: global_loc_id',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1; FK auf ITEM_1; SAP-CAR: materialnumber; ',
   uom_sid_sales                       NUMBER(38,0)     COMMENT 'Verkaufsmengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-CAR: salesuom; ELWIS: sale_uom',
   uom_sid_base                        NUMBER(38,0)     COMMENT 'Basismengeneinheit; FK auf UNIT_1 OF MEASUREMENT; SAP-CAR: baseuom; ELWIS: base_uom',
   curr_sid                            NUMBER(38,0)     COMMENT 'Transaktionswaehrung; FK auf CURRENCY; SAP-CAR: currency; ELWIS: trans_curr',
   item_cd                             VARCHAR(20)      COMMENT 'MATNR aus SAP-Retail/SAP-CAR; SAP-CAR: itemidqual / item_id; ELWIS: itm_ean_id',
   ean_cd                              VARCHAR(20)      COMMENT 'EAN_1-Nummer; SAP-CAR: itemidqual / item_id; ELWIS: itm_ean_id',
   receipt_type_sales_fg               NUMBER(38,0)     COMMENT 'Belegtyp Sale; SAP-CAR: _type_: if (_type_ = S) then 1 else 0; ELWIS: sale_return_fg',
   receipt_type_returns_fg             NUMBER(38,0)     COMMENT 'Belegtyp Retoure; SAP-CAR: _type_: if (_type_ = R) then 1 else 0; ELWIS: sale_return_fg',
   uom_cd_base                         VARCHAR(20)      COMMENT 'Basismengeneinheit; SAP-CAR: baseuom; ELWIS: base_uom',
   base_qty                            NUMBER(18,5)     COMMENT 'Menge in Basismengeneinheit; SAP-CAR: basequantity',
   uom_cd_sales                        VARCHAR(20)      COMMENT 'Verkaufsmengeneinheit; SAP-CAR: salesuom; ELWIS: sale_uom',
   sales_qty                           NUMBER(18,5)     COMMENT 'Menge in Verkaufsmengeneinheit; SAP-CAR: retailquantity',
   curr_cd                             VARCHAR(20)      COMMENT 'Transaktionswaehrung; SAP-CAR: currency; ELWIS: trans_curr',
   actual_unit_price                   NUMBER(18,5)     COMMENT 'Verkaufspreis des Artikels pro Einheit; SAP-CAR: actualunitprice',
   actual_sales_val                    NUMBER(18,5)     COMMENT 'tatsaechlicher Verkaufswert; SAP-CAR: salesamount',
   normal_sales_val                    NUMBER(18,5)     COMMENT 'normaler Verkaufswert; SAP-CAR: normalsalesamt',
   trans_start_tmsp                    TIMESTAMP_NTZ(9) COMMENT 'SAP-CAR: trans_ts_min',
   trans_end_tmsp                      TIMESTAMP_NTZ(9) COMMENT 'SAP-CAR: trans_ts_max',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum / BON Datum; SAP-CAR: businessdaydate; ELWIS: record_dat',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_POS_AGG_SALES PRIMARY KEY (loc_sid, dwh_cal_dt, aggr_nr, aggr_rec_nr, aggr_grp_nr) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. POS-Aggregat Verkaufsdaten [Filiale, Tag_1, Artikel_1];
             SAP CAR: z_ds_zpdx_aggr03_mis;
             ELWIS: t_s_aggr03_mis';

