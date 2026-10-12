/* --------------------------------------------------------------------------------
   DDL for table: t_channel_instance_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CHANNEL_INSTANCE_2 (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the DWH client / slice',
   channel_inst_sid                    NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the channel instance (surrogate key)',
   channel_type_cd                     VARCHAR(5)       COLLATE 'en-ci' COMMENT 'The code for the subtype discriminator for channels. It distinguishes between sales_2 channels and communication_2 channels.',
   channel_inst_nr                     VARCHAR(20)      COLLATE 'en-ci' COMMENT 'A code uniquely identifying a channel instance',
   channel_inst_name                   VARCHAR(100)     COLLATE 'en-ci' COMMENT 'the name of the channel instance',
   channel_sid                         NUMBER(38,0)     COMMENT 'unique identifier of the channel to which the channel instance belongs to',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',   
   CONSTRAINT PK_T_CHANNEL_INSTANCE PRIMARY KEY (channel_inst_sid) NOT ENFORCED 
)  COMMENT = 'A channel instance is a specific channel used to interact with other Parties. Channels may be used for various purposes, e.g. as communication_2 channels or sales_2 channels.';

