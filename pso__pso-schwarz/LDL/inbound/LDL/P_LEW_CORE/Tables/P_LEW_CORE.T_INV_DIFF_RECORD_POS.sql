/* --------------------------------------------------------------------------------
   DDL for table: t_inv_diff_record_pos
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:09 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_INV_DIFF_RECORD_POS CLUSTER BY (
     CLIENT_ID,
     DWH_CAL_DT 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   record_year                         NUMBER(38,0)     NOT NULL COMMENT 'Belegjahr; SAP-BW: inventur.doc_year',
   record_cd                           VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Belegnummer; SAP-BW: inventur.mat_doc',
   record_pos_id                       NUMBER(38,0)     NOT NULL COMMENT 'Belegposition; SAP-BW: inventur.mat_item',
   record_pos_sub_id                   NUMBER(38,0)     NOT NULL COMMENT 'Belegsubposition; SAP-BW: inventur.zmbwcount',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'WH / Filiale; SAP-BW: inventur.plant',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel; SAP-BW: inventur.material',
   comp_sid                            NUMBER(38,0)     COMMENT 'Buchungskreis; FK auf COMPANY; SAP-BW: inventur.comp_code',
   sales_org_sid                       NUMBER(38,0)     COMMENT 'Verkaufsorganisation; FK auf SALES ORG; SAP-BW: inventur.salesorg',
   uom_sid                             NUMBER(38,0)     COMMENT 'Mengeneinheit der Inventurdifferenz; FK auf lew_core.t_unit_of_measurement; SAP-BW: inventur.zustvarme',
   curr_sid                            NUMBER(38,0)     COMMENT 'Belegwaehrung: Waehrung der bewerteten Inventurdifferenz; FK auf lew_core.t_currency; SAP-BW: inventur.doc_currcy',
   move_type_cd                        VARCHAR(20)      COMMENT 'Buchungsart (s. t_item_movement_record_pos); SAP-BW: inventur.movetyp',
   storage_loc_cd                      VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Lagerort innerhalb der Location; SAP-BW: inventur.stor_loc',
   inv_nr                              VARCHAR(20)      COLLATE 'en-ci' COMMENT 'zugehoerige Inventurnummer (falls vorhanden); SAP-BW: inventur.zminvnu1',
   inv_record_cd                       VARCHAR(20)      COLLATE 'en-ci' COMMENT 'zugehoerige Inventurbelegnummer (falls vorhanden); SAP-BW: inventur.zmiblnr',
   inv_dt                              DATE             COMMENT 'zugehoeriges Inventurdatum; SAP-BW: inventur.zmdzldat',
   inv_type_cd                         VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Inventurtyp (A=Vollinventur; B=Teilinventur; C=Gesellschaftsinitiierte Einzelinventur; D=Filialinitiierte Einzelinventur); SAP-BW: inventur.zmpidtype',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit der Inventurdifferenz; SAP-BW: inventur.zustvarme',
   inv_diff_qty                        NUMBER(18,5)     COMMENT 'Inventurdifferenz in Mengeneinheit uom_cd; SAP-BW: inventur.zaquantst',
   curr_cd                             VARCHAR(20)      COMMENT 'Belegwaehrung: Waehrung der bewerteten Inventurdifferenz; SAP-BW: inventur.doc_currcy',
   inv_diff_gross_val                  NUMBER(18,5)     COMMENT 'Inventurdifferenz bewertet mit durchschnittlichem VK-Preis brutto; SAP-BW: inventur.zkibvalu',
   inv_diff_net_val                    NUMBER(18,5)     COMMENT 'Inventurdifferenz bewertet mit durchschnittlichem VK-Preis netto; SAP-BW: inventur.zkinvalu',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Belegdatum; SAP-BW: inventur.calday',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_INV_DIFF_RECORD_POS PRIMARY KEY (client_id, record_year, record_cd, record_pos_id, record_pos_sub_id) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. Differenzwert im Vergleich zu einer Inventur;
             Jeder Eintrag repraesentiert eine Inventurwertveraenderung eines Artikels in einem WH/Filiale;
             SAP-Sprech: Materialbelege mit Inventurbezug
             SAP-Retail: mseg + weiteres;
             SAP-BW:  inventur';

