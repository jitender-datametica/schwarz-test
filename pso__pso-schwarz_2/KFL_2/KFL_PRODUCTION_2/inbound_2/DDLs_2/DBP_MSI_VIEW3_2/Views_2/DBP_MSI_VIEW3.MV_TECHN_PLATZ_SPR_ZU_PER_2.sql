CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TECHN_PLATZ_SPR_ZU_PER_2 (
   techn_platz_id,
   spr_id,
   dat_von,
   dat_bis,
   tech_platz_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.techn_platz_id,
   v01.spr_id,
   v01.dat_von,
   v01.dat_bis,
   v01.tech_platz_bez
FROM
   dbp_view.v_techn_platz_spr_zu_per_2 v01
   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id
WHERE
   v01.dat_bis = '9999-12-31';