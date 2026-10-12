
CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_TOUR_2
AS
SELECT DISTINCT
mandant_id,
wup_id,
tour_id
FROM dbp_view.v_rueckfuehrung_lt_2;


