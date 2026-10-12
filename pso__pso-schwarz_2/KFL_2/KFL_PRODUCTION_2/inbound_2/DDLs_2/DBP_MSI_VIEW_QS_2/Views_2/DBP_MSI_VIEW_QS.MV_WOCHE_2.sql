CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_WOCHE_2
(
gjwo
, gjwo_vj
, kjwo
, kjwo_vj
, wo_dat_von
, wo_dat_bis
, akt_wo
, akt_wo_komplett
, kw
, kw_von_bis
)
AS
SELECT
v01.gjwo
, v01.gjwo_vj
, v01.kjwo
, v01.kjwo_vj
, v01.wo_dat_von
, v01.wo_dat_bis
, v01.akt_wo
, v01.akt_wo_komplett
, TRIM(MOD(v01.kjwo, 100)) AS kw
, TRIM(MOD(v01.kjwo, 100) || ' (' || 
       TO_NUMBER(TRIM(EXTRACT(DAY FROM v01.wo_dat_von)), '00') || '.' || 
       TO_NUMBER(TRIM(EXTRACT(MONTH FROM v01.wo_dat_von)), '00')|| '.-' || 
       TO_NUMBER(TRIM(EXTRACT(DAY FROM v01.wo_dat_bis)), '00')|| '.' || 
       TO_NUMBER(TRIM(EXTRACT(MONTH FROM v01.wo_dat_bis)), '00')|| '.)') AS kw_von_bis

FROM dbp_view.v_woche_2 v01;