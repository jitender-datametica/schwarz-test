CREATE OR REPLACE DYNAMIC TABLE dbp_msi_view_ais_int.mv_art_gp_aktuell_1
-- SPEC0122828 Anpassung art_gp_zu_per_1 -> art_gp_nm_zu_per_1/richternic
(
  art_id
, akt_gp_id
, mandant_id
, wup_id
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
art_id,
gp_id,
mandant_id,
wup_id
FROM dbp_view.v_art_gp_nm_zu_per_1
WHERE  dat_bis = '9999-12-31'
GROUP BY 1,2,3,4;




