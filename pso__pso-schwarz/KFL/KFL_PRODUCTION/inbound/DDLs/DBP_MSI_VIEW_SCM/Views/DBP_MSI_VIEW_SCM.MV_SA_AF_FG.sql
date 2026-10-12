CREATE OR REPLACE VIEW dbp_msi_view_scm.mv_sa_af_fg
-- 2021-04-15, AP0068964, srom0404, switch the sa_af_fg type to byteint (no apostrophe)
AS
SELECT
*
FROM (SELECT
Cast(-1 AS BYTEINT) AS sa_af_fg,
'Alle (DIF)' AS sa_af_fg_bez) t2
UNION
SELECT
*
FROM (SELECT
Cast(1 AS BYTEINT) AS sa_af_fg,
'SA' AS sa_af_fg_bez) t1 UNION
SELECT
*
FROM (SELECT
Cast(0 AS BYTEINT) AS sa_af_fg,
'AF' AS sa_af_fg_bez) t0;
