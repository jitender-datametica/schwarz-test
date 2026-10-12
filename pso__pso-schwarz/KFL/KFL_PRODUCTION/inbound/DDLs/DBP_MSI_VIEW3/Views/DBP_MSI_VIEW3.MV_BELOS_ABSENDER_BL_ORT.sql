CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_ABSENDER_BL_ORT
-- 22.05.2018 srom0404, aufbau analog Abholland, Abholort, Abhol PLZ
(
land_id
,ort
)
AS
   SELECT land_id, ort
   FROM dbp_view.v_belos_adresse
   --Transportdienstleister werden nicht berücksichtigt.
   WHERE spedition_fg = 0
   GROUP BY land_id
   ,ort;