CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_MDM_INCOTERM
(
      market_sid
    , mdm_incoterm_cd
    , mdm_incoterm_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
    market_sid
   , mdm_incoterm_cd
   , mdm_incoterm_name
   , dwh_load_id
   , dwh_created
   , dwh_updated
  FROM P_LEW_CORE.T_REF_MDM_INCOTERM ;