CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_MDM_SUPPLIER_SUBSIDIARY_HIST_1
(
    client_id
    , mdm_sup_sid
    , addr_sid
    , sup_subsidiary_seq_nr
    , subsidiary_name
    , default_fg
    , active_fg
    , vat_nr
    , eks_sup_nr
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
)
AS
   SELECT
       client_id
    , mdm_sup_sid
    , addr_sid
    , sup_subsidiary_seq_nr
    , subsidiary_name
    , default_fg
    , active_fg
    , vat_nr
    , eks_sup_nr
    , deleted_fg
    , dwh_valid_from
    , dwh_valid_to
    , dwh_load_id
    , dwh_created
    , dwh_updated
  FROM P_LEW_CORE.T_MDM_SUPPLIER_SUBSIDIARY_HIST_1 ;