CREATE OR REPLACE VIEW P_LEW_MART_CM_AC.V_LIL_PERIOD_SEQUENCE
(
  client_id
, per_id
, per_text
, per_text_EN
, per_lvl
, seq_lift
, seq_gl
)
AS
SELECT
  client_id
, per_id
, per_text
, per_text_EN
, per_lvl
, seq_lift
, seq_gl
FROM P_LEW_MART_CM.V_LIL_PERIOD_SEQUENCE;

