/* --------------------------------------------------------------------------------
   DDL for table: t_channel_involvement_type
   generated from Powerdesigner on Dienstag, 6. Mai 2025 11:46:00
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_CHANNEL_INVOLVEMENT_TYPE (
   channel_involvement_type_cd         VARCHAR(100)     NOT NULL COMMENT 'The code identifying the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.',
   channel_involvement_type_descr      VARCHAR(250)     COMMENT 'A textual description for the way, how the own organization is involved in the market research channel.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.',   
   CONSTRAINT PK_T_CHANNEL_INVOLVEMENT_TYPE PRIMARY KEY (channel_involvement_type_cd) NOT ENFORCED 
)  COMMENT = 'This minor entity defines the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.';
