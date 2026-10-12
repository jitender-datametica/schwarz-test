CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ART_GP_ZU_PER 
--EK-3441420 MuKI wird in neue View mv_art_muki_ek verlagert, da doppelte GP
-- SPEC0122828 Anpassung art_gp_zu_per -> art_gp_nm_zu_per/richternic
(
   art_id,
   gp_id,
   mandant_id,
   wup_id,
   aktuell_fg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
   art_id,
   gp_id,
   mandant_id,
   wup_id,
   CASE
      WHEN dat_bis = '9999-12-31' THEN 'a'
      ELSE 'h'
   END AS aktuell_fg
FROM
   dbp_view.v_art_gp_nm_zu_per QUALIFY SUM(1) OVER (
      PARTITION BY art_id,
      gp_id,
      mandant_id
      ORDER BY
         dat_bis DESC NULLS LAST ROWS UNBOUNDED PRECEDING
   ) = 1;