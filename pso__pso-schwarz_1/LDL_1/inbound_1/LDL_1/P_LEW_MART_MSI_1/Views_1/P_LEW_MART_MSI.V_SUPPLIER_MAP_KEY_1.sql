CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SUPPLIER_MAP_KEY_1
(
client_id
, sup_sid
, dwh_sup_id
, dwh_orig_supplier_nr
, elwis_dwh_ec_cd
, elwis_dwh_sup_sid
, elwis_dwh_sup_id
, wawi_dwh_client_id
, wawi_dwh_supplier_id
, wawi_dwh_orig_supplier_nr
, active_fg
, source_cd
, dwh_create
, dwh_upd
, dwh_load_id
 )
AS

select 
    client_id,
    sup_sid,
    dwh_sup_id,
    dwh_orig_supplier_nr,
    elwis_dwh_ec_cd,
    elwis_dwh_sup_sid,
    elwis_dwh_sup_id,
    wawi_dwh_client_id,
    wawi_dwh_supplier_id,
    wawi_dwh_orig_supplier_nr,
    active_fg,
    source_cd,
    dwh_create,
    dwh_upd,
    dwh_load_id
from p_lew_core_ac.v_supplier_map_key_1; 