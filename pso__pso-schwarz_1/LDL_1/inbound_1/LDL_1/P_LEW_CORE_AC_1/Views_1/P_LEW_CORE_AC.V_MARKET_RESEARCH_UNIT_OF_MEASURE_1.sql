CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MARKET_RESEARCH_UNIT_OF_MEASURE_1 (
   market_research_uom_cd                   COMMENT 'The code which identifies the way, how a metric is measured.'
  ,market_research_uom_descr                COMMENT 'A textual description for the way, how a metric is measured.'
  ,dwh_load_id                              COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.'
  ,dwh_created                              COMMENT 'Creation timestamp of the record in the DWH.'
  ,dwh_updated                              COMMENT 'Timestamp of the last update of the record in the DWH. Timestamp of the last business related(!) change.'
)
COMMENT = 'This minor entity defines the way, how a metric is measured, i.e. as an amount in a given currency, as a count or as a quantity'
 AS 
    SELECT 
        market_research_uom_cd,
        market_research_uom_descr,
        dwh_load_id,
        dwh_created,
        dwh_updated

FROM P_LEW_CORE.T_MARKET_RESEARCH_UNIT_OF_MEASURE_1 ;