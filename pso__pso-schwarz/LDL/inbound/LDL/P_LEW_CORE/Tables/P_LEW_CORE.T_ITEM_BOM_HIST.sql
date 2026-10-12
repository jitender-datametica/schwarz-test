/* --------------------------------------------------------------------------------
   DDL for table: t_item_bom_hist
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_BOM_HIST CLUSTER BY (CLIENT_ID) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   item_bom_sid                        NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key ITEM BOM',
   bom_alternative_cd                  VARCHAR(20)      COMMENT 'Stuecklistenalternative; siehe t_item_bom.src_stlal; nur bei Pfandgut (src_stlan / Verwendung = 7) bei Unterschieden (Alt. 1: Beschaffungsvariante; Alt. 2: Verkaufsartikel); SAP-Retail: mast.stlal; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stlal',
   version_counter                     NUMBER(38,0)     COMMENT 'Interner Zaehler; SAP-Retail: stko.stkoz; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.stkoz; ELWIS: t_s_itm_bom.stko_cnt',
   active_from_dt                      DATE             NOT NULL COMMENT 'Datum gueltig ab; stko.datuv; SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo.datuv; ELWIS: t_s_itm_bom.bom_valid_from_dat',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Item-BOM ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status angenommen',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_BOM_HIST PRIMARY KEY (item_bom_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IBOMH; Stucklistenkopf; 
             SAP-Retail: stko & mast; 
             SAP-BW: t_bw_z_ds_zmmx_v_mast_stpo;
             ELWIS: t_s_itm_bom
             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx#lzpWikiToC-topic-16';

