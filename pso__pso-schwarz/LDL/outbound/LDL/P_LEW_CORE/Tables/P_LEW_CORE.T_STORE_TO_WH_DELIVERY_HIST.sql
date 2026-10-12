/* --------------------------------------------------------------------------------
   DDL for table: t_store_to_wh_delivery_hist
   generated from Powerdesigner on Mittwoch, 6. März 2024 09:51:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_store_to_wh_delivery_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Store; FK auf LOCATION; SAP-Retail: wrf3.locnr; SAP-BW: t_bw_0rt_wrf3_attr.werks'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferbetrieb (Bezugsquelle); FK auf LOCATION; SAP-Retail: wrf3.loclb; SAP-BW: t_bw_0rt_wrf3_attr.loclb'),
item_grp_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warengruppe (SUB ITEMGROUP der WAWI-Altwelt); FK auf ITEM GROUP; SAP-Retail: wrf3.matkl; SAP-BW: t_bw_0rt_wrf3_attr.matkl'),
item_grp_cd STRING(20) DEFAULT '@ALL' NOT NULL
OPTIONS(description='Warengruppe (Code); SAP-Retail: wrf3.matkl; SAP-BW: t_bw_0rt_wrf3_attr.matkl; ELWIS: -'),
priority BIGNUMERIC(38,0)
OPTIONS(description='Prioritaet der Lieferbeziehung (0=hoechste Prio; 1=zweithoechste Prio; etc.); SAP-Retail: wrf3.prioritaet; SAP-BW: t_bw_0rt_wrf3_attr.prioritaet; ELWIS: t_s_loc_loc_deliv.priority'),
active_from_dt DATE NOT NULL
OPTIONS(description='Lieferbeziehung gueltig ab; SAP-Retail: wrf3.datab; SAP-BW: t_bw_0rt_wrf3_attr.datab; ELWIS: t_s_loc_loc_deliv.loc_loc_valid_from_dat'),
active_to_dt DATE NOT NULL
OPTIONS(description='Lieferbeziehung gueltig bis; SAP-Retail: wrf3.datbi; SAP-BW: t_bw_0rt_wrf3_attr.datbi; ELWIS: t_s_loc_loc_deliv.loc_loc_valid_to_dat'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lieferbez. ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid_store, loc_sid_wh, item_grp_sid, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. STWDH; Lieferbez. zw. store & WHs; Pro Filiale & item group pot. mehrere aktive Lieferbez. - via Prio, ob Haupt- oder Nebenlieferbez.;             SAP-Retail: wrf3;             SAP-BW: t_bw_0rt_wrf3_attr;             ELWIS: t_s_loc_loc_deliv;             WAWI: t_org_store_skey');