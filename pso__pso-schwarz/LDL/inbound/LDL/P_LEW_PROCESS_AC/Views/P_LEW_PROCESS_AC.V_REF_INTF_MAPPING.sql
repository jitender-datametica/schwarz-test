CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_REF_INTF_MAPPING
(
    app_name
    , pset
    , interface_key
    , system_key
)
AS
SELECT
app_name,
pset,
interface_key,
system_key
FROM p_lew_process.t_ref_intf_mapping ;


