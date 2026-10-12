CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BELOS_ABSENDER_BL_PLZ_1
-- 22.05.2018 srom0404, aufbau analog Abholland, Abholort, Abhol PLZ
(
land_id
,ort
,plz
)
AS
   SELECT land_id, ort, CAST(plz AS VARCHAR(10)) AS plz
   FROM dbp_view.v_belos_adresse_1
   --Transportdienstleister werden nicht berücksichtigt.
   WHERE spedition_fg = 0
   GROUP BY land_id
   ,ort
   ,plz;