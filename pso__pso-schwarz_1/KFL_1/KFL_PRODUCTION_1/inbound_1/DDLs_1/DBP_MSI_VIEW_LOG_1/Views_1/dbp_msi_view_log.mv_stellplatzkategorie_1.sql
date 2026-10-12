CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_STELLPLATZKATEGORIE_1(
	STELLPLATZKATEGORIE,
	ANZ_STELLPLATZ_VON,
	ANZ_STELLPLATZ_BIS
) AS
--2022-12-21, AP0140953, SPEC0164166,dknop, initial 
SELECT DISTINCT
 stellplatzkategorie
,anz_stellplatz_von
,anz_stellplatz_bis

FROM dbp_msi_v_view.v_ts_l_stellplatzkategorie_1;