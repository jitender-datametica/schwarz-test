CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_SAULE_CONFIG_COMMENTS
(
  comments
, sort
, sort2
)
AS
   SELECT
     comments,
   sort,
   sort2
  FROM p_lew_process_mstr.t_saule_config_comments
;