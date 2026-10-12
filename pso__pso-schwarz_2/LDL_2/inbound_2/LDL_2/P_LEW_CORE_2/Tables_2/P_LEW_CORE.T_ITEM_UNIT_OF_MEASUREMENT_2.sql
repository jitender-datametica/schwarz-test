/* --------------------------------------------------------------------------------
   DDL for table: t_item_unit_of_measurement_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_ITEM_UNIT_OF_MEASUREMENT_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
   item_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2; FK auf ITEM_2; SAP-Retail: marm.matnr; SAP-BW: t_bw_z_ds_marm.matnr',
   uom_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Mengeneinheit; FK auf UNIT_2 OF MEASUREMENT; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh',
   uom_cd                              VARCHAR(20)      COMMENT 'Mengeneinheit; SAP-Retail: marm.meinh; SAP-BW: t_bw_z_ds_marm.meinh',
   log_var_cd                          VARCHAR(20)      COMMENT 'Sammelartikel mit logistischen Varianten; SAP-Retail: marm.bflme_marm; SAP-BW: t_bw_z_ds_marm.bflme_marm; ELWIS: log_var_id',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_ITEM_UNIT_OF_MEASUREMENT PRIMARY KEY (item_sid, uom_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. IUOM; Mengeneinheiten zum Artikel_2; 
             SAP-Retail: marm_2; 
             SAP-BW: t_bw_z_ds_marm;
             ELWIS: t_s_itm_quantity_unit;
             WAWI: ';

