/* --------------------------------------------------------------------------------
   DDL for table: t_pick_list_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_PICK_LIST_2 CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Warehouse, FK auf LOCATION_2',
   pick_list_id                        NUMBER(38,0)     NOT NULL COMMENT 'Kommisionierscheinnummer',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Kommissionierscheindatum',
   pick_area_id                        NUMBER(38,0)     COMMENT 'Lagerzone / Kommissionierungsbereich',
   pick_order_cd                       VARCHAR(20)      COLLATE 'en-ci' COMMENT '? Auftragsnummer',
   loc_sid_store                       NUMBER(38,0)     NOT NULL COMMENT 'Store, fuer den die Ware kommissioniert wird, FK auf LOCATION_2',
   store_order_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Kundenbestelldatum/-uhrzeit',
   plan_method_cd                      VARCHAR(20)      COLLATE 'en-ci' COMMENT '? Verplanungsart: KOMZON, KOMAUF, KOMBAT',
   plan_status_cd                      VARCHAR(20)      COLLATE 'en-ci' COMMENT '? Status_2: Fertig, Warten, Bereit, ...',
   plan_host_status_cd                 VARCHAR(20)      COLLATE 'en-ci' COMMENT '? Host Status_2: Fertig, Senden, Neu, Storno, Rvanfrage',
   merged_fg                           NUMBER(38,0)     NOT NULL COMMENT '? Verschmolzen: 1=ja, 0=nein',
   performance_statistic_avail_cd      VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Leistungsstatistik erstellt?: OK, OFFEN',
   pick_priority_id                    NUMBER(38,0)     COMMENT 'Prioritaet des Kommissionierungsscheins',
   tour_client_cd                      VARCHAR(20)      COLLATE 'en-ci' COMMENT '? (nicht die bekannte client_id)',
   tour_cd                             VARCHAR(20)      COLLATE 'en-ci' COMMENT '? Tournummmer',
   destination_field_cd                VARCHAR(20)      COLLATE 'en-ci' COMMENT '? Feld',
   chain_cd                            VARCHAR(20)      COLLATE 'en-ci' COMMENT '?',
   chain_seq                           NUMBER(38,0)     COMMENT '?',
   chain_logic_id                      NUMBER(38,0)     COMMENT '?',
   delivery_tmsp                       TIMESTAMP_NTZ(9) COMMENT 'Liefer-Zeitpunkt',
   supply_tmsp                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Bereitstellungs-Zeitpunkt',
   pick_target_start_tmsp              TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Kommissionierung Soll-Startzeitpunkt',
   pick_start_dt                       DATE             NOT NULL COMMENT 'Kommissionierung Startdatum',
   pick_start_tmsp                     TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Kommissionierung Startzeitpunkt',
   pick_end_tmsp                       TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Kommissionierung Endzeitpunkt',
   target_pick_time_cnt                NUMBER(38,0)     COMMENT 'Soll-Dauer fur Kommissionierung',
   act_pick_time_cnt                   NUMBER(38,0)     COMMENT 'Ist-Dauer fur Kommissionierung',
   position_cnt                        NUMBER(38,0)     NOT NULL COMMENT 'Anzahl der zu kommissionierenden Positionen',
   position_processed_cnt              NUMBER(38,0)     NOT NULL COMMENT 'Anzahl bearbeiteter Positionen',
   target_pick_case_qty                NUMBER(18,5)     NOT NULL COMMENT '? Summe Soll-HE',
   act_pick_case_qty                   NUMBER(18,5)     NOT NULL COMMENT '? Summe Ist-HE',
   target_pick_te_qty                  NUMBER(18,5)     NOT NULL COMMENT '? Soll Anzahl TE',
   act_pick_te_qty                     NUMBER(18,5)     NOT NULL COMMENT '? Ist Anzahl TE',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_PICK_LIST PRIMARY KEY (client_id, loc_sid, pick_list_id, dwh_cal_dt) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Kommissionierliste - Kopf
             Liste von Artikeln, die fuer eine_2 Filialbelieferung kommissioniert werden.
             Jede Position auf der Liste enthaelt Infos zu jeweils einem Artikel_2 (siehe t_pick_list_pos_2).
             ...
             WAWI-DWH: t_picking_planhead';

