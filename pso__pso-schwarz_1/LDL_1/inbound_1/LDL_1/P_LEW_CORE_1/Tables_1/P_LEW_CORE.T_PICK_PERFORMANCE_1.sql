/* --------------------------------------------------------------------------------
   DDL for table: t_pick_performance_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PICK_PERFORMANCE_1 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_1; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key LOCATION_1 (eindeutig ueber alle Laender/Mandanten hinweg)',
   pick_list_id                        NUMBER(38,0)     NOT NULL COMMENT 'Kommisionsscheinnummer',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Zuordnungs-Datum der Leistung (identisch zu pick_list_dt, was letztlich der Tag_1 ist, an dem die Liste per Tagesabschluss verarbeitet wurde)',
   performance_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zuordnungs-Zeitpunkt der Leistung',
   performance_type_cd                 VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Leistungs-Art_1: MIN15, STD, MON, TAG_1, JAHR',
   performance_grp_cd                  VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Leistungs-Gruppe_1: Funk, Unknown',
   performance_cd                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT '? Leistung: KOM, SUM',
   pick_area_id                        NUMBER(38,0)     NOT NULL COMMENT 'Lagerzone',
   transport_method_cd                 VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Transportmittel, mit dem komm. wurde',
   target_time_cnt                     NUMBER(38,0)     NOT NULL COMMENT 'Vorgabe Kommissionier-Dauer',
   working_time_cnt                    NUMBER(38,0)     NOT NULL COMMENT '? Arbeits-Dauer',
   lead_time_cnt                       NUMBER(38,0)     NOT NULL COMMENT '? Vorlauf-Dauer',
   lag_time_cnt                        NUMBER(38,0)     NOT NULL COMMENT '? Nachlauf-Dauer',
   break_time_cnt                      NUMBER(18,5)     NOT NULL COMMENT '? Pausen-Dauer',
   extra_time_cnt                      NUMBER(38,0)     NOT NULL COMMENT '? Sonstige-Zeit_1-Dauer',
   days_cnt                            NUMBER(38,0)     NOT NULL COMMENT 'Anzahl Tage',
   hours_cnt                           NUMBER(38,0)     NOT NULL COMMENT 'Anzahl Std',
   staff_cnt                           NUMBER(38,0)     NOT NULL COMMENT 'Anzahl MA',
   break_cnt                           NUMBER(38,0)     NOT NULL COMMENT 'Anzahl Pause',
   order_cnt                           NUMBER(38,0)     NOT NULL COMMENT 'Anzahl Bestellungen',
   position_total_cnt                  NUMBER(38,0)     NOT NULL COMMENT 'Anzahl Kommissionier-Positionen',
   target_pick_te_qty                  NUMBER(18,5)     NOT NULL COMMENT '? Anzahl TE',
   act_pick_te_qty                     NUMBER(18,5)     NOT NULL COMMENT '? Tatsaechliche ',
   target_pick_case_qty                NUMBER(18,5)     NOT NULL COMMENT '? ',
   act_pick_case_qty                   NUMBER(18,5)     NOT NULL COMMENT '? ',
   total_weight_gross_qty              NUMBER(18,5)     NOT NULL COMMENT 'Gesamtgewicht brutto',
   total_weight_net_qty                NUMBER(18,5)     NOT NULL COMMENT 'Gesamtgewicht netto',
   act_handhe_cnt                      NUMBER(38,0)     NOT NULL COMMENT '?',
   act_entry_thm_cnt                   NUMBER(38,0)     NOT NULL COMMENT '?',
   act_orig_thm_cnt                    NUMBER(18,5)     NOT NULL COMMENT '?',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PICK_PERFORMANCE PRIMARY KEY (client_id, loc_sid, pick_list_id, performance_type_cd, performance_tmsp, performance_grp_cd, performance_cd, pick_area_id, transport_method_cd, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Kommissionierleistung(en) pro Kommissionierschein
             Die originale Granularitaet Kommissionierer wurde auf die vorliegende Granularitaet verdichtet
             ...
             WAWI-DWH: t_picking_performance';

