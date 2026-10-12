
CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_TOUR
AS
SELECT DISTINCT
mandant_id,
wup_id,
tour_id
FROM dbp_view.v_rueckfuehrung_lt;


