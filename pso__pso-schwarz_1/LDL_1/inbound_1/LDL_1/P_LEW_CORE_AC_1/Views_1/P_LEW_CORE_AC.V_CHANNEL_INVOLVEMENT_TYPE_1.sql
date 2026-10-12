CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_CHANNEL_INVOLVEMENT_TYPE_1 (
   channel_involvement_type_cd              COMMENT 'The code identifying the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.'
  ,channel_involvement_type_descr           COMMENT 'A textual description for the way, how the own organization is involved in the market research channel.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entity defines the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.'
 AS 
    SELECT 
        channel_involvement_type_cd,
        channel_involvement_type_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_CHANNEL_INVOLVEMENT_TYPE_1 ;