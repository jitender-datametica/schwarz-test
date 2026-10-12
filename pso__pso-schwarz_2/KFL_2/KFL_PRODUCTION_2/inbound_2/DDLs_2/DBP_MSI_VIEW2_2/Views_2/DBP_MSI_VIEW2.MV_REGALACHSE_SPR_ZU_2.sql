CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_REGALACHSE_SPR_ZU_2
(
mandant_id
,fbb_nr
,spr_id
,regalachse_bez
,dat_bis_neu
)
AS
   SELECT
  r.mandant_id, r.fbb_nr, l.spr_id, l.layoutbaustein_bez, CASE WHEN SUBSTR(fbb_nr, 1, 4) >= 'P150' AND dat_bis <> '9999-12-31' THEN dat_bis +150 ELSE dat_bis END AS dat_bis_neu

   FROM dbp_view.v_regalachse_2  r
   INNER JOIN dbp_view.v_layoutbaustein_spr_zu_2 l
   ON r.mandant_id= l.mandant_id AND
   r.layoutbaustein_id = l.layoutbaustein_id

   WHERE r.mandant_id =1
   --  Nur  aktuelle Regalachsen sollen angezeigt werden, dat_bis >= DATE
   AND dat_bis_neu >= CURRENT_DATE
   QUALIFY ROW_NUMBER() OVER (PARTITION BY r.mandant_id,r.fbb_nr ORDER BY dat_bis_neu DESC NULLS LAST) = 1;