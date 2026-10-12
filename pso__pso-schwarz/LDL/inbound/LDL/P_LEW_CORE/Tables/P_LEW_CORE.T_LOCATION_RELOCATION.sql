/* --------------------------------------------------------------------------------
   DDL for table: t_location_relocation
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LOCATION_RELOCATION CLUSTER BY (
     DWH_CAL_DT,
     CLIENT_ID 
) (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'DWH-Mandant; FK auf CLIENT',
   loc_sid                             NUMBER(38,0)     NOT NULL COMMENT 'Betrachtete Lokation; FK auf LOCATION',
   loc_sid_following                   NUMBER(38,0)     COMMENT 'Aktuelle Lokation nach Untergang der betrachteten Lokation (Fusionsgewinner) oder identisch zur betrachteten Lokation, solang diese aktiv. ',
   dwh_cal_dt                          DATE             NOT NULL COMMENT 'Fusionszeitpunkt oder Ur-Erfassungszeitpunkt (Bei unbekannter Urerfassung "01.01.1900")',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_LOCATION_RELOCATION PRIMARY KEY (loc_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. LRLO; Stellt die Fusionen der Locations dar. ;
             WAWI: t_org_store_reloc
             ';

