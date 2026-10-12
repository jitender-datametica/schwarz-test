CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_VW_LIST_ZU_1
-- AP0009229 Ausbau vw_id - sschuecke 28.09.2016
(
art_id
,  mandant_id
,  list_durchg_fg

)
AS
   SELECT
   lsl.art_id,  lsl.mandant_id,  MAX(lsl.list_durchg_fg)
   FROM dbp_view.v_sternchen_logik_1 AS lsl
   WHERE lsl.mandant_id = 1
   AND CURRENT_DATE BETWEEN lsl.dat_von AND lsl.dat_bis
   GROUP BY 1,2;