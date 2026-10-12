CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_ABSENDER_BL_LAND
-- 22.05.2018 srom0404, aufbau analog Abholland, Abholort, Abhol PLZ
(
land_id
)
AS
   SELECT land_id
   FROM dbp_view.v_belos_adresse
   --Transportdienstleister werden nicht berücksichtigt.
   WHERE spedition_fg = 0
   GROUP BY land_id;