/* --------------------------------------------------------------------------------
   DDL for table: t_ref_bakeoff_oven_chamber_event_type
   generated from Powerdesigner on Montag, 6. Oktober 2025 15:39:27
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_BAKEOFF_OVEN_CHAMBER_EVENT_TYPE (
   bakeoff_oven_chamber_event_type_cd  VARCHAR(100)     NOT NULL COMMENT 'The unique code for the type of the event in an oven chamber.',
   bakeoff_oven_chamber_event_type_descr VARCHAR(250)     NOT NULL COMMENT 'The description for the type of the event in an oven chamber.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REF_BAKEOFF_OVEN_CHAMBER_EVENT_TYPE PRIMARY KEY (bakeoff_oven_chamber_event_type_cd) NOT ENFORCED 
)  COMMENT = 'The table contains information regarding the type of events that are reported from an Oven Chamber.';
