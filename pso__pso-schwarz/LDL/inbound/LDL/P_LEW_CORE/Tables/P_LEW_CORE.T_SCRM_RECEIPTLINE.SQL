CREATE TABLE P_LEW_CORE.T_SCRM_RECEIPTLINE  CLUSTER BY (DWH_CAL_DT)(
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)    NOT NULL COMMENT 'Filiale; FK auf LOCATION; SAP-CAR: z_ds_zpdx_tlogf.plant; WAWI-DWH: t_ejr_receiptline.store_id',
   register_id                         NUMBER(38,0)    NOT NULL COMMENT 'Kassennummer; WAWI-DWH: t_ejr_receiptline.pos_terminal_id',
   receipt_id                          NUMBER(38,0)    NOT NULL COMMENT 'Bon-Nummer; WAWI-DWH: t_ejr_receiptline.orig_receipt_nr_ejr',
   receiptline_nr                      NUMBER(38,0)    NOT NULL COMMENT 'Laufende Nummer auf Bon; WAWI-DWH: t_ejr_receiptline.orig_receipt_serial_nr_ejr',
   receipt_tmsp                        TIMESTAMP_NTZ(9) ,
   receiptline_voided                  NUMBER(38,0)    ,
   dwh_cal_dt                          DATE            NOT NULL COMMENT 'businessdaydate; WAWI-DWH: t_ejr_receiptline.dat_formdate',
   coupon_promo_sid                    NUMBER(38,0)    COMMENT 'unique identifier of the coupon_promotion (surrogate key)',
   src_coupon_promo_nr                 VARCHAR(100)    COMMENT 'identifier of the coupon_promotion within LidlPlus/SCRM source system SCRM: external_id',
   src_discount_nr                     VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'auf EJR befindliche Nachlassnummer (Business Key)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
)
COMMENT = '$Revision: 0000 $. table contains receiptline key columns related to certain coupon_promotions which have been identified by SCRM';

 

