-- prescherad SPEC0142410 erweitern um wo_dat_von und wo_dat_bis
CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WOCHE_1
(
kjwo
,gjwo
,kjwo_vj
,kjwo_vvj
,gjwo_vj
,wo_dat_von 
,wo_dat_bis
,akt_wo_kalendarisch
,akt_wo
,kj
,gj
)
AS
   SELECT
   kjwo, gjwo, kjwo_vj, kjwo_vvj, gjwo_vj, wo_dat_von, wo_dat_bis,akt_wo_kalendarisch, akt_wo, CAST (SUBSTR(TRIM(kjwo), 0, 4) AS SMALLINT), CAST (SUBSTR(TRIM(gjwo), 0, 4) AS SMALLINT)

   FROM dbp_view.v_woche_1
   WHERE kjwo > 200152;