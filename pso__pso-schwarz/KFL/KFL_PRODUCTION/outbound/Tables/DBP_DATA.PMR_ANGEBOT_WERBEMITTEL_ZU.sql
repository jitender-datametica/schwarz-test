CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pmr_angebot_werbemittel_zu (
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant im DWH'),
angebot_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='aus TableName wbs_werbeaenderungen Offer/Angebot'),
werbemittel_art_id STRING(4) OPTIONS(description='Werbemittel Art ID'),
werbemittel_id BIGNUMERIC(38,0) OPTIONS(description='Werbemittel ID '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='ZPMR_EOP_TACTIC_TYPE_TACTIC_TT/Funktionsbaustein Interface PMR to WBS  Exporting Values');