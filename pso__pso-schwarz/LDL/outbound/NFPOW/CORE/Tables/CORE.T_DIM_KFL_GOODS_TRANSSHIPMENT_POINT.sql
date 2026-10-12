/* --------------------------------------------------------------------------------
   DDL for table: t_dim_kfl_goods_transshipment_point
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_kfl_goods_transshipment_point (
lob_cd STRING(100) NOT NULL
OPTIONS(description='line of business depends on the general source of the data, \'KFL\' if the data is taken from the Kaufland DWH, \'LDL\' if the data is taken from a Lidl DWH'),
kfl_client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the KFL client (Mandant) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.mandant_id
            CORE_REL: t_kfl_goods_transshipment_point.kfl_client_id'''),
kfl_gtp_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_id
            CORE_REL: t_kfl_goods_transshipment_point.kfl_gtp_nr'''),
kfl_gtp_subsidiary_type_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''identifier of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.nb_id
            CORE_REL: t_kfl_goods_transshipment_point.kfl_gtp_subsidiary_type_id'''),
lob_name STRING(100)
OPTIONS(description='''name of the line of business
            CORE_REL: t_line_of_business.lob_name'''),
kfl_client_cd STRING(100) NOT NULL
OPTIONS(description='''code of the KFL client (Mandant) in the Kaufland DWH, for example \'PL\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_kbez
            CORE_REL: t_kfl_client.kfl_client_cd'''),
kfl_client_name STRING(100) NOT NULL
OPTIONS(description='''name of the KFL client (Mandant) in the Kaufland DWH for example \'Polen\'
            KFL: KFL_PRODUCTION.DBP_DATA.mandant.mandant_bez
            CORE_REL: t_kfl_client.kfl_client_name'''),
kfl_gtp_subsidiary_type_name STRING(100)
OPTIONS(description='''name of the subsidiary type (Nebenstelle) of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.nb.NB_BEZ
            CORE_REL: t_kfl_gtp_subsidiary_type.kfl_gtp_subsidiary_type_name'''),
kfl_country_cd STRING(100) NOT NULL
OPTIONS(description='''ISO code of the country of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.land_id
            CORE_REL: t_kfl_goods_transshipment_point.kfl_country_cd'''),
kfl_country_name STRING(100)
OPTIONS(description='''name of the country of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.land.LAND_BEZ
            CORE_REL: t_kfl_client_country.kfl_country_name'''),
active_from_dt DATE
OPTIONS(description='''begin date of the validity period of the GTP
            KFL: KFL_PRODUCTION.DBP_DATA.wup.dat_von
            CORE_REL: t_kfl_goods_transshipment_point.active_from_dt'''),
active_to_dt DATE
OPTIONS(description='''end date of the validity period of the GTP
            KFL: KFL_PRODUCTION.DBP_DATA.wup.dat_bis
            CORE_REL: t_kfl_goods_transshipment_point.active_to_dt'''),
sales_from_dt DATE
OPTIONS(description='''opening date of the market, e.g. the date when the market has ben opened for customers to buy products
            KFL: KFL_PRODUCTION.DBP_DATA.wup.DAT_EROEFFNUNG
            CORE_REL: t_kfl_goods_transshipment_point.sales_from_dt'''),
kfl_gtp_type_id BIGNUMERIC(38,0)
OPTIONS(description='''identifier of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_typ_id
            CORE_REL: t_kfl_goods_transshipment_point.kfl_gtp_type_id'''),
kfl_gtp_type_name STRING(100)
OPTIONS(description='''name of the type of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH
            KFL: KFL_PRODUCTION.DBP_DATA.WUP_TYP.WUP_TYP_BEZ
            CORE_REL: t_kfl_gtp_type.kfl_gtp_type_name'''),
kfl_sales_gtp_name STRING(160)
OPTIONS(description='''name of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH (sales department point of view)
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_name_v
            CORE_REL: t_kfl_goods_transshipment_point.kfl_sales_gtp_name'''),
kfl_purch_gtp_name STRING(160)
OPTIONS(description='''name of the KFL goods transshipment point (Warenumschlagsplatz) in the Kaufland DWH (purchase department point of view)
            KFL: KFL_PRODUCTION.DBP_DATA.wup.wup_name_e
            CORE_REL: t_kfl_goods_transshipment_point.kfl_purch_gtp_name'''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, kfl_client_id, kfl_gtp_nr, kfl_gtp_subsidiary_type_id) NOT ENFORCED
)
OPTIONS(description='''Kaufland goods transshipment point (Warenumschlagsplatz / WUP)
             KFL: KFL_PRODUCTION.DBP_DATA.WUP
             CORE_REL: T_KFL_GOODS_TRANSSHIPMENT_POINT''');