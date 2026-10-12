CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_RUECKFUEHRUNG_LT_GRUND_2 (mandant_id,tour_id,wup_id, rueckfuehrung_wup_id, ruckfuhrung_fg)
--12.05.2021  SPEC0113162, AP0091617, dknop, initiale Anlage_2
--24.05.2021  SPEC0113162, AP0091617, dknop, rueckfuehrung_wup_id
AS
SELECT
v1.mandant_id
,v1.tour_id
,v1.wup_id
,v2.wup_id as rueckfuehrung_wup_id
,CASE WHEN v2.tour_id is not null THEN  '1' else '0' END as ruckfuhrung_fg
FROM
(SELECT
mandant_id
,wup_id
,tour_id
,dat_tour
FROM dbp_view.v_tour_2
group by  
mandant_id
,wup_id
,tour_id
,dat_tour)v1
left join (SELECT
mandant_id
,tour_id
,wup_id_lager
,wup_id
FROM dbp_view.v_rueckfuehrung_lt_2 group by  mandant_id, tour_id,wup_id_lager, wup_id) v2 
on v1.tour_id = v2.tour_id 
and v1.mandant_id=v2.mandant_id
and v1.wup_id=v2.wup_id_lager
;