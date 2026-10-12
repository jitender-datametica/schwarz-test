/* --------------------------------------------------------------------------------
   DDL for table: t_channel_instance
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:10 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_channel_instance (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
channel_inst_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='unique identifier of the channel instance (surrogate key)'),
channel_type_cd STRING(5) COLLATE 'und:ci'
OPTIONS(description='The code for the subtype discriminator for channels. It distinguishes between sales channels and communication channels.'),
channel_inst_nr STRING(20) COLLATE 'und:ci' OPTIONS(description='A code uniquely identifying a channel instance'),
channel_inst_name STRING(100) COLLATE 'und:ci' OPTIONS(description='the name of the channel instance'),
channel_sid BIGNUMERIC(38,0)
OPTIONS(description='unique identifier of the channel to which the channel instance belongs to'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (channel_inst_sid) NOT ENFORCED
)
OPTIONS(description='A channel instance is a specific channel used to interact with other Parties. Channels may be used for various purposes, e.g. as communication channels or sales channels.');