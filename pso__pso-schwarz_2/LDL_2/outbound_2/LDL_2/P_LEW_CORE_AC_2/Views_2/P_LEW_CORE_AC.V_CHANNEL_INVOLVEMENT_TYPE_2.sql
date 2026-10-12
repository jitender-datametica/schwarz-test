CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_channel_involvement_type_2 (channel_involvement_type_cd
OPTIONS(description='The code identifying the way, how the own organization is involved in the market research channel. Lidl can be included in the channel, Lidl may not be part of the channel, the channel may represent Lidl only or the channel is not applicable for Lidl.'),
channel_involvement_type_descr
OPTIONS(description='A textual description for the way, how the own organization is involved in the market research channel.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'))
OPTIONS(DESCRIPTION = `THIS MINOR ENTITY DEFINES THE WAY, HOW THE OWN ORGANIZATION IS INVOLVED IN THE MARKET RESEARCH CHANNEL. LIDL CAN BE INCLUDED IN THE CHANNEL, LIDL MAY NOT BE PART OF THE CHANNEL, THE CHANNEL MAY REPRESENT LIDL ONLY OR THE CHANNEL IS NOT APPLICABLE FOR LIDL.`)
AS SELECT channel_involvement_type_cd,
 channel_involvement_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_channel_involvement_type_2;