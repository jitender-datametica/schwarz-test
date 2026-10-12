CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_PRICE_SCENARIO_1
(
     mdm_price_scenario_nr
     ,mdm_price_type_cd
     ,lob_cd 
     ,market_sid
     ,incoterm_cd
     ,dwh_load_id
     ,dwh_created
     ,dwh_updated
)
AS
   SELECT
     mdm_price_scenario_nr
     ,mdm_price_type_cd
     ,lob_cd 
     ,market_sid
     ,incoterm_cd
     ,dwh_load_id
     ,dwh_created
     ,dwh_updated
  FROM p_lew_core.t_mdm_price_scenario_1 ;

     

         