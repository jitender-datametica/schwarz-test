CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_L_STATUS_LADTRAEGER_1
(

mandant_id
, status_ladtraeger

)
AS
   SELECT
   mandant_id, status_ladtraeger

   FROM dbp_view.v_l_status_ladtraeger_1
;