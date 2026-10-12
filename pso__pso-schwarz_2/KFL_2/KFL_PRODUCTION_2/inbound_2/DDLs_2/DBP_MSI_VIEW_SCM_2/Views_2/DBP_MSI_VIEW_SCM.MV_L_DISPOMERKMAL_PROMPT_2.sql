CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_l_dispomerkmal_prompt_2
AS
SELECT v01.dispomerkmal
FROM DBP_VIEW.v_l_dispomerkmal_2 v01
GROUP BY v01.dispomerkmal;