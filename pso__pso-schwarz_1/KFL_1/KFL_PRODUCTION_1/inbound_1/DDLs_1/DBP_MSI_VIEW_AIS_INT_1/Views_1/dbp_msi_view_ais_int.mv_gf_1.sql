CREATE OR REPLACE VIEW dbp_msi_view_ais_int.mv_gf_1
(
gf_id
, gf_name
, mandant_id
, ek_flg
)
AS
SELECT
gf_id,
gf_name,
mandant_id,
ek_fg
FROM dbp_view.v_gf_1
WHERE ek_fg = 0;