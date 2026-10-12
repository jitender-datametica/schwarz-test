CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_L_GP_2
(
	GP_ID,
	MANDANT_ID,
	GP_NAME,
	DAT_VON,
	DAT_BIS
) AS
--22.06.2022 twie: SPEC0145413 Lookup Lieferant
--26.01.2023 twie: SPEC0181015 wenn gp_id < 1 dann gp_name leer

SELECT

    v01.gp_id
   ,v01.mandant_id
   ,CASE WHEN v01.gp_id >= 1 THEN v01.gp_name ELSE NULL END AS gp_name
   ,dat_von
   ,dat_bis

FROM dbp_view.v_gp_2 v01;