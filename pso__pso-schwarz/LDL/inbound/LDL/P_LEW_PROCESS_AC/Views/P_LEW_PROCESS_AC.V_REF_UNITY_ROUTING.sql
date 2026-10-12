CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_REF_UNITY_ROUTING
               (
                   MsiRepName
                   ,MsiRepId
                   ,MsiPath
               )
               AS
                  SELECT
                      MsiRepName,
                  MsiRepId,
                  MsiPath
                  FROM p_lew_process.t_ref_unity_routing
;