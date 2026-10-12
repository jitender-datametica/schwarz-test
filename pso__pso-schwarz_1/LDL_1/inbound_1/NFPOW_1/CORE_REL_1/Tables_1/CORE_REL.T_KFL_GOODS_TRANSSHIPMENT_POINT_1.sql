/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_goods_transshipment_point_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_KFL_GOODS_TRANSSHIPMENT_POINT_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   kfl_client_id                       NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL client (Mandant_1) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.mandant_id',
   kfl_gtp_nr                          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_id',
   kfl_gtp_subsidiary_type_id          NUMBER(38,0)     NOT NULL COMMENT 'identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.nb_id',
   kfl_country_cd                      VARCHAR(100)     NOT NULL COMMENT 'ISO code of the country_1 of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.land_id',
   active_from_dt                      DATE             COMMENT 'begin date of the validity_1 period of the GTP
            KFL: KFL_PRODUCTION.DBP_DATA.wup.dat_von',
   active_to_dt                        DATE             COMMENT 'end date of the validity_1 period of the GTP
            KFL: KFL_PRODUCTION.DBP_DATA.wup.dat_bis',
   sales_from_dt                       DATE             COMMENT 'opening date of the market, e.g. the date when the market has ben opened for customers to buy products
            KFL: KFL_PRODUCTION.DBP_DATA.wup.DAT_EROEFFNUNG',
   kfl_gtp_type_id                     NUMBER(38,0)     COMMENT 'identifier of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_typ_id',
   kfl_sales_gtp_name                  VARCHAR(160)     COMMENT 'name of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH (sales_1 department point of view)
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_name_v',
   kfl_purch_gtp_name                  VARCHAR(160)     COMMENT 'name of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH (purchase department point of view)
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_name_e',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_KFL_GOODS_TRANSSHIPMENT_POINT PRIMARY KEY (kfl_client_id, kfl_gtp_nr, kfl_gtp_subsidiary_type_id) NOT ENFORCED 
)  COMMENT = 'Kaufland goods transshipment point (Warenumschlagsplatz / WUP_1)
             KFL: KFL_PRODUCTION.DBP_DATA.WUP_1';

