CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_RUECK_GRUND_2
-- AP0002469, 13.01.2016, srom0404, UNION auf -1 (nicht jede Rückführung hat einen Grund)
-- in der View mv_rueckfuehrung_lt_2 ist entsprechend COALESCE mit -1 eingebaut
-- in der View mv_rueck_grund_spr_zu_2 ist entsprechend UNION auf -1 eingebaut
(
rueck_grund_id
,mandant_id
)
AS
   SELECT
   v01.rueck_grund_id, v01.mandant_id
   FROM dbp_view.v_l_rueck_grund_2 v01

   UNION

   SELECT
   -1 AS rueck_grund_id, mandant_id
   FROM dbp_view.v_mandant_2;