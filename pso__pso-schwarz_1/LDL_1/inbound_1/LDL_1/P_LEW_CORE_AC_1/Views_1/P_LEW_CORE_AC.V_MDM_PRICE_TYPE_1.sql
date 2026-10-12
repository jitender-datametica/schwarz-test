CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_PRICE_TYPE_1
(
     mdm_price_type_cd
     ,mdm_price_type_name
     ,mdm_price_type_descr
     ,lob_fg
     ,market_fg
     ,incoterm_fg
     ,int_org_fg
     ,dwh_load_id
     ,dwh_created
     ,dwh_updated
)
AS
   SELECT
     mdm_price_type_cd
     ,mdm_price_type_name
     ,mdm_price_type_descr
     ,lob_fg
     ,market_fg
     ,incoterm_fg
     ,int_org_fg
     ,dwh_load_id
     ,dwh_created
     ,dwh_updated
  FROM p_lew_core.t_mdm_price_type_1 ;

     

