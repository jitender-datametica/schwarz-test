CREATE TABLE P_LEW_BIL.t_store_day_item_price_change CLUSTER BY (client_id, dwh_cal_dt) (
    client_id                     NUMBER(38,0)                COMMENT 'Client identifier',
    loc_sid_store                 NUMBER(38,0)                COMMENT 'Store identifier',
    dwh_cal_dt                    DATE                        COMMENT 'Record date',
    orig_item_nr                  NUMBER(18,0)                COMMENT 'Item number',
    item_sid                      NUMBER(38,0)                COMMENT 'Item identifier',
	pcwo_reason_id                NUMBER(38,0)                COMMENT 'pcwo_reason_id',
	pcwo_reason_desc              VARCHAR(50) COLLATE 'en-ci' COMMENT 'pcwo_reason_desc',
    pch_day_pricegroup_fg         NUMBER                      COMMENT 'PV Tag Preisschienen',
    discount_value_promodesigner  NUMBER(38,11)               COMMENT 'Promowert vom PromoDesigner, local currency',
    discount_value_lidlplus       NUMBER(38,11)               COMMENT 'Promowert vom LidlPlus, local currency',
    pch_baseline_fg               NUMBER                      COMMENT 'Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)',
    dwh_load_id                   NUMBER(38,0)     NOT NULL   COMMENT 'DWH load identifier',
    dwh_created                   TIMESTAMP_LTZ(9) NOT NULL   COMMENT 'Timestamp record created',
    dwh_updated                   TIMESTAMP_LTZ(9) NOT NULL   COMMENT 'Timestamp record created',
    CONSTRAINT PK_T_STORE_DAY_ITEM_PRICE_CHANGE PRIMARY KEY (client_id, loc_sid_store, dwh_cal_dt, item_sid) NOT ENFORCED
) COMMENT = 'Price change (PV) days found on store-day-item level, based on logic delivered by business'
;
